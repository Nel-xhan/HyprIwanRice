#!/bin/bash

set -eo pipefail

handle_error() {
    local exit_code="$?"
    echo "An error occurred (exit code: $exit_code)."
    echo "Press Enter to close the terminal..."
    read -r
    exit "$exit_code"
}

handle_interrupt() {
    echo "Script interrupted by user (Ctrl+C)."
    echo "Press Enter to close the terminal..."
    read -r
    exit 1
}

trap 'handle_error' ERR
trap 'handle_interrupt' SIGINT

echo -e "\033[31mInitializing destruction...\033[0m"

sleep 2

BAR_WIDTH=50

# Initialize percentage to 0
percentage=0

# Function to draw the loading bar
draw_bar() {
  # Calculate the number of filled and empty spaces in the bar
  filled=$((percentage * BAR_WIDTH / 100))
  empty=$((BAR_WIDTH - filled))

  # Create the loading bar string
  bar=$(printf "%0.s#" $(seq 1 $filled))
  space=$(printf "%0.s-" $(seq 1 $empty))

  # Print the loading bar with percentage
  echo -ne "\r[${bar}${space}] ${percentage}%"
}

# Loop to update the loading bar every tick
while [ $percentage -le 100 ]; do
  draw_bar
  sleep 0.01  # Adjust the speed of the loading bar by changing the sleep duration
  percentage=$((percentage + 1))
done

# Print a newline after the loading is complete
echo -e "\nLoading complete!"


# Function to prompt for yes/no
prompt_yes_no() {
    local prompt="$1"
    local default="$2"
    local response

    # Display the prompt
    read -r -p "$prompt [Y/n]: " response

    # Default to "yes" if no response is provided
    response="${response:-$default}"

    case "$response" in
        [Yy]* ) return 0 ;; # Return 0 (true) for yes
        [Nn]* ) return 1 ;; # Return 1 (false) for no
        * ) echo "Please answer yes or no." ; return 1 ;; # Invalid input
    esac
}

# Example usage of the function
if prompt_yes_no "Do you want to proceed?" "Y"; then
    echo "You chose to proceed."
    # Put commands here for the "yes" case
else
    echo "You chose not to proceed."
    exit
fi

cd ~/Git/Hyprland/aquamarine || exit 1
git pull

rm -rf ./build

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG"  -DCMAKE_C_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG" -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

sudo cmake --install build

cd ~/Git/Hyprland/hyprutils || exit 1
git pull

rm -rf ./build

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG"  -DCMAKE_C_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG" -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

sudo cmake --install build

cd ~/Git/Hyprland/hyprlang || exit 1
git pull

rm -rf ./build

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG"  -DCMAKE_C_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG" -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

sudo cmake --install ./build

cd ~/Git/Hyprland/hyprwayland-scanner || exit 1
git pull

rm -rf ./build

cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS:STRING="-flto -O3 -DNDEBUG" -DCMAKE_C_FLAGS:STRING="-flto -O3 -DNDEBUG" -DCMAKE_INSTALL_PREFIX:PATH=/usr -B build

cmake --build build -j `nproc`

sudo cmake --install build

cd ~/Git/Hyprland/hyprcursor || exit 1
git pull

rm -rf ./build

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG"  -DCMAKE_C_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG" -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

sudo cmake --install build

cd ~/Git/Hyprland/hyprlock || exit 1
git pull

rm -rf ./build

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG"  -DCMAKE_C_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG" -S . -B ./build


cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

sudo cmake --install build

cd ~/Git/Hyprland/Hyprland || exit 1
git pull

rm -rf ./build

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG"  -DCMAKE_C_FLAGS_RELEASE:STRING="-flto -O3 -DNDEBUG" -B build -G Ninja

cmake --build ./build --config Release --target all

sudo cmake --install ./build

echo -e "\033[31mEat Shit\033[39m"
echo -e "\033[31mPress Enter to exit.\033[39m"
read -r
