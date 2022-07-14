#! /bin/bash

echo "This script is to compile ArrowOS for Xiaomi 11 Lite NE (lisa)."
echo "Created to get rid of the typing the same commands for a thousand times, by Bhargav Gajare."

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
echo "Downloading ArrowOS source code for you (minimal sync to save space)..."
repo init --depth=1 -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.1
repo sync -c -j$(nproc --all)

echo "Syncing source is done, now time to sync device specific code..."

# Clone device specific stuff required to compile for this lisa without errors
rm -rf hardware/qcom-caf/sm8350/display
rm -rf hardware/google/pixel-sepolicy
git clone https://github.com/TechWiz007/device_xiaomi_lisa.git -b twelve device/xiaomi/lisa
git clone https://gitlab.com/lisa-oss/vendor_xiaomi_lisa.git -b twelve vendor/xiaomi/lisa
git clone https://github.com/Atom-X-Devs/android_kernel_xiaomi_sm7325.git -b inline kernel/xiaomi/lisa
git clone https://github.com/PixelOS-Devices/hardware_google_pixel-sepolicy.git -b twelve hardware/google/pixel-sepolicy
git clone https://github.com/PixelOS-Pixelish/hardware_qcom-caf_sm8350_display.git -b twelve hardware/qcom-caf/sm8350/display

echo "Let us start the build for lisa"

# Start the build
. build/envsetup.sh
ccache -M 150G
lunch arrow_lisa-userdebug
m bacon -j$(nproc --all)

echo "Build Completed Succesfully! Thank you for using this script..."
