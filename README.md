# Debian-Hacks
Debian Hacks

### Add _Ctrl+Alt+T_ short key for the terminal:
* Press _super_key_, then search for _shortcuts_;
* Press _+_
  * Name: **Gnome Terminal**
  * Command: **gnome-terminal**
  * Shortcut: **Ctrl+Alt+T**

### Give sudo privileges to a user:
Use the usermod command to add the user to the sudo group. Replace username with the name of the user you want to grant superuser privileges to:

```
sudo usermod -aG sudo username
```

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

```
sudo apt install nvidia-driver
```

Then, please follow the instructions in this link:
https://chat.openai.com/share/dcafe9f8-31ea-4650-b4b9-58ee9434b65f

### Uninstall NVIDIA Drivers
Open a terminal and enter the following command to edit the xorg.conf file using a text editor:
```
sudo nano /etc/X11/xorg.conf
```

Locate the "Device" section in the xorg.conf file that corresponds to your NVIDIA graphics card. It should look similar to the lines you mentioned:

```
Section "Device"
    Identifier "Device0"
    Driver "nvidia"
    Vendorname "NVIDIA corporation"
    BusID "PCI:1:0:0"
EndSection
```
Modify the "Driver" line to use the "modesetting" driver instead of "nvidia":
```
Driver "modesetting"

```

Remove the currently installed NVIDIA driver:
```
sudo apt-get purge nvidia*
```
Next, make sure that your system is up-to-date:

```
sudo apt-get update
sudo apt-get upgrade
```



### error: externally-managed-environment
Please refer to these links:

https://askubuntu.com/questions/1465218/pip-error-on-ubuntu-externally-managed-environment-%C3%97-this-environment-is-extern
https://www.omgubuntu.co.uk/2023/04/pip-install-error-externally-managed-environment-fix


### Everything you should know about venv:
You can create a virtual environment in Debian by using either `venv` or `virtualenv`, which are Python's built-in library for creating isolated environments. Here is how you can do it with `venv`:

1. First, you need to ensure that you have the `venv` module installed. In Python 3.3 and later, it is included by default. If you need to install it separately, you can do so by running:
   
   ```bash
   sudo apt-get install python3-venv
   ```

2. Now, navigate to the directory where you want to create your virtual environment. For example, if you want to create a directory in your home directory called `my_env`, you would first navigate to your home directory:
   
   ```bash
   cd ~
   ```

3. Then, you can create your virtual environment by running:
   
   ```bash
   python3 -m venv my_env
   ```
   
   This command will create a new directory named `my_env` which contains the directories and files that make up the virtual environment.

4. Before you can start installing packages into or running Python from your virtual environment, you'll need to activate it. You can do this by running:

   ```bash
   source my_env/bin/activate
   ```
   
   You'll know that your virtual environment is activated because its name will now appear on the left side of your terminal prompt.

5. Now, you're free to install packages into your virtual environment without affecting your global Python installation. For example, you could install `jsonargparse` by running:
   
   ```bash
   pip install jsonargparse
   ```
   
6. Once you're finished working in your virtual environment, you can deactivate it and return to your global Python environment by running:

   ```bash
   deactivate
   ```

Remember, every time you want to work in your virtual environment, you need to activate it first using the `source my_env/bin/activate` command (replacing `my_env` with the name of your environment if it's different).

### Activate your environment

If you're using virtualenv or venv, you should activate the environment before running your Python script. This can be done using the source command, like so:
```
(ll) mostafa@chat-ai:~/programming/lit-llama$ source env/bin/activate
(env) mostafa@chat-ai:~/programming/lit-llama$ python3 scripts/download.py --repo_id openlm-research/open_llama_7b --local_dir checkpoints/open-llama/7B
```
### Enable Flatpak
Open the terminal, then we should install two packages:
```
sudo apt install gnome-software-plugin-flatpak

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
Then we should do is to go into the gnome-software app and click on the _Restart Now_ button. Then, it will refresh. Now, we should have access to additional software.

### [The First 12 Things You Should Do After Installing Debian 12 “Bookworm”!](https://www.learnlinux.tv/debian-12-12/)

### Install TeX Live!
First, locate the downloaded ISO file. The file should be named something like texlive.iso.

Mount the ISO file. To do this, you first need to create a directory that will serve as the mount point. Open your terminal and type:
```
sudo mkdir /mnt/texlive
```
Then, mount the ISO file to this directory:
```
sudo mount -o loop /path/to/texlive.iso /mnt/texlive
```

Replace /path/to/texlive.iso with the path to the ISO file on your system.

Install TeX Live. Change to the directory where the ISO file is mounted and run the installer:

```
cd /mnt/texlive
sudo ./install-tl
```
This will start the TeX Live installer. It's interactive and you should be able to just press I and then Enter to start the installation with the default settings. If you need to customize the installation, you can do so within this installer.

Set up the PATH. After the installation, you need to add TeX Live binaries to your system PATH. Typically, they are installed under /usr/local/texlive/2023/bin/x86_64-linux (replace 2023 with the year of your TeX Live edition and x86_64-linux with your architecture, if different).

You can add this to your PATH by editing your .bashrc or .bash_profile file (use nano, vim, or any text editor you prefer):

```
nano ~/.bashrc
```
Then, add the following line at the end of the file:
```
export PATH="/usr/local/texlive/2023/bin/x86_64-linux:$PATH"
```
Save and exit. To apply the changes, close and reopen your terminal, or source the updated file:
```
source ~/.bashrc
```
Unmount the ISO. After you have finished the installation, you can unmount the ISO file:
```
sudo umount /mnt/texlive
```
Now, you should have TeX Live installed on your system and you can use it to create and compile your TeX documents.

