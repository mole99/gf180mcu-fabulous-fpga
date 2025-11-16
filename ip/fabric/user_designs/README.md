## User Designs

| Name      | Description |
|-----------|-------------|
| `all_zeros` | all outputs set to zero |
| `all_ones`  | all outputs set to one |
| `counter`   | 32-bit counter |
| `counter_top`   | intended for top-level verification |
| `passthrough` | inputs connected to outputs |
| `sram` | all SRAMs muxed together for testing |
| `bram` | all BRAMs muxed together for testing |
| `peripheral` | simple peripheral (32x32 r/w registers) |
| `peripheral_sram` | all SRAMs/BRAMs available as peripheral |
| `custom_instruction` | custom instruction extension (32-bit addition) |
| `trigger_irq` | trigger an IRQ after a few cycles |
| `trigger_slot0` | trigger warmboot reconfiguration to slot 0 after a few cycles |
| `trigger_slot1` | trigger warmboot reconfiguration to slot 1 |
| `serv` | [SERV](https://github.com/olofk/serv) in 4-bit configuration with CSRs enabled on servant, 4 kByte memory |
| `fazyrv` | [FazyRV](https://github.com/meiniKi/FazyRV) in 1-bit configuration and default SoC, 4 kByte memory |

To build individual user designs, go into one of the directories and run the commands:

```
Commands:
 synth           ... Synthesize the user design
 pnr             ... Run Place and Route
 bitstream       ... Generate the bitstream
 clean           ... Delete all generated files
 help            ... Show this help message
```

To build all of them, enable a nix shell:

```
nix shell nixpkgs#{yosys,nextpnr}
```

And run:

```
make build_all
```

To delete all generated files, run:

```
make clean_all
```

**Note:** To generate the bitstreams you need to `pip3 install fasm`.
