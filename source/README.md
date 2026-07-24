# GoldenEye community fixes v2.1 source

These are the complete modified source/config files used for the v2.1.0
combined build. The audio work is maintained on
[`mrfox-1:agent/restore-watch-music`](https://github.com/mrfox-1/GoldenEye-Recomp/tree/agent/restore-watch-music),
and the tested tank fix is commit `6af3560` on
[`mrfox-1:agent/fix-tank-mouse-aim`](https://github.com/mrfox-1/GoldenEye-Recomp/tree/agent/fix-tank-mouse-aim).

- `ge_hooks.cpp` implements native watch and Mission Select cue playback,
  F4/F5 X-track commands, Control/Caverns elevator transitions, and correct
  music restoration. It also clears outgoing X-track timers before Mission
  Select so stale level music cannot return after their duration expires. The
  same file also routes horizontal mouse input to the native turret state while
  Bond is mounted in a tank.
- `ge_config.toml` declares the missing F4/F5 mid-ASM hooks.
- `CMakeLists.txt` is the clean project build file with no `winmm` dependency.
- `UPSTREAM-LICENSE` is GoldenEye Recomp's source license.

For review or application to another 1.2.4 checkout, use the smaller cumulative
patch at
[`../patches/goldeneye-community-fixes-v2.1.0.patch`](../patches/goldeneye-community-fixes-v2.1.0.patch).

No generated recompiled game code or game asset is included.
