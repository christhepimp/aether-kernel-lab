# Aether — AI-native OS vision

Working name: **Aether**.

## One sentence

The operating system should treat *intent* as a first-class input, and treat processes, files, and devices as tools the system can reason about.

## Layers (bottom to top)

1. **Metal / virt** — QEMU/AVD or later real hardware.
2. **Kernel** — Linux for a long time. Custom kernel only after we can state what Linux does wrong for us.
3. **Runtime** — isolation, capabilities, supervised tool processes.
4. **Aether core** — planner + memory + policy. This is the "OS is AI" layer.
5. **Surface** — voice, text, widgets. Not required to prove the core.

## Design constraints

- No silent root escalation outside the lab image.
- Every AI action that mutates the system is logged.
- The model does not *become* ring 0. Models hallucinate. Kernels must not.
- Prefer a small verified supervisor that *calls* models over putting weights in the kernel.

## First concrete artifact (Phase 2)

A root-capable lab daemon on the emulator that:

- reads `/proc`, `logcat`, and selected sysfs
- accepts a goal in natural language from `adb` or a local socket
- proposes a plan (shell commands, file reads)
- executes only an allowlisted set unless the operator flips a lab-danger flag

That daemon is the seed of an AI OS personality without lying about replacing Linux.
