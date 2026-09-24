DST_DIR := ~/.local/share/pandoc

default: copy

.PHONY: copy
copy: dirs
	@cp -fv lr-report.latex ${DST_DIR}/templates/lr-report.latex
	@cp -fv lr-report.yaml ${DST_DIR}/defaults/lr-report.yaml

.PHONY: dirs
dirs:
	mkdir -p ${DST_DIR}/defaults
	mkdir -p ${DST_DIR}/templates
