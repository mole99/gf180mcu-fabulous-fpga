MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PDK_ROOT ?= $(MAKEFILE_DIR)/../../gf180mcu
PDK ?= gf180mcuD

all: logo drc
.PHONY: all

logo:
	python3 script/make_gds.py image/wafer_space_logo.png gds/gf180mcu_ws_ip__logo.gds --cellname gf180mcu_ws_ip__logo --invert --merge --pixel-size 0.75 --width 191 --height 191 --foreground "34/0" "36/0" "42/0" "46/0" "81/0" --boundary "0/0" "152/5"
.PHONY: logo

drc:
	PDK_ROOT=${PDK_ROOT} PDK=${PDK} klayout -b -zz -r ${PDK_ROOT}/${PDK}/libs.tech/klayout/tech/drc/gf180mcu.drc -rd input=gds/gf180mcu_ws_ip__logo.gds -rd report=report.lyrdb -rd feol=false -rd beol=true
.PHONY: drc
