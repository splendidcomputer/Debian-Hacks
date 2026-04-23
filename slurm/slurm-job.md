# Slurm Quickstart Guide (Local Cluster)

## Inspect the Cluster

### Show partitions and node states

```bash
sinfo
```

Key fields:

* **PARTITION** – queue name (e.g. `batch`, `snowball`, `vision`)
* **STATE**

  * `idle` → free
  * `mix` → partially used
  * `alloc` → fully used
  * `down/drain` → unavailable

---

### Show job queue

```bash
squeue
```

Useful variants:

```bash
squeue -u $USER        # your jobs
squeue -p batch        # jobs in a partition
squeue -l              # detailed view
```

---

### Show node details (CPU, RAM, GPU)

```bash
scontrol show nodes
```

For a specific node:

```bash
scontrol show node node083
```

Look for:

* `CPUTot`
* `RealMemory`
* `Gres` → GPUs (e.g. `gpu:4`)
* `GresTypes` or GPU model (if configured)

---

### GPU-specific info (very useful)

```bash
sinfo -o "%P %N %G"
```

Example output meaning:

* `%G` → Generic resources (GPUs)

You can also try:

```bash
scontrol show node | grep -i gpu
```

---

## Running Jobs

### 1. Quick interactive job (debugging)

```bash
srun --pty -p playground -t 01:00:00 bash
```

With GPU:

```bash
srun --pty -p vision --gres=gpu:1 bash
```

---

### 2. Run a Python script (simple)

```bash
srun -p batch python my_script.py
```

---

## Batch Jobs (Recommended)

### Minimal batch script

Create `job.sh`:

```bash
#!/bin/bash
#SBATCH --job-name=test_job
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err
#SBATCH --partition=batch
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G

python my_script.py
```

Submit:

```bash
sbatch job.sh
```

---

### Batch job with GPU

```bash
#!/bin/bash
#SBATCH --job-name=gpu_job
#SBATCH --partition=vision
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G

python train.py
```

---

### Batch job (explicit node type example)

If you know a partition has GPUs (like `vision` or `snowball` depending on config):

```bash
#SBATCH -p vision
#SBATCH --gres=gpu:1
```

---

## Monitor Jobs

```bash
squeue -u $USER
```

Detailed job info:

```bash
scontrol show job <jobid>
```

Cancel job:

```bash
scancel <jobid>
```

---

## Logs

Output files:

```
logs/jobname_jobid.out
logs/jobname_jobid.err
```

Live monitoring:

```bash
tail -f logs/test_job_12345.out
```

---

## Tips

### Find free nodes quickly

```bash
sinfo | grep idle
```

---

### Check GPU availability

```bash
sinfo -o "%P %N %G %t"
```

---

### Run quick test without script

```bash
sbatch --wrap="python my_script.py"
```

---

### Environment setup (important!)

If you use conda or venv:

```bash
source ~/.bashrc
conda activate myenv
```

Add this inside your batch script **before running Python**.

---

## Example: Full Workflow

```bash
# 1. Write script
vim job.sh

# 2. Submit
sbatch job.sh

# 3. Check status
squeue -u $USER

# 4. View output
tail -f logs/jobname_<jobid>.out
```