# Architecture draft v0

```
+---------------------------+
| Operator / adb / UI       |
+-------------+-------------+
              |
              v
+---------------------------+
| Aether Supervisor         |
|  - goal intake            |
|  - plan + allowlist       |
|  - audit log              |
+------+-------------+------+
       |             |
       v             v
+------------+  +-----------+
| Tool runners|  | Model I/O |
| (shell, fs, |  | (local or |
|  sysinfo)   |  |  remote)  |
+------+-----+  +-----------+
       |
       v
+---------------------------+
| Linux (Android emulator)  |
+---------------------------+
```

Supervisor stays small and boring. Models stay untrusted. Linux stays the kernel until Phase 4 is earned.
