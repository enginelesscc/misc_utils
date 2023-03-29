@echo off
setlocal
set ROOTDIR=%~dp0
set PATH=%ROOTDIR%depot_tools;%PATH%

cd %ROOTDIR%chromium_git\chromium\src\cef
set GN_DEFINES=blink_symbol_level=0 v8_symbol_level=0 symbol_level=0 is_debug=false enable_nacl=false is_official_build=true chrome_pgo_phase=0
set GN_ARGUMENTS=--ide=vs2022 --sln=cef --filters=//cef/*
call cef_create_projects.bat

pause