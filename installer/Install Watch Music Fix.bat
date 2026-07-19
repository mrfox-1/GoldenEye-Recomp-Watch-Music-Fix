@echo off
setlocal
title GoldenEye Recomp - Watch Music Fix

cd /d "%~dp0"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-WatchMusicFix.ps1"

echo.
pause

