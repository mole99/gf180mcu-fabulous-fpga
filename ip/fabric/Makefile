PDK ?= gf180mcuD
PDK_ROOT ?= ~/.ciel

# A rule for all tiles
fabric:
	librelane --pdk ${PDK} config.yaml
.PHONY: fabric

fabric-openroad:
	librelane --pdk ${PDK} config.yaml --last-run --flow OpenInOpenROAD
.PHONY: fabric-openroad

fabric-klayout:
	librelane --pdk ${PDK} config.yaml --last-run --flow OpenInKLayout
.PHONY: fabric-klayout
