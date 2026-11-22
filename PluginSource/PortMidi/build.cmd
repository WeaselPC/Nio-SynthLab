@echo off
rem Compiles MidiIn.ns into the PortMidi plugin. Pass the path to Nio-Editor.exe.
setlocal
if "%~1"=="" (
    echo Usage: build.cmd "path\to\Nio-Editor.exe"
    exit /b 1
)
pushd "%~dp0"
"%~1" --ns-build "%~dp0PortMidi.nsproj"
if errorlevel 1 (
    popd
    exit /b 1
)
move /y PortMidi.nslib "..\..\Assets\Plugins\PortMidi\PortMidi.nslib" >nul
if exist logs rmdir /s /q logs
popd
