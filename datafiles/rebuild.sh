set -e
cd "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )\sm64plus" || { tput setaf 1; echo "Couldn't enter the repository directory."; read -n1 -r -p "Press any key to close this window." key; exit; }
git pull --ff-only || { tput setaf 3; echo "Pulling the game files from the repository failed. This is normal if you have modified the files."; }
tput setaf 6
echo "Starting to build..."
make -j$(nproc) CUSTOM_TEXTURES=$1 || { tput setaf 1; echo "An error has occured during the building process."; read -n1 -r -p "Press any key to close this window." key; exit; }