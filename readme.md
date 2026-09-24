Pandoc + lualatex settings for generating collage lab work reports from markdown

**TODO:**
- Figure out required latex packages (except pandoc and luatex) for reproducing setup
- Fix table formatting (add vertical lines, make heading bold)

To compile pdf run:  
```shell
pandoc -o report.pdf report.md --pdf-engine=lualatex --template ./template.latex
```
