# BACKUP DAN RECOVERY WIN IMAGE DARI GOOGLE DRIVE
WinServer RDP yang sudah dibuat bisa anda backup ke Google drive dan bisa anda gunakan kapan saja.

## Update dan Upgrade Sistem
```bash
sudo apt update
sudo apt upgrade -y
```
## Instal Python dan pip
```bash
sudo apt install python3 python3-pip -y
```
## Instal gdown
```bash
pip3 install gdown
```
## Instal python3-venv
```bash
sudo apt install python3-venv -y
```
Buat virtual environment:
```bash
python3 -m venv myenv
```
## Aktifkan virtual environment:
```bash
source myenv/bin/activate
```
## Instal gdown di dalam virtual environment:
```bash
pip install gdown
```
## Verifikasi instalasi:
```bash
gdown --version
```
## Download Windows Image
```bash
gdown https://drive.google.com/uc?id=FILE_ID -O - | gunzip | dd of=/dev/vda
```
## Nonaktifkan virtual environment
```bash
deactivate
```
