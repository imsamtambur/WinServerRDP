#!/bin/bash

# Fungsi untuk menampilkan menu
display_menu() {
    echo "Pilih versi Windows Server yang ingin Anda siapkan:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows Server 2022 Datacenter"
    read -p "Masukkan pilihan Anda (1-4): " choice
}

# Update dan instalasi QEMU
echo "Memperbarui paket dan menginstal QEMU..."
apt-get update && apt-get upgrade -y
apt-get install -y qemu qemu-utils qemu-system-x86 wget

echo "Instalasi QEMU selesai."

# Menampilkan menu dan menangkap pilihan pengguna
display_menu

# Menentukan versi Windows Server berdasarkan pilihan
case $choice in
    1)
        img_file="windows2016.img"
        iso_file="windows2016.iso"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
        ;;
    2)
        img_file="windows2019.img"
        iso_file="windows2019.iso"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        ;;
    3)
        img_file="windows2022.img"
        iso_file="windows2022.iso"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        ;;
    4)
        img_file="windows2022datacenter.img"
        iso_file="windows2022datacenter.iso"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        ;;
    *)
        echo "Pilihan tidak valid. Skrip dihentikan."
        exit 1
        ;;
esac

echo "Anda telah memilih versi Windows: $img_file"

# Membuat file image kosong untuk QEMU
echo "Membuat file image untuk QEMU..."
qemu-img create -f raw "$img_file" 40G
echo "File image $img_file berhasil dibuat."

# Mendownload driver Virtio
echo "Mendownload driver Virtio..."
wget -O virtio-win.iso "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso"
echo "Driver Virtio berhasil diunduh."

# Mendownload ISO Windows Server
echo "Mendownload ISO Windows Server..."
wget -O "$iso_file" "$iso_link"
echo "ISO $iso_file berhasil diunduh."

# Skrip selesai
echo "Persiapan selesai. Anda dapat menggunakan file berikut:"
echo "Image file  : $img_file"
echo "Windows ISO : $iso_file"
echo "Virtio ISO  : virtio-win.iso"
