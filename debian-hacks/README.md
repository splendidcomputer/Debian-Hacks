# Debian-Hacks

Debian Hacks

### Add _Ctrl+Alt+T_ short key for the terminal:

- Press _super_key_, then search for _shortcuts_;
- Press _+_
  - Name: **Gnome Terminal**
  - Command: **gnome-terminal**
  - Shortcut: **Ctrl+Alt+T**

### Give sudo privileges to a user:

Use the usermod command to add the user to the sudo group. Replace username with the name of the user you want to grant superuser privileges to:

```bash
su -
```


```bash
sudo usermod -aG sudo username
```

### Edit the sources list:

We should comment out the _deb cdrom:[Debian GNU/Linux 12.5.0 \_Bullseye_ - Official amd64 DVD Binary-1 2>\_ from the sources list:

`sudo nano /etc/apt/sources.list`

The sources list should look like this:

```bash                                                                                         
# deb cdrom:[Debian GNU/Linux 12.5.0 _Bookworm_ - Official amd64 DVD Binary-1 2>

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

### Recognise the second connected display

```bash
xrandr
```

### Uninstall NVIDIA Drivers

Open a terminal and enter the following command to edit the xorg.conf file using a text editor:

```bash
sudo nano /etc/X11/xorg.conf
```

Locate the "Device" section in the xorg.conf file that corresponds to your NVIDIA graphics card. It should look similar to the lines you mentioned:

```bash
Section "Device"
    Identifier "Device0"
    Driver "nvidia"
    Vendorname "NVIDIA corporation"
    BusID "PCI:1:0:0"
EndSection
```

Modify the "Driver" line to use the "modesetting" driver instead of "nvidia":

```bash
Driver "modesetting"

```

Remove the currently installed NVIDIA driver:

```bash
sudo apt-get purge nvidia*
```

Next, make sure that your system is up-to-date:

```bash
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

```bash
(ll) mostafa@chat-ai:~/programming/lit-llama$ source env/bin/activate
(env) mostafa@chat-ai:~/programming/lit-llama$ python3 scripts/download.py --repo_id openlm-research/open_llama_7b --local_dir checkpoints/open-llama/7B
```

### Enable Flatpak

Open the terminal, then we should install two packages:

```bash
sudo apt install gnome-software-plugin-flatpak

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Then we should do is to go into the gnome-software app and click on the _Restart Now_ button. Then, it will refresh. Now, we should have access to additional software.

**Configuration of the partitioning for the LVM**

We should execute the [partition_setup.sh](../partition_setup.sh) file.

Make it executable with the chmod command:

```bash
chmod +x partition_setup.sh
```

Finally, you can execute the script by running:

```bash
./partition_setup.sh
```

### [The First 12 Things You Should Do After Installing Debian 12 “Bookworm”!](https://www.learnlinux.tv/debian-12-12/)

### Install TeXLive! (First approach)

To install TeX Live on Debian, you can use the package manager `apt`. Here's how you can do it:

1. **Update Package Lists**: It's a good practice to update your package lists before installing new packages. Run the following command:
   ```bash
   sudo apt update
   ```


2. **Install TeX Live**: You can install the full TeX Live distribution or choose to install specific packages. For the full distribution, you can use the `texlive-full` package, but note that it's quite large. Alternatively, you can install individual packages as needed.

   To install the full TeX Live distribution:
   ```bash
   sudo apt install texlive-full
   ```

   To install a smaller set of basic packages:
   ```bash
   sudo apt install texlive-base
   ```

   You can also install additional packages as needed. For example, if you're working with LaTeX documents, you might want to install `texlive-latex-extra`:
   ```bash
   sudo apt install texlive-latex-extra
   ```

3. **Verify Installation**: Once the installation is complete, you can verify that TeX Live is installed correctly by checking the version:
   ```bash
   tex --version
   ```

   This command should output the version information for TeX Live.

That's it! TeX Live should now be installed on your Debian system. You can start using it to create and edit LaTeX documents. If you need additional packages or functionality, you can install them using `apt` as needed.

### Install TeXLive! (Second approach)

First, locate the downloaded ISO file. The file should be named something like texlive.iso.

Mount the ISO file. To do this, you first need to create a directory that will serve as the mount point. Open your terminal and type:

```bash
sudo mkdir /mnt/texlive
```

Then, mount the ISO file to this directory:

```bash
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

```bash
source ~/.bashrc
```

Unmount the ISO. After you have finished the installation, you can unmount the ISO file:

```bash
sudo umount /mnt/texlive
```

Now, you should have TeX Live installed on your system and you can use it to create and compile your TeX documents.

### Install TeXStudio

To install TeXStudio on Debian, you can use the package manager `apt`. Here's how to do it:

1. **Update Package Lists**: Before installing any new packages, it's recommended to update your package lists:
   ```bash
   sudo apt update
   ```

2. **Install TexStudio**: TexStudio is available in the Debian repositories. You can install it using the following command:
   ```bash
   sudo apt install texstudio
   ```

3. **Verify Installation**: Once the installation is complete, you can verify that TexStudio is installed correctly by running it from the terminal:
   ```bash
   texstudio
   ```
   Alternatively, you can search for TexStudio in your desktop environment's application menu and launch it from there.

4. **Optional**: If you encounter any issues or want to ensure that you have the latest version of TexStudio, you can download and install it from the official website. Here are the general steps:

   - Go to the TexStudio website: [https://www.texstudio.org/](https://www.texstudio.org/)
   - Download the appropriate package for Debian.
   - Install the downloaded package using your package manager or by running it from the terminal.

However, using the version from the official Debian repositories is generally recommended as it will be automatically updated along with the rest of your system's packages.

That's it! TexStudio should now be installed on your Debian system, and you can use it for editing LaTeX documents. If you need any additional packages or assistance, feel free to ask!

### Create a Desktop Shortcut File

Creating a desktop shortcut for a program in Debian involves a few steps. You can use the `.desktop` file format to create shortcuts. Here's a step-by-step guide:

1. **Create a Desktop Entry File (.desktop)**:
   Open a text editor (such as `nano` or `gedit`) with administrative privileges and create a `.desktop` file for the program you want to create a shortcut for. Replace `YourProgram` with the actual program name:

   ```bash
   sudo nano /usr/share/applications/YourProgram.desktop
   ```

2. **Edit the Desktop Entry File**:
   In the text editor, add the following content to the `.desktop` file, customizing the fields as needed:

   ```plaintext
   [Desktop Entry]
   Name=Your Program Name
   Exec=/path/to/your/program
   Icon=/path/to/your/program/icon.png
   Type=Application
   Categories=Utility;Application;OtherCategory
   ```

   - `Name`: The display name for your program.
   - `Exec`: The command to execute the program. Replace `/path/to/your/program` with the actual path to your program's executable.
   - `Icon`: Path to an icon for your program.
   - `Type`: Should be set to `Application`.
   - `Categories`: Categories the program belongs to. You can use existing categories or create custom ones.

3. **Save and Exit**:

   **Nano**:
   Save the file (`Ctrl + O` in `nano`) and exit the text editor (`Ctrl + X` in `nano`).

   **vim**: After editing, press `Esc`, then type `:wq` and press `Enter` to save and exit. Use `:q!` to exit without saving changes.

4. **Make the File Executable**:
   Make sure the `.desktop` file is executable:

   ```bash
   sudo chmod +x /usr/share/applications/YourProgram.desktop
   ```

5. **Refresh Desktop Entries**:
   Refresh the desktop entry cache so that the new shortcut becomes visible:

   ```bash
   sudo update-desktop-database
   ```

6. **The Shortcut is Ready**:
   You should now be able to find the program's shortcut in your application menu or by searching for its name.

Note that some desktop environments like GNOME might also allow you to directly create shortcuts by right-clicking on the desktop or the application menu. This can be a more user-friendly way to create shortcuts.

Remember to replace placeholders like `YourProgram` and file paths with actual values relevant to your setup.

### Warnings

**AnyDesk Warning**:

`W: http://deb.anydesk.com/dists/all/InRelease: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.`

**Solution:**

```bash
cd /etc/apt
sudo cp trusted.gpg trusted.gpg.d
```

# Installing RStudio on Debian 12

To install RStudio on Debian 12, you can follow these steps:

```bash
# Download and install the required version of OpenSSL (libssl1.1):
sudo wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.1n-0+deb10u6_amd64.deb
sudo dpkg -i libssl1.1_1.1.1n-0+deb10u6_amd64.deb

# Download the RStudio package:
wget https://download1.rstudio.org/electron/focal/amd64/rstudio-2023.09.0-463-amd64.deb

# Install RStudio using gdebi:
sudo gdebi rstudio-2023.09.0-463-amd64.deb
```
# Replacing all instances of a string in the project directory excluding the .git
```bash
find /path/to/project -type f -not -path '*/.git/*' -exec sed -i 's/old_string/new_string/g' {} +

```
