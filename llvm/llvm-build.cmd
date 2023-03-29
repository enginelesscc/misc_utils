@echo off

REM // Run this script using x86_64 Cross Tools Command Prompt for VS 2022

setlocal
set ROOTDIR=%~dp0

cd %ROOTDIR%llvm-project\build

call cmake --build .
call cmake --build . --target install
