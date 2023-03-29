@echo off
setlocal
set ROOTDIR=%~dp0
set PATH=%ROOTDIR%depot_tools;%PATH%

cd %ROOTDIR%chromium_git\chromium\src
ninja -C out\Release_GN_x64 cef

pause