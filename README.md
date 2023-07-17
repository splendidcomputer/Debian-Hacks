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

The sources list should look like this:
```
  GNU nano 5.4                  /etc/apt/sources.list                           
# deb cdrom:[Debian GNU/Linux 11.7.0 _Bullseye_ - Official amd64 DVD Binary-1 2>

# deb cdrom:[Debian GNU/Linux 11.7.0 _Bullseye_ - Official amd64 DVD Binary-1 2>

deb http://deb.debian.org/debian/ bullseye main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye main contrib non-free

deb http://security.debian.org/debian-security bullseye-security main contrib n>
deb-src http://security.debian.org/debian-security bullseye-security main contr>

# bullseye-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates>
deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye-updates main contrib non-free
```

### Install NVIDIA Drivers
First, **disable the secure boot** feature from your BIOS.

Then, please follow the instructions in this link:
https://www.if-not-true-then-false.com/2021/debian-ubuntu-linux-mint-nvidia-guide/

or you can use this command to install the Nvidia driver:
```sudo apt-get install nvidia-driver```

### Give sudo privileges to a user:
Use the usermod command to add the user to the sudo group. Replace username with the name of the user you want to grant superuser privileges to:

```
sudo usermod -aG sudo username
```

### error: externally-managed-environment
Please refer to these links:

https://askubuntu.com/questions/1465218/pip-error-on-ubuntu-externally-managed-environment-%C3%97-this-environment-is-extern
https://www.omgubuntu.co.uk/2023/04/pip-install-error-externally-managed-environment-fix

### Activate your environment

If you're using virtualenv or venv, you should activate the environment before running your Python script. This can be done using the source command, like so:
```
(ll) mostafa@chat-ai:~/programming/lit-llama$ source env/bin/activate
(env) mostafa@chat-ai:~/programming/lit-llama$ python3 scripts/download.py --repo_id openlm-research/open_llama_7b --local_dir checkpoints/open-llama/7B
```

