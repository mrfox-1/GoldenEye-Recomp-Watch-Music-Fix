# GoldenEye Recomp Community Fix

Provides a tested replacement executable for the Windows 1.2.4 release of
[GoldenEye Recomp](https://github.com/SunJaycy/GoldenEye-Recomp). It restores
missing music through the game's native XACT system and fixes horizontal
mouse aiming while driving the tank.

## Fixed audio

- 007 watch/pause-menu theme
- Mission Select music after abort, failure, and completion
- Control elevator/X-track music
- Caverns elevator/X-track music
- Correct elevator or primary level music after closing the watch
- Stale elevator state after mission restart
- Stale Control music replacing Mission Select after an elevator abort

## Fixed controls

- Horizontal and vertical tank turret aiming with the mouse
- Mouse aiming and W/A/S/D tank driving at the same time
- No need to hold Aim merely to turn the turret

## Install

1. Install the official GoldenEye Recomp v1.2.4 Windows release.
2. Download the latest Windows x64 ZIP from
   [Releases](https://github.com/mrfox-1/GoldenEye-Recomp-Watch-Music-Fix/releases/latest).
3. Back up your existing `GoldenEye.exe`.
4. Replace it with the `GoldenEye.exe` from the ZIP.
5. Keep the original `assets` folder and runtime DLLs in place.

No WAV files need to be extracted. No game audio or other game asset is
distributed by this project.

## How the audio fix works

The first v1.0.0 proof of concept extracted the watch cue from `music.xwb` and
played it with Windows `PlaySoundW`. That proved the missing transition but used
a separate mixer and required a generated WAV.

Version 2.0.0 instead uses GoldenEye's internal logical-cue translation, XACT
cue manager, mission-music state machine, and native cue stop/start wrappers.
It also implements the F4/F5 music-script commands that were left as
printf-only stubs in the XBLA executable.

The game reads the authentic music directly from the user's existing:

- `assets/music.xwb`
- `assets/music.xsb`
- `assets/music.xgs`

## How the tank fix works

GoldenEye's ordinary mouse hook writes Bond's camera yaw. While mounted, the
game rebuilds that yaw every simulation tick from the tank body and native
turret orientation, which immediately erased horizontal mouse movement.

Version 2.1 detects the game's authoritative mounted-state flag and applies
mouse X to the native turret target and smoothed orientation. The original tank
code remains responsible for steering, collision rollback, controller input,
and the final camera. Vertical aiming continues through the existing mouse path.

## Source and upstream contributions

The combined implementation is browsable directly in [`source/`](source):

- [`source/ge_hooks.cpp`](source/ge_hooks.cpp) contains the native cue,
  watch-state, Mission Select, F4/F5 X-track, and tank mouse-aim implementation.
- [`source/ge_config.toml`](source/ge_config.toml) contains the two mid-ASM
  opcode hooks.
- [`patches/goldeneye-community-fixes-v2.1.0.patch`](patches/goldeneye-community-fixes-v2.1.0.patch)
  is the clean cumulative patch against GoldenEye Recomp 1.2.4.

The upstream contributions, technical explanations, and validation records are:

- [Native XACT audio PR #114](https://github.com/SunJaycy/GoldenEye-Recomp/pull/114)
- [Tank mouse-aim PR #116](https://github.com/SunJaycy/GoldenEye-Recomp/pull/116)

The maintained source branches are
[`mrfox-1:agent/restore-watch-music`](https://github.com/mrfox-1/GoldenEye-Recomp/tree/agent/restore-watch-music)
and
[`mrfox-1:agent/fix-tank-mouse-aim`](https://github.com/mrfox-1/GoldenEye-Recomp/tree/agent/fix-tank-mouse-aim).

This repository does not contain a ROM, XEX, XWB/XSB/XGS bank, extracted WAV,
texture, or other original game asset. Users must supply their own legally
obtained game files.

## Compatibility

The replacement executable is built and tested against GoldenEye Recomp 1.2.4
for Windows x64. Version 2.1.0 contains the audio and tank fixes in the same
`GoldenEye.exe`. It is an unofficial community fix while upstream review is
pending.

The old extraction installer and v1 source are preserved under
[`legacy-v1/`](legacy-v1) for historical reference but are no longer
recommended.
