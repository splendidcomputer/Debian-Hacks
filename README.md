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
https://chat.openai.com/share/dcafe9f8-31ea-4650-b4b9-58ee9434b65f

### Give sudo privileges to a user:
Use the usermod command to add the user to the sudo group. Replace username with the name of the user you want to grant superuser privileges to:

```
sudo usermod -aG sudo username
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

