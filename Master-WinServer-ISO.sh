#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    read -p "Enter your choice [1-5]: " choice
}

# Exit if not run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Update package repositories and upgrade existing packages
echo "Updating and upgrading system packages..."
apt-get update && apt-get upgrade -y || {
    echo "Failed to update and upgrade packages. Exiting."
    exit 1
}

# Install QEMU and its utilities
echo "Installing QEMU and required utilities..."
apt-get install -y qemu qemu-utils qemu-system-x86-xen qemu-system-x86 qemu-kvm || {
    echo "Failed to install QEMU. Exiting."
    exit 1
}
echo "QEMU installation completed successfully."

# Display menu and get user choice
display_menu

# Define variables based on user choice
case $choice in
    1)
        img_file="windows2016.img"
        iso_link="https://software-download.microsoft.com/download/pr/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
        iso_file="windows2016.iso"
        ;;
    2)
        img_file="windows2019.img"
        iso_link="https://software-download.microsoft.com/download/sg/Windows_Server_2019_Datacenter_EVAL_en-us_17763_refresh.ISO"
        iso_file="windows2019.iso"
        ;;
    3)
        img_file="windows2022.img"
        iso_link="https://software-download.microsoft.com/download/sg/Windows_Server_2022_Datacenter_EVAL_en-us_20348_refresh.ISO"
        iso_file="windows2022.iso"
        ;;
    4)
        img_file="windows10.img"
        echo "Windows 10 requires Media Creation Tool. Please download it from:"
        echo "https://www.microsoft.com/en-us/software-download/windows10"
        exit 1
        ;;
    5)
        img_file="windows11.img"
        echo "Windows 11 requires Media Creation Tool. Please download it from:"
        echo "https://www.microsoft.com/en-us/software-download/windows11"
        exit 1
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file
echo "Creating raw image file..."
qemu-img create -f raw "$img_file" 40G || {
    echo "Failed to create image file. Exiting."
    exit 1
}
echo "Image file $img_file created successfully."

# Download Virtio driver ISO
virtio_iso="virtio-win.iso"
echo "Downloading Virtio driver ISO..."
wget -O "$virtio_iso" 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso' || {
    echo "Failed to download Virtio driver ISO. Exiting."
    exit 1
}
echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO
echo "Downloading Windows ISO..."
wget -O "$iso_file" "$iso_link" || {
    echo "Failed to download Windows ISO. Exiting."
    exit 1
}
echo "Windows ISO downloaded successfully."
