# Native XACT v2 source

These are the complete modified source/config files used for the v2.0.0 build.
They correspond to commit `f5c0f8c` on
[`mrfox-1/GoldenEye-Recomp`](https://github.com/mrfox-1/GoldenEye-Recomp/tree/agent/restore-watch-music).

- `ge_hooks.cpp` implements native watch and Mission Select cue playback,
  F4/F5 X-track commands, Control/Caverns elevator transitions, and correct
  music restoration.
- `ge_config.toml` declares the missing F4/F5 mid-ASM hooks.
- `CMakeLists.txt` is the clean project build file with no `winmm` dependency.
- `UPSTREAM-LICENSE` is GoldenEye Recomp's source license.

For review or application to another 1.2.4 checkout, use the smaller cumulative
patch at [`../patches/native-xact-audio-v2.0.0.patch`](../patches/native-xact-audio-v2.0.0.patch).

No generated recompiled game code or game asset is included.
