@echo off
setlocal
set ROOTDIR=%~dp0
set PATH=%ROOTDIR%depot_tools;%PATH%

cd %ROOTDIR%depot_tools
call update_depot_tools.bat

cd %ROOTDIR%chromium_git
set GN_DEFINES=is_component_build=true
set GN_ARGUMENTS=--ide=vs2022 --sln=cef --filters=//cef/*

call python ..\automate\automate-git.py --download-dir=%ROOTDIR%chromium_git --depot-tools-dir=%ROOTDIR%depot_tools --no-distrib --no-build