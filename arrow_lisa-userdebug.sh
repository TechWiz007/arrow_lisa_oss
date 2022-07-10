#! /bin/bash

echo "This script is to compile ArrowOS for Xiaomi 11 Lite NE (lisa)."

# Update & Upgrade your working machine
echo "Updating and upgrading your system"
sudo apt update -y
sudo apt upgrade -y
cd

# Create a working dir for the ROM
echo "Creating ArrowOS directory"
mkdir arrow
cd arrow

# Repo init and repo sync
echo "Downloading ArrowOS source code for you (minimal download to save space)..."
repo init --depth=1 -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.1
git clone https://github.com/TechWiz007/local_manifests.git -b arrow-12.1 ./repo/local_manifests
repo sync -c -j$(nproc --all)

echo "Syncing source is done, now time to start the build..."

# Start the build
. build/envsetup.sh
ccache -M 150G
lunch arrow_lisa-userdebug
m bacon -j$(nproc --all)

echo "Build Completed Succesfully! Thank you for using this script..."
