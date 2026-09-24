# Overview

Pandoc + lualatex settings for generating college lab work reports from markdown

# Installing

Run `make`

# Usage

Use `test/report.md` as reference, most variables in header there are mandatory

To compile pdf from markdown:  

```shell
pandoc -o report.pdf report.md --defaults=lr-report
```

Without installation:

```shell
pandoc -o report.pdf report.md --template=./lr-report.latex --defaults=./lr-report.yaml
```

# TODO

- Figure out required latex packages (except pandoc and luatex) for reproducing setup
- Fix table formatting (make heading bold)

# Reference

- [LaTex wiki](https://www.overleaf.com/learn)
- [KOMA Script documentation](https://ctan.uni-eszterhazy.hu/tex-archive/macros/latex/contrib/koma-script/doc/scrguide-en.pdf#desc%3Amaincls.cmd.setkomafont)
- [Pandoc manual](https://pandoc.org/MANUAL.html)
- [Pandoc latex templates](https://pandoc-templates.org)
- [common.latex() content](https://github.com/jgm/pandoc-templates/blob/master/common.latex)
- Other latex packages documentation can be found from [CTAN](https://ctan.org/pkg)
