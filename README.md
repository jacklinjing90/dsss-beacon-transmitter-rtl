# Programmable DSSS Beacon Transmitter

Configurable PN-code spreading and BPSK chip generation in synthesizable Verilog RTL, with independent Python reference checks and a self-checking testbench.

## Intended use

Transmits an eight-bit identification payload as 1,016 spread chips. The output is logical BPSK chip polarity, not an RF waveform.

## Repository structure

- `rtl/dsss_tx.v`: synthesizable Verilog module
- `tb/tb_dsss_tx.v`: self-checking RTL testbench
- `reference/test_model.py`: independent Python algorithm/arithmetic sanity checks
- `run_tests.sh`: Python check and optional Icarus Verilog simulation

## Run

Requirements: Python 3; optional Icarus Verilog (`iverilog`, `vvp`) for RTL simulation.

```bash
bash run_tests.sh
```

## Verification status

- Python reference sanity checks: passed in original authoring environment.
- RTL self-checking testbench: written, not yet executed in original authoring environment.
- RTL vs Python sample-by-sample comparison: not yet established.
- ASIC synthesis / timing / silicon: not completed.

## Scope

A standalone educational/portfolio prototype using only original generic signal-processing techniques. It does not reproduce proprietary RPMA or satellite SoC design, and makes no claims of production readiness.
