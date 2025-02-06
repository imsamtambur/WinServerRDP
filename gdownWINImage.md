# BACKUP DAN RECOVERY WIN IMAGE DARI GOOGLE DRIVE
WinServer RDP yang sudah dibuat bisa anda backup ke Google drive dan bisa anda gunakan kapan saja.

## Update dan Upgrade System OS
```bash
sudo apt update
```
```bash
sudo apt upgrade -y
```

## Install Python dan PIP
```bash
apt install python  python-pip -y
```
## Install GDown
```bash
pip install gdown
```
## Verifikasi GDwon
```bash
gdown --version
```
## Download, Dekompres dan Recovery Windows Image
```bash
gdown https://drive.google.com/uc?id=FILE_ID -O - | gunzip | dd of=/dev/vda
```
