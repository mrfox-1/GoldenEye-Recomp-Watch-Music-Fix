# GoldenEye Recomp Native XACT Music Fix

Restores missing music transitions in the Windows 1.2.4 release of
[GoldenEye Recomp](https://github.com/SunJaycy/GoldenEye-Recomp) using the
game's original XACT music system and the user's existing music banks.

## Fixed

- 007 watch/pause-menu theme
- Mission Select music after abort, failure, and completion
- Control elevator/X-track music
- Caverns elevator/X-track music
- Correct elevator or primary level music after closing the watch
- Stale elevator state after mission restart

## Install

1. Install the official GoldenEye Recomp v1.2.4 Windows release.
2. Download the latest Windows x64 ZIP from
   [Releases](https://github.com/mrfox-1/GoldenEye-Recomp-Watch-Music-Fix/releases/latest).
3. Back up your existing `GoldenEye.exe`.
4. Replace it with the `GoldenEye.exe` from the ZIP.
5. Keep the original `assets` folder and runtime DLLs in place.

No WAV files need to be extracted. No game audio or other game asset is
distributed by this project.

## How v2 works

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

## Source and upstream contribution

The complete source change, technical explanation, and validation record are
available in
[SunJaycy/GoldenEye-Recomp PR #114](https://github.com/SunJaycy/GoldenEye-Recomp/pull/114).
The maintained branch is
[`mrfox-1:agent/restore-watch-music`](https://github.com/mrfox-1/GoldenEye-Recomp/tree/agent/restore-watch-music).

This repository does not contain a ROM, XEX, XWB/XSB/XGS bank, extracted WAV,
texture, or other original game asset. Users must supply their own legally
obtained game files.

## Compatibility

The replacement executable is built and tested against GoldenEye Recomp 1.2.4
for Windows x64. It is an unofficial community fix while upstream review is
pending.

The old extraction installer and v1.0.0 release remain available for historical
reference but are no longer recommended.
