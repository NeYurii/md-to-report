--[[
    tables-vrules - adds vertical rules to tables for latex output

    Original source: https://github.com/chrisaga/hk-pandoc-filters
    Copyright:       © 2026 NeYurii <yuriizkhr@gmail.com>
    License:         MIT
    Credits:         marijnschraagen for the original Latex hack,
                     Christophe Agathon for extending the hack,
                     Mistrall for adding multirow tables support
    Output:          latex, pdf.
--]]

local List = require 'pandoc.List'

-- local vars = {}

-- Get vars from metadata
function get_vars(meta)
    -- vars.vrules = meta['tables-vrules']
    -- vars.hrules = meta['tables-hrules']
end

function repl_midrules(m1, m2)
    if m2:match('^\\[%w]+rule') then
        -- don't double the rule
        return m1 .. m2
    else
        return m1 .. '\\midrule\n' .. m2
    end
end

-- Fix individual column definition :
--  add right vertical rule
--  adjust width for column separtion and rule width
function fix_coldef(m1, m2)
    --- At some point (pandoc v3.4 or before) \columnwidth became \linewidth
    n=m2:match('%(\\columnwidth %- ([%d%.]+)\\tabcolsep%)')
    if not n then
        n=m2:match('%(\\linewidth %- ([%d%.]+)\\tabcolsep%)')
    end

    return m1:gsub('[%d%.]+(\\tabcolsep)',
                   string.format('%d',n+2) .. '%1 - ' ..
                       string.format('%d',2+n/2) ..'\\arrayrulewidth') .. '|'
end

-- Fix "simple style" column definition
function fix_simplestyle(m1,m2,m3)
    return m1 .. m2:gsub('(.)','%1|') .. m3
end

-- Fix columns definitions for vertical rules
function fix_colsdefs(m)
    --return m:gsub('^{@{}', '{@{\\extracolsep{-\\arrayrulewidth}}|')
    --        :gsub('@{}}$', '}')
    return m:gsub('^{@{}', '{|')
        :gsub('@{}}$', '}')
        :gsub('(>%b{}%l(%b{}))', fix_coldef) -- rich style
        :gsub('({|)(%l+)(})', fix_simplestyle) -- simple style
end

-- Adjust minipage width for column separators
-- Substract \tabcolsep two times (left and rigth of the cell)
-- Minipages in one column cell don't need that since the \linewidth is OK
-- TODO: not needed anymore since pandoc 3.1.9
function adjust_minipage(m1, m2, m3)
    return m1 .. m2:gsub('}', ' - 2\\tabcolsep -2\\arrayrulewidth}')
        .. m3
end

-- Adjust width of p cell for column separators
-- Substract \tabcolsep two times (left and rigth of the cell)
-- Generated LaTeX is not optimized, but robust
function adjust_p(m1, m2)
    return m1 .. m2:gsub('}$', ' -2\\tabcolsep -2\\arrayrulewidth}')
end

-- Give some space to minipages between text and horizontal rule
function pad_minipage(m1, m2, m3)
    return m1 .. m2 .. '\\smallskip\n' .. m3
end

-- Fix multicolumn cells
-- '|' where pandoc suppressed the colsep (@{})
-- plus on the right of each one (avoiding '||')
function fix_multicol(command, coldef, content)
    return command .. coldef:gsub('@%b{}','|'):gsub('|?}$','|}')
        :gsub('(p)(%b{})', adjust_p)
        .. content
end

-----------------------------------------------------------------------
-- MULTIROW / MULTICOL SUPPORT
--
-- Pandoc emits cells spanning several rows as \multirow{n}{=}{...}
-- followed by empty cells in the continuation rows. Two problems:
--   1. \usepackage{multirow} is never added because by the time the
--      writer runs, tables are already RawBlocks (pandoc doesn't know
--      it needs the package) -> added in Meta() below.
--   2. A \midrule after every row cuts through the \multirow cell.
--      Continuation rows must use \cline on the columns that are NOT
--      covered by an ongoing row-span instead.
-----------------------------------------------------------------------

-- Count the columns of a column spec such as
--   {|>{\raggedright\arraybackslash}p{(\columnwidth - 6\tabcolsep)}|l|}
local function count_spec_columns(spec)
    local n = 0
    local i = 1
    local len = #spec
    while i <= len do
        local c = spec:sub(i, i)
        if c == '\\' then
            local cmd = spec:match('^\\(%w+)', i)
            if cmd then
                i = i + 1 + #cmd
                -- skip an optional star (\newline* etc.)
                if spec:sub(i, i) == '*' then i = i + 1 end
            else
                i = i + 1
            end
        elseif c == '>' or c == '<' or c == '!' or c == '@' then
            local arg = spec:match('^' .. c .. '(%b{})', i)
            if arg then
                i = i + 1 + #arg
            else
                i = i + 1
            end
        elseif c == 'p' or c == 'm' or c == 'b' then
            n = n + 1
            local arg = spec:match('^' .. c .. '(%b{})', i)
            if arg then
                i = i + 1 + #arg
            else
                i = i + 1
            end
        elseif c == 'l' or c == 'c' or c == 'r' then
            n = n + 1
            i = i + 1
        else
            i = i + 1
        end
    end
    return n
end

-- Split a row into cells on non-escaped '&'
local function split_cells(row)
    local cells = {}
    local cur = {}
    local escaped = false
    for ch in row:gmatch('.') do
        if escaped then
            escaped = false
            cur[#cur + 1] = ch
        elseif ch == '\\' then
            escaped = true
            cur[#cur + 1] = ch
        elseif ch == '&' then
            cells[#cells + 1] = table.concat(cur)
            cur = {}
        else
            cur[#cur + 1] = ch
        end
    end
    cells[#cells + 1] = table.concat(cur)
    return cells
end

-- Register row-spans started by cells of this row.
-- A cell can combine both spans:
--   \multicolumn{3}{..}{\multirow{2}{=}{...}}
local function update_spans(row, rownum, spans)
    local col = 1
    for _, cell in ipairs(split_cells(row)) do
        local cspan = tonumber(cell:match('\\multicolumn%{(%d+)%}')) or 1
        local rspan = tonumber(cell:match('\\multirow%{(%d+)%}')) or 1
        if rspan > 1 then
            spans[#spans + 1] = { c1 = col, c2 = col + cspan - 1,
                                  bottom = rownum + rspan - 1 }
        end
        col = col + cspan
    end
end

-- Horizontal rule to draw below row `rownum`:
-- \midrule when nothing is spanned below, otherwise
-- \cline's for every run of columns not covered by an active span.
local function rule_after(rownum, spans, ncols)
    local covered = {}
    local active = false
    for _, s in ipairs(spans) do
        if s.bottom > rownum then
            active = true
            for c = s.c1, s.c2 do covered[c] = true end
        end
    end
    -- prune spans that ended on this row
    for i = #spans, 1, -1 do
        if spans[i].bottom <= rownum then table.remove(spans, i) end
    end
    if not active then
        return '\\midrule\n'
    end
    local clines = {}
    local c = 1
    while c <= ncols do
        if not covered[c] then
            local a = c
            while c <= ncols and not covered[c] do c = c + 1 end
            clines[#clines + 1] = string.format('\\cline{%d-%d}\n', a, c - 1)
        else
            c = c + 1
        end
    end
    return table.concat(clines)
end

-- Replace the old "midrule after every row" gsub with a version that
-- understands \multirow: rows inside a row-span get \cline only.
local function add_hrules(env_content, ncols)
    if not ncols or ncols < 1 then
        -- Fallback to the old behaviour if we couldn't count columns
        return env_content:gsub('( \\\\\n)([\\%w]+)', repl_midrules)
    end
    local spans = {}
    local rownum = 0
    local out = {}
    local init = 1
    while true do
        local a, b = env_content:find(' \\\\\n', init, true)
        if not b then
            out[#out + 1] = env_content:sub(init)
            break
        end
        local piece = env_content:sub(init, a - 1)
        rownum = rownum + 1
        update_spans(piece, rownum, spans)
        -- Don't double an existing rule (pandoc's own \midrule before
        -- \endhead, \bottomrule, ...), as in the original filter.
        local nxt = env_content:match('^(\\[%w]+rule)', b + 1)
        local rest = env_content:sub(b + 1)
        if not nxt and rest:match('^[ \t\n]*$') then nxt = 'end' end
        local rule = nxt and '' or rule_after(rownum, spans, ncols)
        out[#out + 1] = piece .. ' \\\\\n' .. rule
        init = b + 1
    end
    return table.concat(out)
end

-----------------------------------------------------------------------
-- End MULTIROW support
-----------------------------------------------------------------------

-- Main filter function
function Table(table)
    local returned_list
    local begin_env, env_content, end_env

    --if not vars.vrules and not vars.hrules then return nil end

    if FORMAT:match 'latex' then

        -- Get latex code for the whole table
        begin_env, env_content, end_env =
            pandoc.write ( pandoc.Pandoc({table}),'latex' )
                :match('(\\begin{longtable}%b[]%b{})(.*)(\\end{longtable})')

        -- Rewrite column definition to add vertical rules if needed
        -- N.B. Pandoc suppresses left and right spacing with @{}
        --if vars.vrules then
            -- Fix columns definitions in longtable environment
            begin_env = begin_env:gsub('(%b{})$', fix_colsdefs)
            --print('#' .. begin_env ..'#')
            -- Fix multicol cells if any
            env_content=env_content:gsub('(\\multicolumn%b{})(%b{})(%b{})',
                                         fix_multicol)
        --end

        -- Add \midrules / \clines after each row, taking \multirow into
        -- account
        --if vars.hrules then
            local ncols = count_spec_columns(begin_env:match('%b{}$') or '')
            env_content = add_hrules(env_content, ncols)
            env_content = env_content
                :gsub('(\\begin{minipage}%b[])(%b{})(.*\\end{minipage})',
                      pad_minipage)
            --print('#' .. env_content ..'#')
        --end

        -- Return modified latex code as a raw block
        --
        returned_list = List:new{pandoc.RawBlock('tex',
                                                 begin_env .. env_content .. end_env)}
    end
    return returned_list
end

function Meta(meta)
    -- We have to add this since Pandoc doesn't because there are no
    -- table anymore in the AST. We converted them in RawBlocks

    --if not vars.vrules and not vars.hrules then return nil end
    includes = [[
%begin tables-vrules.lua
\usepackage{longtable,booktabs,array}
\usepackage{calc} % for calculating minipage widths
\usepackage{multirow} % for cells spanning several rows
% Correct order of tables after \paragraph or \subparagraph
\usepackage{etoolbox}
\makeatletter
\patchcmd\longtable{\par}{\if@noskipsec\mbox{}\fi\par}{}{}
\makeatother
% Allow footnotes in longtable head/foot
\IfFileExists{footnotehyper.sty}{\usepackage{footnotehyper}}{\usepackage{footnote}}
\makesavenoteenv{longtable}
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}
\renewcommand{\arraystretch}{1.3}
%end tables-vrules.lua
]]

    if meta['header-includes'] then
        table.insert(meta['header-includes'], pandoc.RawBlock('tex', includes))
    else
        meta['header-includes'] = List:new{pandoc.RawBlock('tex', includes)}
    end

    return meta
end

return {{Meta = get_vars}, {Table = Table}, {Meta = Meta}}
