#!/usr/bin/env bash
# Collect a rooted-emulator baseline. Run on the host with adb in PATH.
set -euo pipefail
OUT="${1:-research/kernel/baseline-$(date +%Y%m%d-%H%M%S).txt}"
mkdir -p "$(dirname "$OUT")"
{
  echo "# Aether lab baseline"
  echo "collected: $(date -Iseconds)"
  echo
  echo "== uname =="
  adb shell su -c uname -a || adb shell uname -a
  echo
  echo "== /proc/version =="
  adb shell su -c cat /proc/version || true
  echo
  echo "== build props =="
  adb shell getprop ro.build.version.release
  adb shell getprop ro.build.version.sdk
  adb shell getprop ro.product.cpu.abi
  echo
  echo "== id =="
  adb shell su -c id || adb shell id
} | tee "$OUT"
echo "wrote $OUT"
