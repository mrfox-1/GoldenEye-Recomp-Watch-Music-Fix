# GoldenEye Recomp Community Fix

Provides a tested replacement executable for the Windows 1.2.4 release of
[GoldenEye Recomp](https://github.com/SunJaycy/GoldenEye-Recomp). The current
build repairs missing native music transitions, tank mouse aiming, dead-body
fading, and Frigate water rendering in one `GoldenEye.exe`.

## Fixed audio

- 007 watch/pause-menu theme
- Mission Select music after abort, failure, and completion
- Control elevator/X-track music
- Caverns elevator/X-track music
- Correct elevator or primary level music after closing the watch
- Stale elevator state after mission restart
- Stale Control music replacing Mission Select after an elevator abort

All music uses the game's native XACT cue system and the user's existing
`music.xwb`, `music.xsb`, and `music.xgs`. No extracted WAV is used.

## Fixed controls

- Horizontal and vertical tank turret aiming with the mouse
- Mouse aiming and W/A/S/D tank driving at the same time
- No need to hold Aim merely to turn the turret

## Fixed graphics

- Dead enemies remain visible and use the original delayed fade instead of
  disappearing immediately
- Frigate's animated water renders in enhanced-graphics mode
- Frigate water remains visible beside the speedboat and from lower camera
  heights instead of turning into a flat blue plane or a clipped gap

The official Windows 1.2.4 asset set already includes the correct Frigate
skydome. This fix uses that existing file unchanged; no texture, skydome, XEX,
ROM, or other game asset is included in this repository or its release.

## Install

1. Install the official GoldenEye Recomp v1.2.4 Windows release.
2. Download the latest Windows x64 ZIP from
   [Releases](https://github.com/mrfox-1/GoldenEye-Recomp-Watch-Music-Fix/releases/latest).
3. Back up the existing `GoldenEye.exe` in that folder.
4. Replace it with the `GoldenEye.exe` from the ZIP.
5. Double-click `GoldenEye.exe`.

Keep the original `assets` folder and runtime DLLs beside the executable. The
community build automatically uses the adjacent `assets` folder, so a normal
Explorer launch does not require `--game_data_root`.

## How the repairs work

### Native music

The original v1.0 proof of concept extracted the watch cue and used a separate
Windows mixer. Version 2 and later instead use GoldenEye's logical-cue
translation, XACT cue manager, mission-music state machine, and native cue
stop/start wrappers. They also implement the F4/F5 music-script commands that
were left as diagnostic stubs in the XBLA executable.

### Tank mouse aiming

GoldenEye normally rebuilds the mounted camera yaw from the tank body and
native turret orientation every simulation tick, erasing ordinary mouse X
movement. The fix detects the authoritative mounted-state flag and routes mouse
X to the native turret target and smoothed orientation. The original game code
still handles steering, collision rollback, controller input, and the camera.

### Dead-body fade

The recompiled startup path clobbers cached display dimensions before creating
the full-frame color and depth resolve textures. The invalid 0/-1 pair becomes
overlapping 8192x8191 sentinel allocations and breaks the stencil-based fade
composite. The fix reloads the game's canonical display width and height at the
final consumer, preserving the original post-effect.

### Frigate water

Two focused mid-ASM hooks reproduce the relevant Community Edition behavior:
the enhanced-graphics path no longer suppresses the Frigate water draw, and the
projection builder receives the intended 2.0 near clip so the low speedboat
camera does not clip the surface.

## Source and upstream contributions

The complete modified source/configuration files used for v2.2.0 are in
[`source/`](source). The cumulative patch against GoldenEye Recomp 1.2.4 is
[`patches/goldeneye-community-fixes-v2.2.0.patch`](patches/goldeneye-community-fixes-v2.2.0.patch).

Upstream contributions and technical review records:

- [Native XACT audio PR #114](https://github.com/SunJaycy/GoldenEye-Recomp/pull/114)
- [Tank mouse-aim PR #116](https://github.com/SunJaycy/GoldenEye-Recomp/pull/116)
- [Body-fade and Frigate-water PR #118](https://github.com/SunJaycy/GoldenEye-Recomp/pull/118)

The cumulative community fork is
[`mrfox-1/GoldenEye-Recomp`](https://github.com/mrfox-1/GoldenEye-Recomp). No
generated recompiled game source is committed.

## Compatibility

The replacement executable is built and tested against GoldenEye Recomp 1.2.4
for Windows x64. Version 2.2.0 contains every repair listed above in the same
`GoldenEye.exe`. It is an unofficial community build while the focused
upstream pull requests are pending.

The old WAV-extraction installer and v1 source remain under
[`legacy-v1/`](legacy-v1) for historical reference but are not recommended.
