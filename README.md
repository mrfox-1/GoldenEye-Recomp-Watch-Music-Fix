# GoldenEye Recomp Watch Music Fix — Superseded

This repository contains the original external-WAV workaround for missing music
in GoldenEye Recomp 1.2.4. It is preserved for reference, but it is no longer
the recommended fix.

The replacement is a fully native XACT implementation submitted upstream in
[GoldenEye-Recomp PR #114](https://github.com/SunJaycy/GoldenEye-Recomp/pull/114).
It uses the music already present in each user's original `music.xwb`,
`music.xsb`, and `music.xgs` files as-is.

## What the native patch fixes

- Restores the 007 watch/pause-menu theme.
- Restores Mission Select music after mission abort, failure, and completion.
- Implements the missing elevator/X-track commands used by Control and Caverns.
- Restores the correct elevator or primary level cue after closing the watch.
- Prevents stale elevator state from suppressing music after an abort/restart.

## What changed from this workaround

The initial proof of concept extracted streams from `music.xwb` and played them
through Windows `PlaySoundW`. That established the missing state transitions,
but its separate mixer produced different volume behavior and required locally
generated WAV files.

The upstream patch instead calls GoldenEye's existing logical-cue translation,
XACT cue manager, mission-music state machine, and cue stop/start wrappers. It
also implements the F4/F5 music-script handlers that were left as printf-only
stubs in the XBLA executable.

No WAV extraction, external audio playback, installer, or bundled game audio is
required by the native patch. No copyrighted game asset is included in the PR.

See [issue #83](https://github.com/SunJaycy/GoldenEye-Recomp/issues/83) for the
original report and test discussion.
