#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
python3 reference/test_model.py
if command -v iverilog >/dev/null && command -v vvp >/dev/null; then
  mkdir -p build
  iverilog -g2012 -s tb_dsss_tx -o build/dsss_tx.vvp rtl/dsss_tx.v tb/tb_dsss_tx.v
  vvp build/dsss_tx.vvp
else
  echo 'RTL SIMULATION NOT RUN: install iverilog and vvp first.'
fi
