return {
    Table = function(tbl)
        for _, row in ipairs(tbl.head.rows) do
            for _, cell in ipairs(row.cells) do
                cell.content = cell.content:walk{Str = pandoc.Strong}
            end
        end
        return tbl;
    end,
}
