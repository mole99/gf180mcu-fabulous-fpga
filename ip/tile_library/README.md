# FABulous Tiles

This repository hosts tiles for the [FABulous](https://github.com/FPGA-Research/FABulous) framework and configuration files in order to harden them with the [FABulous LibreLane plugin](https://github.com/mole99/librelane_plugin_fabulous).

Enable the plugin and harden all tiles using `make` or harden individual tiles using e.g. `make tiles/LUT4AB`.

> [!IMPORTANT]
> For documentation about the primitives of the tiles, please see the [README](docs/README.md) in the docs.

## Custom Tiles

The custom tiles created for special use.

| Name           | Description |
|----------------|-------------|
| S_OBI           | Open Bus Interface to implement a peripheral |
| S_XIF           | Custom instruction interface |
| S_CPU_IF       | 16 inputs and 16 output to the CPU domain |
| S_CPU_IRQ      | 4 IRQs to the CPU domain |
| S_WARMBOOT     | Trigger fabric reconfiguration from the selected slot, provides a `RESET` signal |
| IHP_SRAM        | Single-ported SRAM 32-bit wide, 4 KiB deep |
| IHP_BRAM        | Dual-ported BRAM 16-bit wide, 4 KiB deep |
| N_term_IHP_SRAM | Termination tile for IHP_SRAM |
| S_term_IHP_SRAM | Termination tile for IHP_SRAM |
| N_IO           | IO tile for the north side |
| E_IO           | IO tile for the east side |
| S_IO           | IO tile for the south side |

## Default Tiles

Some of the default tiles provided by FABulous.

| Name           | Description |
|----------------|-------------|
| DSP            | DSP tile for MAC |
| LUT4AB         | Tile with two bels of 4 LUT and FF each |
| RegFile        | Register file 1w1r1r  |
| N_term_DSP     | Termination tile for DSP     |
| N_term_single  | Termination tile for LUT4AB  |
| N_term_single2 | Termination tile for RegFile |
| S_term_DSP     | Termination tile for DSP     |
| S_term_single  | Termination tile for LUT4AB  |
| S_term_single2 | Termination tile for RegFile |
| W_IO           | IO tile for the west side |

## License

FABulous Tiles is licensed under the Apache 2.0 license.
