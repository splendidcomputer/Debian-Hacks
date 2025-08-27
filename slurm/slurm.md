

# Beginner’s Guide: Submitting Jobs with SLURM

SLURM is a **job scheduler** that decides when and where your jobs run on a cluster. Instead of running commands directly on the login node, you write a **job script** that tells SLURM what resources you need and what commands to execute.

---

## 1. Create a Job Script

A **job script** is just a shell script (a `.sh` file). It contains two things:

1. **Resource requests** → how much time, memory, CPUs, or GPUs you need.
2. **Your commands** → the actual program or script you want to run.

Here’s the simplest “Hello World” example:

```bash
#!/bin/bash
#SBATCH --job-name=hello            # A name for your job
#SBATCH --partition=playground      # Which partition/queue to use
#SBATCH --nodes=1                   # Run on 1 node
#SBATCH --ntasks=1                  # Run 1 task (process)
#SBATCH --time=00:01:00             # Max runtime (HH:MM:SS)
#SBATCH --output=hello.out          # File to save standard output
#SBATCH --error=hello.err           # File to save error messages

# Print some information
echo "Hello from $(hostname) at $(date)"

# Simulate some work
sleep 30

echo "Job completed!"
```

Save this as **`hello.sh`**.

---

## 2. Submit Your Job

Run:

```bash
sbatch hello.sh
```

SLURM will respond with something like:

```
Submitted batch job 12345
```

This number is your **Job ID**.

---

## 3. Check Job Status

* See all your running jobs:

  ```bash
  squeue -u $USER
  ```

* See detailed info about a job:

  ```bash
  scontrol show job 12345
  ```

---

## 4. Look at the Output

Once your job finishes, check the output files:

```bash
cat hello.out
cat hello.err
```

If everything worked, `hello.out` will contain:

```
Hello from nodeXYZ at Tue Aug 26 12:34:56
Job completed!
```

---

✅ That’s it — you’ve run your first SLURM job!

---

👉 Next steps you can add later:

* Requesting more CPUs or memory.
* Running on multiple nodes.
* Submitting GPU jobs.
* Using `module load` to set up software environments.

---

Would you like me to expand this tutorial into a **“Part 2”** where I show beginners how to request **more resources (CPUs, memory, GPUs)** in a friendly way? That’s usually the next stumbling block.
