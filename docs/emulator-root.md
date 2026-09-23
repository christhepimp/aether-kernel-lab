# Rooted Android emulator notes

## Why an emulator first

A physical phone with an unlocked bootloader is better for real hardware. An emulator is better for:

- snapshots and throwaway disks
- QEMU GDB (`-qemu -s`) against the guest kernel
- repeating experiments without bricking a device

## Primary path: AVD + Magisk via rootAVD

Community writeups (2025–2026) still treat this as the standard lab setup:

1. Install Android Studio and the emulator.
2. Create an AVD. Prefer a **Google APIs** image if you only need root; Play Store images are locked down more tightly.
3. Use [rootAVD](https://github.com/newbit1/rootAVD) to patch the system image with Magisk.
4. Cold-boot the AVD, open Magisk, complete setup, reboot.
5. `adb shell su` should give `uid=0`.

Enable Zygisk in Magisk only if you need modules. For kernel study it is optional.

## Alternate path: AERoot (no Magisk image patch)

[AERoot](https://github.com/quarkslab/AERoot) (rewrite of Airbus `android_emuroot`) grants root by using the emulator GDB stub and rewriting credentials in kernel memory (`task_struct`).

```text
emulator @Your_AVD -qemu -s
# then run aeroot in daemon or pid mode
```

Useful when you want a stock Play image and temporary root for inspection.

Supported kernels are listed upstream and are version-specific. If your AVD kernel is newer than AERoot's table, prefer Magisk/rootAVD.

## Other emulators

- **Genymotion**: some images can be rooted dynamically. Good for app testing, weaker for kernel GDB work.
- **Waydroid**: Android container on a Linux desktop. You share the *host* kernel, so you are not looking at an Android guest kernel.
- **BlueStacks / LDPlayer / Nox**: gaming first. Root options exist on some builds but they are poor kernel labs.
- **Cloud emulators** (Genymotion SaaS, Redfinger): convenient, not a place to replace Linux.

## After you have root

Collect a baseline and commit it under `research/`:

```bash
adb shell su -c uname -a
adb shell su -c cat /proc/version
adb shell su -c cat /proc/cpuinfo
adb shell su -c getprop ro.build.version.release
adb shell su -c ls -l /init* /system/bin/init 2>/dev/null
adb shell su -c ps -A | head
```

You now have a Linux system. That is the starting line, not the finish.
