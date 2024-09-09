# Debian-Hacks

## Table of Contents

- [Debian-Hacks](#debian-hacks)
  - [Table of Contents](#table-of-contents)
    - [Add Ctrl+Alt+T shortcut for the terminal](#add-ctrlaltt-shortcut-for-the-terminal)
    - [Give sudo privileges to a user](#give-sudo-privileges-to-a-user)
    - [Edit the sources list](#edit-the-sources-list)
    - [Install NVIDIA Drivers](#install-nvidia-drivers)
    - [Recognize the second connected display](#recognize-the-second-connected-display)
    - [Uninstall NVIDIA Drivers](#uninstall-nvidia-drivers)
    - [Fix error: externally-managed-environment](#fix-error-externally-managed-environment)
    - [Everything you should know about venv](#everything-you-should-know-about-venv)
    - [Activate your environment](#activate-your-environment)
    - [Enable Flatpak](#enable-flatpak)
    - [Configuration of the partitioning for the LVM](#configuration-of-the-partitioning-for-the-lvm)
    - [The First 12 Things You Should Do After Installing Debian 12 “Bookworm”!](#the-first-12-things-you-should-do-after-installing-debian-12-bookworm)
    - [Installing TeXLive (First Approach - Recommended)](#installing-texlive-first-approach---recommended)
    - [Install TeXLive! (Second approach)](#install-texlive-second-approach)
    - [Install TeXStudio](#install-texstudio)
    - [LaTeX Compilation Commands to Resolve Hyperlink Issue](#latex-compilation-commands-to-resolve-hyperlink-issue)
    - [Create a Desktop Shortcut File](#create-a-desktop-shortcut-file)
    - [Warnings](#warnings)
- [Installing RStudio on Debian 12](#installing-rstudio-on-debian-12)
- [Replacing all instances of a string in project directory excluding the .git](#replacing-all-instances-of-a-string-in-project-directory-excluding-the-git)
- [Installing docker-compose](#installing-docker-compose)
- [Installing nodejs](#installing-nodejs)

### Add Ctrl+Alt+T shortcut for the terminal

- Press the _super key_, then search for _shortcuts_.
- Press _+_
  - Name: **Gnome Terminal**
  - Command: **gnome-terminal**
  - Shortcut: **Ctrl+Alt+T**

### Give sudo privileges to a user

Use the usermod command to add the user to the sudo group. Replace username with the name of the user you want to grant superuser privileges to:

```bash
su -
sudo usermod -aG sudo username
```
#### Verify Group Membership:
To verify that splenda is now in the sudo group, run:

```bash
groups username
```

### Edit the sources list

We should comment out the _deb cdrom:[Debian GNU/Linux 12.7.0 \_Bullseye_ - Official amd64 DVD Binary-1 2>\_ from the sources list:

```bash
sudo nano /etc/apt/sources.list
```

The sources list should look like this:

```bash
# deb cdrom:[Debian GNU/Linux 12.7.0 _Bookworm_ - Official amd64 DVD Binary-1 2>

deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

# bookworm-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates>
deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
```

### Install NVIDIA Drivers

First, **disable the secure boot** feature from your BIOS.

```bash
sudo apt install nvidia-driver
```

### Recognize the second connected display

To recognize the second display connected to your system, run:

```bash
xrandr
```

### Uninstall NVIDIA Drivers

To uninstall NVIDIA drivers, follow these steps:

1. Open a terminal and edit the xorg.conf file using a text editor:

   ```bash
   sudo nano /etc/X11/xorg.conf
   ```

2. Locate the "Device" section in the xorg.conf file that corresponds to your NVIDIA graphics card. It should look similar to this:

   ```bash
   Section "Device"
       Identifier "Device0"
       Driver "nvidia"
       Vendorname "NVIDIA corporation"
       BusID "PCI:1:0:0"
   EndSection
   ```

3. Modify the "Driver" line to use the "modesetting" driver instead of "nvidia":

   ```bash
   Driver "modesetting"
   ```

4. Remove the currently installed NVIDIA driver:

   ```bash
   sudo apt-get purge nvidia*
   ```

5. Make sure your system is up-to-date:

   ```bash
   sudo apt-get update
   sudo apt-get upgrade
   ```

### Fix error: externally-managed-environment

If you encounter an "externally-managed environment" error while using pip, refer to these helpful links:

- [Ask Ubuntu: pip error on Ubuntu "externally managed environment"](https://askubuntu.com/questions/1465218/pip-error-on-ubuntu-externally-managed-environment-%C3%97-this-environment-is-extern)
- [OMG! Ubuntu!: How to Fix 'pip install' Error: 'externally managed environment'](https://www.omgubuntu.co.uk/2023/04/pip-install-error-externally-managed-environment-fix)

### Everything you should know about venv

To create a virtual environment in Debian using `venv`:

1. Ensure the `venv` module is installed:

   ```bash
   sudo apt-get install python3-venv
   ```

2. Navigate to the directory where you want to create your virtual environment:

   ```bash
   cd ~
   ```

3. Create the virtual environment:

   ```bash
   python3 -m venv my_env
   ```

4. Activate the environment:

   ```bash
   source my_env/bin/activate
   ```

5. Install packages in the virtual environment:

   ```bash
   pip install jsonargparse
   ```

6. Deactivate the environment when finished:

   ```bash
   deactivate
   ```

### Activate your environment

To activate a virtual environment, use the `source` command:

```bash
source env/bin/activate
```

### Enable Flatpak

To enable Flatpak support on Debian, install the required packages:

```bash
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Then, open the gnome-software app and click on the _Restart Now_ button to refresh and access additional software.

### Configuration of the partitioning for the LVM

To configure partitioning for the LVM, execute the `partition_setup.sh` script:

1. Make the script executable:

   ```bash
   chmod +x partition_setup.sh
   ```

2. Run the script:

   ```bash
   ./partition_setup.sh
   ```

### The First 12 Things You Should Do After Installing Debian 12 “Bookworm”!

For a comprehensive guide on the first 12 things you should do after installing Debian 12 "Bookworm", refer to [this article](https://www.learnlinux.tv/debian-12-12/).

### Installing TeXLive (First Approach - Recommended)

To install TeX Live on Debian:

1. Update the package lists:

   ```bash
   sudo apt update
   ```

2. Install TeX Live:

   ```bash
   sudo apt install texlive-full
   ```

3. Verify the installation:

   ```bash
   tex --version
   ```

### Install TeXLive! (Second approach)

To install TeX Live from an ISO file:

1. Mount the ISO file:

   ```bash
   sudo mkdir /mnt/texlive
   sudo mount -o loop /path/to/texlive.iso /mnt/texlive
   ```

2. Run the installer:

   ```bash
   cd /mnt/texlive
   sudo ./install-tl
   ```

3. Update the PATH:

   ```bash
   nano ~/.bashrc
   export PATH="/usr/local/texlive/2023/bin/x86_64-linux:$PATH"
   source ~/.bashrc
   ```

4. Unmount the ISO:

   ```bash
   sudo umount /mnt/texlive
   ```

### Install TeXStudio

To install TeXStudio:

1. Update package lists:

   ```bash
   sudo apt update
   ```

2. Install TeXStudio:

   ```bash
   sudo apt install texstudio
   ```

3. Launch TeXStudio:

   ```bash
   texstudio
   ```

### LaTeX Compilation Commands to Resolve Hyperlink Issue

To resolve hyperlink issues in LaTeX documents:

1. Compile with `pdflatex`:

   ```bash
   pdflatex yourfile.tex
   ```



2. Compile with `bibtex`:

   ```bash
   bibtex yourfile
   ```

3. Compile twice with `pdflatex`:

   ```bash
   pdflatex yourfile.tex
   pdflatex yourfile.tex
   ```

### Create a Desktop Shortcut File

To create a desktop shortcut file:

1. Create the `.desktop` file:

   ```bash
   nano ~/.local/share/applications/myapp.desktop
   ```

2. Add the following contents:

   ```plaintext
   [Desktop Entry]
   Name=My App
   Comment=My application description
   Exec=/usr/bin/myapp
   Icon=/usr/share/pixmaps/myapp.png
   Terminal=false
   Type=Application
   ```

3. Save the file and make it executable:

   ```bash
   chmod +x ~/.local/share/applications/myapp.desktop
   ```

### Warnings

#### Beware of System Commands

Be cautious when executing system commands that can alter your system’s configuration. For example, the `dd` command can overwrite partitions if used improperly. Always double-check commands and understand their function before execution.

### Installing RStudio on Debian 12

To install RStudio on Debian 12, follow these steps:

1. Update the package lists:

   ```bash
   sudo apt update
   ```

2. Install dependencies:

   ```bash
   sudo apt install r-base gdebi-core
   ```

3. Download the RStudio package:

   ```bash
   wget https://download1.rstudio.org/desktop/debian10/x86_64/rstudio-2023.06.1-524-amd64.deb
   ```

4. Install the package:

   ```bash
   sudo gdebi rstudio-2023.06.1-524-amd64.deb
   ```

5. Launch RStudio:

   ```bash
   rstudio
   ```

### Replacing all instances of a string in project directory excluding the .git

To replace all instances of a string in a project directory while excluding the `.git` directory:

```bash
grep -rli 'old_string' * | grep -v '.git' | xargs -i@ sed -i 's/old_string/new_string/g' @
```

### Installing docker-compose

To install Docker Compose:

1. Install Docker:

   ```bash
   sudo apt update
   sudo apt install docker.io
   ```

2. Download the Docker Compose binary:

   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/download/2.10.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```

3. Apply executable permissions:

   ```bash
   sudo chmod +x /usr/local/bin/docker-compose
   ```

4. Verify the installation:

   ```bash
   docker-compose --version
   ```

### Installing nodejs

To install Node.js on Debian:

1. Update the package lists:

   ```bash
   sudo apt update
   ```

2. Install Node.js:

   ```bash
   sudo apt install nodejs
   sudo apt install npm
   ```

3. Verify the installation:

   ```bash
   node --version
   npm --version
   ```

This concludes the Debian-Hacks guide. Follow these steps and commands carefully to get the best experience using Debian.
