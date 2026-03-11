#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "Checking for the prerequisites..."
if ! command -v cmake &> /dev/null; then
    echo "Error: cmake could not be found. Please install it with: pacman -S mingw-w64-x86_64-cmake"
    exit 1
fi

if ! command -v mingw32-make &> /dev/null && ! command -v make &> /dev/null; then
    echo "Error: make could not be found. Please install it with: pacman -S mingw-w64-x86_64-make"
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo "Error: curl could not be found. Please install it with: pacman -S curl"
    exit 1
fi

echo "Downloading gamecontrollerdb.txt..."
curl -L -o ../datafiles/gamecontrollerdb.txt https://raw.githubusercontent.com/mdqinc/SDL_GameControllerDB/refs/heads/master/gamecontrollerdb.txt

echo "Configuring the build with CMake..."
mkdir -p build

cmake -G "MinGW Makefiles" -B build -S .

echo "Compiling the library..."
cmake --build build --config Release

echo "Yipee!!! Build complete!!!"
