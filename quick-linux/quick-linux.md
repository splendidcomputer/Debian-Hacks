
# 1) Navigation & Files (the absolute base)

### Show where you are

```bash
pwd
```

* Prints the **current working directory** (your location in the filesystem).

---

### List files

```bash
ls
```

* Lists files in the current directory.

```bash
ls -l
```

* Long format: shows permissions, owner, size, date.

```bash
ls -a
```

* Shows hidden files (like `.bashrc`).

---

### Change directory

```bash
cd /path/to/folder
```

* Moves you to another directory.

```bash
cd ~
```

* Goes to your home directory.

```bash
cd ..
```

* Moves one level up.

---

### Create / copy / move / delete

```bash
mkdir data
```

* Creates a directory named `data`.

```bash
cp file.txt copy.txt
```

* Copies `file.txt` → `copy.txt`.

```bash
mv file.txt archive/
```

* Moves file into `archive/` (also renames if target is a file).

```bash
rm file.txt
```

* Deletes a file.

```bash
rm -r folder/
```

* Deletes a folder recursively.

---

# 2) Permissions (why things fail)

### View permissions

```bash
ls -l
```

Example output:

```
-rwxr-xr-- 1 user group file.txt
```

Meaning:

* `r` = read
* `w` = write
* `x` = execute

---

### Change permissions

```bash
chmod +x script.sh
```

* Makes a file executable.

---

### Change owner

```bash
chown user:group file.txt
```

* Changes ownership.

---

# 3) Viewing & searching files

### Print file contents

```bash
cat file.txt
```

* Dumps entire file to terminal.

---

### Scroll large files

```bash
less file.txt
```

* Opens interactive viewer (press `q` to quit).

---

### Search text

```bash
grep "error" log.txt
```

* Finds lines containing `"error"`.

---

# 4) Pipes and redirection (core power)

### Redirect output

```bash
ls > files.txt
```

* Saves output of `ls` into `files.txt` (overwrites).

```bash
ls >> files.txt
```

* Appends instead of overwriting.

---

### Pipe commands

```bash
cat log.txt | grep "error"
```

* Sends output of `cat` into `grep`.

Better version:

```bash
grep "error" log.txt
```

---

### Count lines

```bash
wc -l file.txt
```

* Counts number of lines.

---

### Example pipeline (very common)

```bash
grep "ERROR" log.txt | sort | uniq | wc -l
```

* Find errors → sort → remove duplicates → count them.

---

# 5) Processes (running programs)

### Show processes

```bash
ps aux
```

* Lists all running processes.

---

### Real-time monitoring

```bash
top
```

* Shows CPU/memory usage live.

Better version:

```bash
htop
```

* More readable (if installed).

---

### Kill a process

```bash
kill 1234
```

* Stops process with PID 1234.

Force kill:

```bash
kill -9 1234
```

---

# 6) Running jobs in background

### Run in background

```bash
python train.py &
```

* Runs script in background.

---

### List jobs

```bash
jobs
```

---

### Bring back to foreground

```bash
fg
```

---

# 7) Environment variables

### Show variable

```bash
echo $PATH
```

* Displays PATH (where executables are searched).

---

### Set variable (temporary)

```bash
export DATA_PATH=/data/project
```

---

# 8) `.bashrc` (your customization file)

This file runs when a new shell starts in Bash.

### Open it

```bash
nano ~/.bashrc
```

---

### Example additions

```bash
alias ll="ls -la"
```

* Creates shortcut: `ll` runs `ls -la`.

```bash
export PATH="$HOME/bin:$PATH"
```

* Adds custom programs to your PATH.

---

### Apply changes

```bash
source ~/.bashrc
```

* Reloads the file without restarting terminal.

---

# 9) Remote servers (essential for AI work)

### Connect to server

```bash
ssh user@server-ip
```

* Logs into a remote machine.

---

### Copy file to server

```bash
scp file.txt user@server:/path/
```

---

### Sync folders (better for large data)

```bash
rsync -av data/ user@server:/data/
```

---

# 10) Long-running sessions

Use tmux:

### Start session

```bash
tmux
```

### Detach (leave running)

Press:

```
Ctrl + b, then d
```

### Reattach

```bash
tmux attach
```

---

# 11) Package management

### Install software (Debian/Ubuntu)

```bash
sudo apt update
```

* Updates package list.

```bash
sudo apt install htop
```

* Installs program.

---

# 12) System services (what is systemd)

systemd manages background services.

### Check service

```bash
systemctl status ssh
```

### Start service

```bash
sudo systemctl start ssh
```

### Stop service

```bash
sudo systemctl stop ssh
```

---

### View logs

```bash
journalctl -u ssh
```

* Shows logs for a service.

---

# 13) Simple Bash script

Create a file:

```bash
nano script.sh
```

Add:

```bash
#!/bin/bash
echo "Starting job"
python train.py
echo "Done"
```

Make executable:

```bash
chmod +x script.sh
```

Run:

```bash
./script.sh
```

---

# What to practice (important)

Do these to internalize:

1. Navigate directories without thinking
2. Search logs with `grep`
3. Build pipelines using `|`
4. Run and monitor a training script
5. Use `tmux` for long jobs
6. Customize `.bashrc` with aliases

