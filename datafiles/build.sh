set -e
pacman -S git make python3 mingw-w64-x86_64-gcc mingw-w64-x86_64-SDL2 mingw-w64-x86_64-glew --noconfirm --needed || { tput setaf 1; echo "Couldn't install the prerequisites."; read -n1 -r -p "Press any key to close this window." key; exit; }
cd "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )" || { tput setaf 1; echo "Couldn't enter the current directory."; read -n1 -r -p "Press any key to close this window." key; exit; }
if [ ! -d "sm64plus" ] ; then
    git clone https://github.com/MorsGames/sm64plus.git || { tput setaf 1; echo "Couldn't download the game files from the repository."; read -n1 -r -p "Press any key to close this window." key; exit; }
else
    echo "The sm64plus folder already exists. Skipping cloning the repository."
fi
mv "$LOCALAPPDATA\SM64Plus\baserom.us.z64" "sm64plus\baserom.us.z64" || { tput setaf 1; echo "Couldn't move the ROM file."; read -n1 -r -p "Press any key to close this window." key; exit; }
cd sm64plus || { tput setaf 1; echo "Couldn't enter the repository directory."; read -n1 -r -p "Press any key to close this window." key; exit; }
make -j$(nproc) CUSTOM_TEXTURES=$1 || { tput setaf 1; echo "An error has occured during the building process. If the error has occured while extracting the assets, try a different ROM file.\n\nOtherwise please refer to the FAQ: https://github.com/MorsGames/sm64plus/wiki/Frequently-Asked-Questions"; read -n1 -r -p "Press any key to close this window." key; exit; }