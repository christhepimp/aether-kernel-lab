# Aether Kernel Lab

Experimental research workspace for studying a **rooted Android emulator**, the **Linux kernel it runs**, and a long-horizon idea: an **AI-native operating system** we design ourselves.

This is a lab, not a finished OS. Replacing Linux inside Android with a new kernel is a multi-year systems project. The repo exists so the work can start in public, in order, with honest scope.

## What this project is

1. Pick a rooted Android emulator as a disposable sandbox.
2. Get a root shell and inspect the Linux userspace + kernel surface.
3. Document how Android/Linux actually boots, schedules, and talks to hardware in the emulator.
4. Design an AI OS *concept* that can grow beside Linux first (userspace agent, then services, then maybe a custom kernel later).

## What this project is not (yet)

- Not a drop-in replacement for Linux.
- Not a bootable custom kernel you can flash today.
- Not a claim that "the OS is AI" in production.

An OS that *is* an AI still needs process isolation, memory management, drivers, filesystems, and a boot path. Intelligence sits on top of those primitives. We start with the primitives.

## Recommended sandbox: Android Studio AVD + Magisk (rootAVD)

Best first target for kernel-adjacent work:

| Option | Why use it | Root path |
| --- | --- | --- |
| **Android Studio AVD** (Google APIs or Play image) | Official QEMU-based emulator, GDB stub via `-qemu -s`, closest to real Android kernel images | [rootAVD](https://github.com/newbit1/rootAVD) + Magisk |
| **AERoot / android_emuroot** | On-the-fly root by patching kernel `task_struct` through QEMU GDB | [AERoot](https://github.com/quarkslab/AERoot) |
| **Genymotion** | Fast, some images support dynamic root | Vendor rooted images |
| **Waydroid** (Linux host) | Android in an LXC container sharing the *host* kernel | Host root + container |

For "get inside Linux" work, AVD + Magisk or AERoot is the most useful because you can attach GDB to the emulated kernel.

### Minimal first session

```bash
# 1. Create an AVD in Android Studio (x86_64 or arm64 system image).
# 2. Start it with the QEMU GDB stub if you plan to inspect the kernel:
emulator @Your_AVD -qemu -s

# 3. After Magisk/rootAVD or AERoot:
adb devices
adb shell su -c id
# expect uid=0(root)

# 4. Look around
adb shell su -c uname -a
adb shell su -c cat /proc/version
adb shell su -c ls /sys /proc
```

See `docs/emulator-root.md` for the longer path.

## Repo layout

```
docs/                 research notes
research/kernel/      kernel / boot observations
research/userspace/   Android userspace notes
design/               AI-OS architecture drafts
lab/                  scripts for the emulator lab
```

## Roadmap (honest)

### Phase 0 — Lab (now)
- Rooted emulator documented and reproducible
- Root shell + kernel version captured
- Notes on init, zygote, binder, cgroups

### Phase 1 — Observe Linux, do not replace it
- Map boot → init → Android runtime
- Record what an AI OS would have to own (scheduler, memory, IPC, drivers)

### Phase 2 — AI as a *system service* on Linux
- A privileged agent that plans, inspects, and orchestrates the machine
- Policy + tool use, not a new kernel

### Phase 3 — Custom userspace OS personality
- Replace Android framework pieces one at a time in the emulator
- Keep the Linux kernel

### Phase 4 — Custom kernel (far)
- Only after Phases 0–3 are real
- Likely starts as a teaching kernel or unikernel, not a phone OS

## License

MIT. Research notes are ours. Third-party tools (Magisk, rootAVD, AERoot, Android Emulator) keep their own licenses — do not vendor them here without complying.
