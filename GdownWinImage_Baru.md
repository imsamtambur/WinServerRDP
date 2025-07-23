# PANDUAN UPDATE BACKUP DAN RECOVERY WIN IMAGE DARI GOOGLE DRIVE
WinServer RDP yang sudah dibuat bisa anda backup ke Google drive dan bisa anda gunakan kapan saja.

## Update dan Upgrade System OS 
```bash
sudo apt update
```
Untuk Upgrade Optional (Bisa di lewati)
```bash
sudo apt upgrade -y
```

## Install Python dan PIP
```bash
sudo apt install python3 python3-pip -y
```
## Cek Sukses Install Phyton dan PIP (Optional bisa dilewati)
Untuk memastikan install phyton dan PIP sukses, lakukan pengecekan dengan perintah dibawah satu-satu, tanda sukses akan muncul versi phyton dan versi PIP
```bash
python3 --version
```
```bash
pip3 --version
```
## Install dan jalankan Virtual Environment
Jalankan Satu-satu perntah dibawah ini
```bash
sudo apt update
```
```bash
sudo apt install python3.12-venv -y
```
```bash
python3 -m venv venv
```
```bash
source venv/bin/activate
```
Tandanya sukses menjalankan enviroment nanti di command akan di awali (venv).
Contoh :
(venv) root@RDPKU:~#

Setelah itu bisa lanjut install gdown menggunakan envoriment

## Install GDown
```bash
pip install gdown
```
## Verifikasi GDwon  (Optional bisa dilewati)
Untuk memastikan install gdown sukses, lakukan pengecekan dengan perintah dibawah, tanda sukses akan muncul versi gdown
```bash
gdown --version
```
## Download, Dekompres dan Recovery Windows Image
```bash
gdown https://drive.google.com/uc?id=FILE_ID -O - | gunzip | dd of=/dev/vda
```
