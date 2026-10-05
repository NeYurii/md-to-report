DATA_DIR := ~/.local/share/pandoc
DEFAULTS_DIR := ${DATA_DIR}/defaults
TEMPLATES_DIR := ${DATA_DIR}/templates
FILTERS_DIR := ${DATA_DIR}/filters

default: copy

.PHONY: copy
copy:
	install -m 644 -D -t ${TEMPLATES_DIR} fkze-report.html
	install -m 644 -D -t ${DEFAULTS_DIR} fkze-report.yaml
	install -m 644 -D -t ${FILTERS_DIR} include-files.lua
