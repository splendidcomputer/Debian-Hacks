# Debian-Hacks
Debian Hacks

### Add _Ctrl+Alt+T_ short key for the terminal:
* Press _super_key_, then search for _shortcuts_;
* Press _+_
  * Name: **Gnome Terminal**
  * Command: **gnome-terminal**
  * Shortcut: **Ctrl+Alt+T**
  

### Edit the sources list:

We should comment out the _deb cdrom:[Debian GNU/Linux 11.7.0 _Bullseye_ - Official amd64 DVD Binary-1 2>_ from the sources list:

```sudo nano /etc/apt/sources.list```

### Install NVIDIA Drivers
First, **disable the secure boot** feature from your BIOS.

Then, please follow the instructions in this link:
https://www.if-not-true-then-false.com/2021/debian-ubuntu-linux-mint-nvidia-guide/

or you can use this command to install the Nvidia driver:
```sudo apt-get install nvidia-driver```
