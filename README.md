# WinServerRDP
Repo ini untuk membuat ISO Windows Server dari berbagai versi yang bisa anda gunakan untuk membuat RDP Windows
## Langkah-Langkah Instalasi Windows Server
### 1. Unduh File Installer
Gunakan perintah berikut untuk mengunduh installer:
```bash
wget https://raw.githubusercontent.com/imsamtambur/WinServerRDP/main/Master-WinServer-ISO.sh
```

### 2. Berikan Izin Eksekusi pada File
Setelah berhasil diunduh, berikan izin eksekusi pada file tersebut:
```bash
chmod +x Master-WinServer-ISO.sh
```

### 3. Jalankan Installer
Eksekusi file installer dengan perintah berikut:
```bash
./Master-WinServer-ISO.sh
```

### 4. Jalankan Windows Server di QEMU
Setelah proses instalasi selesai, gunakan QEMU untuk memulai Windows Server. Ganti xx dengan versi Windows yang Anda pilih (misalnya windows2019):
```bash
qemu-system-x86_64 \
-m 4G \
-cpu host \
-enable-kvm \
-boot order=d \
-drive file=windows2022.iso,media=cdrom \
-drive file=windows2022.img,format=raw,if=virtio \
-drive file=virtio-win.iso,media=cdrom \
-device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
-device usb-tablet \
-vnc :0 \
-audiodev none,id=noaudio
```

### 5. Akses QEMU via VNC
Setelah QEMU berjalan:
+ Gunakan aplikasi VNC Viewer untuk mengakses server dengan menggunakan IP, username dan password server.
+ Lanjutkan instalasi dan konfigurasi Windows Server di dalam QEMU seperi membuat password, melakukan partisi, install driver dengan virtio dll

### 6. Konfigurasi Windows Server
+ Setelah berhasil masuk ke Windows Server, lakukan langkah berikut:
+ Aktifkan Remote Desktop melalui pengaturan sistem.
+ Nonaktifkan CTRL+ALT+DEL di Local Security Policy untuk mempermudah akses.
+ Atur Power Settings menjadi never agar sistem tidak pernah masuk mode tidur.
+ Lakukan setting apapun yang mana settingan ini akan menjadi default ada saat windows digunakan, misalkan install ffmpeg, install chrome dll

### 7. Kompres File Windows Server
Setelah semua konfigurasi selesai, kompres image Windows Server untuk mempermudah distribusi. Gunakan perintah berikut, ganti xxxx dengan versi Windows (misalnya, windows2019):
```bash
dd if=windowsxxxx.img | gzip -c > windowsxxxx.gz
```

### 8. Instal dan Konfigurasi Apache
Gunakan Apache untuk melayani file melalui web:
1. Instal Apache:
```bash
apt install apache2 -y
```
2. Izinkan akses melalui firewall:
```bash
sudo ufw allow 'Apache'
```
3. Pindahkan file hasil kompresi ke direktori web:
```bash
mv windowsxxxx.gz /var/www/html/
```

### 9. Akses File via Web
Setelah file dipindahkan, Anda dapat mengaksesnya melalui alamat IP server Anda. Misalnya:
```bash
http://[IP_ADDRESS]/windowsxxxx.gz
```
Contoh:
```bash
http://152.41.203.70/windows2019.gz
```

### 10. Menjalankan Windows Server di Droplet Baru
Untuk menginstal Windows Server di droplet baru menggunakan file yang sudah dikompres, gunakan perintah berikut. Ganti LINK dengan URL file hasil kompresi:
```bash
wget -O- --no-check-certificate LINK | gunzip | dd of=/dev/vda
```
## Catatan Penting:
+ Ganti placeholder xxxx dengan versi Windows yang sesuai.
+ Pastikan URL file (LINK) valid dan dapat diakses.
+ Proses ini memerlukan waktu bergantung pada kecepatan jaringan dan ukuran file.
