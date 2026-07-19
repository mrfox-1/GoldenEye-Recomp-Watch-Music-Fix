# GoldenEye Recomp Watch Music Fix

Restores the missing 007 watch/pause-menu music in the Windows build of
[GoldenEye Recomp](https://github.com/SunJaycy/GoldenEye-Recomp).

The authentic watch theme is already present as stream 33 in the user's own
`assets/music.xwb`. The ready-to-run installer extracts that stream locally,
then installs a patched executable that starts and stops it with the watch.

## Ready-to-run installation

1. Download the ZIP from this repository's **Releases** page.
2. Extract the entire ZIP.
3. Double-click `Install Watch Music Fix.bat`.
4. Drag your GoldenEye Recomp folder into the installer and press Enter.
5. Start `GoldenEye.exe` normally.

The Release installer is intended for **GoldenEye Recomp 1.2.4 on Windows**.
No compiler, ReXGlue SDK, decompilation, or manually extracted audio is needed.

## What it does

- Confirms that the selected folder contains `GoldenEye.exe` and
  `assets/music.xwb`.
- Backs up the existing executable and matching runtime DLLs.
- Installs the tested Windows 1.2.4 executable/runtime combination.
- Uses the open-source [vgmstream](https://github.com/vgmstream/vgmstream)
  decoder to extract stream 33 from the user's own `music.xwb`.
- Writes the locally generated `watch_theme.wav` beside `GoldenEye.exe`.
- Detects the watch opening and closing, temporarily replaces level music with
  the watch theme, then restores the configured music volume.

## No game assets are distributed

This repository and its Release do **not** contain `watch_theme.wav`,
`music.xwb`, `music.xsb`, `music.xgs`, a ROM, XEX, textures, or other original
game assets. The watch theme is generated locally from files supplied by the
user.

## Source

- `installer/Install-WatchMusicFix.ps1` is the complete readable installer and
  extraction logic.
- `source/ge_hooks.cpp` contains the watch-state and playback implementation.
- `source/CMakeLists.txt` contains the Windows `winmm` linkage.

The installer source is MIT licensed. GoldenEye Recomp's source is provided
under its upstream Unlicense. vgmstream's license notice is preserved under
`third_party/vgmstream`.

## Current limitation

This proof-of-concept plays the locally extracted WAV through Windows
`PlaySoundW`, rather than asking the game's internal XACT engine to play the cue
directly. It still uses GoldenEye's internal watch state and music-volume
function so opening and closing the watch behaves correctly.

## Tested result

The extractor identifies stream 33 as:

`Wave Bank/21Goldeneye 64 - 007 Watch Theme`

The resulting WAV is 22,045 Hz stereo and 4,125,248 bytes.

