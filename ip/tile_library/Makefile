MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PDK ?= gf180mcuD
PDK_ROOT ?= ~/.ciel
#$(MAKEFILE_DIR)/../../gf180mcu

TILES = S_term_single N_term_single S_term_single2 N_term_single2 S_term_DSP N_term_DSP LUT4AB W_IO N_IO S_WARMBOOT RegFile DSP IHP_SRAM N_term_IHP_SRAM S_term_IHP_SRAM S_WARMBOOT RegFile
TILE_DIR = tiles

TILE_PATHS := $(addprefix $(TILE_DIR)/,$(TILES))
TILE_PATHS_OPENROAD := $(addsuffix -openroad,$(TILE_PATHS))
TILE_PATHS_KLAYOUT := $(addsuffix -klayout,$(TILE_PATHS))

$(info $(TILE_PATHS))

# A rule for all tiles
$(TILE_PATHS):
	librelane --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk common.yaml $@/config.yaml
.PHONY: $(TILE_PATHS)

$(TILE_PATHS_OPENROAD):
	librelane --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk common.yaml $(subst -openroad,,$@)/config.yaml --last-run --flow OpenInOpenROAD
.PHONY: $(TILE_PATHS_OPENROAD)

$(TILE_PATHS_KLAYOUT):
	librelane --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk common.yaml $(subst -klayout,,$@)/config.yaml --last-run --flow OpenInKLayout
.PHONY: $(TILE_PATHS_KLAYOUT)

boundary-tiles: $(TILE_DIR)/W_IO $(TILE_DIR)/N_IO $(TILE_DIR)/S_CPU_IF $(TILE_DIR)/S_CPU_IRQ $(TILE_DIR)/S_WARMBOOT
.PHONY: termination-tiles

termination-tiles: $(TILE_DIR)/S_term_single $(TILE_DIR)/N_term_single $(TILE_DIR)/S_term_single2 $(TILE_DIR)/N_term_single2 $(TILE_DIR)/S_term_DSP $(TILE_DIR)/N_term_DSP
.PHONY: termination-tiles

all-tiles: $(TILE_PATHS)
.PHONY: all-tiles
