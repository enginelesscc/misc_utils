@echo off

setlocal
set ROOTDIR=%~dp0

call git clone https://github.com/llvm/llvm-project --branch main --depth 1 --recursive