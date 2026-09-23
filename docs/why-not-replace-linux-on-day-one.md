# Why we do not "replace Linux" on day one

Android is Linux plus a large userspace (init, binder, zygote, ART, HALs).

To replace Linux you must replace at least:

- bootloader handoff and early init
- memory management and page tables
- process / thread model
- interrupt and timer handling
- block and network drivers *or* virtio in the emulator
- a syscall ABI something can run against

An "AI OS" still needs those. The AI can be:

1. the *policy layer* (what to run, how to schedule intent),
2. the *shell* (natural language instead of sh),
3. later, parts of the *kernel policy* (scheduling hints, memory reclaim),

but it cannot delete the kernel and still boot a phone emulator.

This repo treats the AI OS as a system that grows *on* Linux first, then optionally *beside* it.
