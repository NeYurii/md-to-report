# Overview

Pandoc + lualatex settings for generating college lab work reports from markdown

## Installation

Depends on `pandoc` and `weasyprint`.  
To install templates run `make`

## Usage

To compile pdf from markdown:

```shell
pandoc -o report.pdf report.md --defaults=fkze-report
```

For formatting see `examples`

### For windows users

If you are using Windows, then dont do it. Install linux.

But if you are forced to use Windows and still wanna use this, then replace
- Liberation Serif to Times New Roman
- Liberation Sans to Arial
- Liberation Mono to Consolas

# Reference

- [WeasyPrint](https://weasyprint.org)
- [WeasyPrint samples](https://github.com/CourtBouillon/weasyprint-samples)
- I hope you are able to find html/css docs yourself
