# WinServerRDP
This repository is for creating Windows Server ISOs from various versions that you can use to set up Windows RDP.

## Installation Steps
### Step 1: Download the Installer File
Use the following command to download the installer:
```bash
wget https://raw.githubusercontent.com/imsamtambur/WinServerRDP/main/Master-WinServer-ISO.sh
```

### Step 2: Grant Execution Permission to the File
After downloading, grant execution permissions to the file:
```bash
chmod +x Master-WinServer-ISO.sh
```

### Step 3: Run the Installer
Execute the installer file with the following command:
```bash
./Master-WinServer-ISO.sh
```

### Step 4: Run Windows Server on QEMU
After installation is complete, use QEMU to launch Windows Server. Replace xxxx with the chosen Windows version (e.g., windows2019):
```bash
qemu-system-x86_64 \
-m 4G \
-cpu host \
-enable-kvm \
-boot order=d \
-drive file=windowsxxxx.iso,media=cdrom \
-drive file=windowsxxxx.img,format=raw,if=virtio \
-drive file=virtio-win.iso,media=cdrom \
-device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
-device usb-tablet \
-vnc :0 \
-audiodev none,id=noaudio
```

### Step 5: Access QEMU via VNC
Once QEMU is running:
+ Use a VNC Viewer application to access the server using the server's IP, username, and password.
+ Complete the installation and configuration of Windows Server in QEMU, such as setting passwords, partitioning, installing drivers with VirtIO, etc.

### Step 6: Configure Windows Server
Once logged in to Windows Server, perform the following steps
+ Enable Remote Desktop through system settings.
+ Disable CTRL+ALT+DEL in Local Security Policy for easier access.
+ Set Power Settings to "Never" to prevent the system from going to sleep.
+ Apply any default settings or installations (e.g., install FFmpeg, Chrome, etc.).

### Step 7: Compress the Windows Server Image
After all configurations are done, compress the Windows Server image for easier distribution. Use the following command, replacing xxxx with the Windows version (e.g., windows2019):
```bash
dd if=windowsxxxx.img | gzip -c > windowsxxxx.gz
```

### Step 8: Install and Configure Apache
Use Apache to serve the file via the web:
1. Install Apache
```bash
apt install apache2 -y
```
2. Allow Access Through Firewall
```bash
sudo ufw allow 'Apache'
```
3. Move Compressed File to Web Directory
```bash
mv windowsxxxx.gz /var/www/html/
```

### Step 9: Access the File via the Web
Once the file is moved, you can access it through your server's IP address. For example:
```bash
http://[IP_ADDRESS]/windowsxxxx.gz
```
Example:
```bash
http://152.41.203.70/windowsxxxx.gz
```

### Step 10: Run Windows Server on a New Droplet
To install Windows Server on a new droplet using the compressed file, use the following command. Replace LINK with the URL of the compressed file:
```bash
wget -O- --no-check-certificate LINK | gunzip | dd of=/dev/vda
```
## Important Notes
+ Replace the xxxx placeholder with the appropriate Windows version.
+ Ensure the file URL (LINK) is valid and accessible.
+ The process duration depends on network speed and file size.
