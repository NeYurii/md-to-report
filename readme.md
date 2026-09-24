# Overview

Pandoc + lualatex settings for generating college lab work reports from markdown

To compile pdf run:  
```shell
pandoc -o report.pdf report.md --pdf-engine=lualatex --template ./template.latex
```

# TODO

- Figure out required latex packages (except pandoc and luatex) for reproducing setup
- Fix table formatting (add vertical lines, make heading bold)

# Reference

- [LaTex wiki](https://www.overleaf.com/learn)
- [KOMA Script documentation](https://ctan.uni-eszterhazy.hu/tex-archive/macros/latex/contrib/koma-script/doc/scrguide-en.pdf#desc%3Amaincls.cmd.setkomafont)
- [Pandoc manual](https://pandoc.org/MANUAL.html)
- [Pandoc latex templates](https://pandoc-templates.org)
- Other latex packages documentation can be found from [CTAN](https://ctan.org/pkg)
