# GoldenEye community fixes v2.2.0 source

These are the complete modified source/configuration files used for the tested
v2.2.0 Windows x64 build. They are copied from commit
`9137f63` of
[`mrfox-1/GoldenEye-Recomp`](https://github.com/mrfox-1/GoldenEye-Recomp/commit/9137f63).

- `ge_hooks.cpp` contains the native XACT music transitions, F4/F5 X-track
  commands, tank mouse aiming, post-effect dimension repair, and Frigate
  water/near-clip hooks.
- `ge_config.toml` declares the required mid-ASM hooks.
- `ge_app.h` makes a normal Windows launch use the adjacent `assets` folder
  when no explicit `--game_data_root` was provided.
- `ge_manifest.toml`, `ge_menu.h`, `ge_postfx.h`, and `ge_username.h` contain
  the small current-SDK build compatibility adjustments used by the release.
- `CMakeLists.txt` is the clean project build file with no `winmm` dependency.
- `CMakePresets.json` records the optimized `-O3 -DNDEBUG` Windows release
  configuration used for the published executable.
- `UPSTREAM-LICENSE` is GoldenEye Recomp's source license.

For review or application to another 1.2.4 checkout, use the cumulative patch:
[`../patches/goldeneye-community-fixes-v2.2.0.patch`](../patches/goldeneye-community-fixes-v2.2.0.patch).

No generated recompilation output or game asset is included. The executable
uses the Frigate skydome already present in the user's adjacent `assets`
folder without modifying it.
