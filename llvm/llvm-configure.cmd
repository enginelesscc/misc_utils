@echo off

REM // Run this script using x86_64 Cross Tools Command Prompt for VS 2022

setlocal
set ROOTDIR=%~dp0
set PATH=%ROOTDIR%llvm-install\bin;C:\Program Files\LLVM\bin;%PATH%

IF EXIST "%ROOTDIR%llvm-install\bin\" (
	echo Using Polly
	set _TEMP_COMMONFLAGS=/clang:-march=znver3 /clang:-mtune=znver3 -maes -mvaes /clang:-ffp-contract=fast -mllvm -enable-gvn-hoist -mllvm -enable-loopinterchange -mllvm -enable-loop-distribute -mllvm -enable-loop-flatten -mllvm -interleave-small-loop-scalar-reduction -mllvm -loop-rotate-multi -mllvm -scalar-evolution-use-expensive-range-sharpening
	set LDFLAGS=-mllvm:-polly -mllvm:-polly-invariant-load-hoisting -mllvm:-polly-vectorizer=stripmine -mllvm:-polly-detect-profitability-min-per-loop-insts=40 -mllvm:-enable-gvn-hoist -mllvm:-enable-loopinterchange -mllvm:-enable-loop-distribute -mllvm:-enable-loop-flatten
)

cd %ROOTDIR%llvm-project
rm -rf build
mkdir build
cd build

set CC=clang-cl
set CXX=clang-cl
set _TEMP_COMMONFLAGS=%_TEMP_COMMONFLAGS% -Ofast -D_WIN32_WINNT=0x0A00
set CFLAGS=%CFLAGS% %_TEMP_COMMONFLAGS%
set CXXFLAGS=%CXXFLAGS% %_TEMP_COMMONFLAGS%

call cmake "%ROOTDIR%llvm-project\llvm"                                                 ^
    -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%ROOTDIR%llvm-install"  ^
	-DLLVM_ENABLE_PROJECTS="clang;polly;lld" -DLLVM_TARGETS_TO_BUILD=X86                ^
	-DLLVM_ENABLE_LLD=ON -DLLVM_ENABLE_LTO=Thin -DLLVM_USE_CRT_RELEASE=MT               ^
	-DLLVM_BUILD_EXAMPLES=OFF -DLLVM_BUILD_DOCS=OFF -DLLVM_BUILD_TESTS=OFF
