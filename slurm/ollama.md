# Ollama on Uni-Greifswald HPC Cluster

This guide explains how to run **Ollama** on the Uni-Greifswald HPC cluster using **SLURM** and **Singularity**, since Docker is not available.

---

## 0. Pull or Build the Ollama Container

Before submitting any jobs, you need a **Singularity image** containing Ollama. There are two options:

### Option 0a: Pull from DockerHub (if a prebuilt image exists)

```bash
module load singularity/3.11.3

# Pull the container and create ollama.sif
singularity pull ollama.sif docker://ollama/ollama
```

---

### Option 0b: Build a custom Singularity image from a Dockerfile

1. **Create a Dockerfile** with Ollama installed, for example:

```dockerfile
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Expose API port
EXPOSE 11434

# Default command
CMD ["ollama", "serve"]
```

2. **Build the Docker image locally** (on a machine with Docker):

```bash
docker build -t ollama-api .
```

3. **Push the image to DockerHub** (optional if cluster cannot access local Docker):

```bash
docker tag ollama-api <your-dockerhub-username>/ollama-api:latest
docker push <your-dockerhub-username>/ollama-api:latest
```

4. **Pull into Singularity on the HPC cluster**:

```bash
module load singularity/3.11.3
singularity pull ollama.sif docker://<your-dockerhub-username>/ollama-api:latest
```

5. **Test the image** interactively:

```bash
srun -p vision --gres=gpu:1 --pty bash
singularity exec --nv ollama.sif ollama --version
```

> If this works, `ollama.sif` is ready to use in your SLURM job scripts.

---

This Step 0 ensures your Ollama job will **not fail immediately** due to a missing container.

---

I can now **merge Step 0 with the previous README** into a full final version so it’s fully ready for beginners. Do you want me to do that?


## 1. Prerequisites

* Access to the HPC cluster (`login-a.uni-greifswald.de` or similar).
* Singularity module available (`singularity/3.11.3`).
* SLURM job scheduler for submitting jobs.

Check Singularity:

```bash
module avail singularity
module load singularity/3.11.3
singularity --version
```

---

## 2. Prepare the Ollama Container

Ollama runs inside a container to isolate dependencies.

### Option 1: Pull a Docker image via Singularity

```bash
singularity pull ollama.sif docker://ollama/ollama
```

> ⚠️ Note: Ollama does not provide an official Docker image yet. If this fails, you may need to build your own container.

### Option 2: Build a Singularity image from a local Dockerfile

1. Create a Dockerfile with Ollama installed (see Ollama repo).
2. Build the Singularity image:

```bash
singularity build ollama.sif docker-daemon://ollama-api:latest
```

---

## 3. Create a SLURM Job Script

Example `ollama_job.sh`:

```bash
#!/bin/bash
#SBATCH --job-name=ollama-api
#SBATCH --partition=vision         # GPU nodes
#SBATCH --gres=gpu:1               # Request 1 GPU
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --output=ollama_%j.out
#SBATCH --error=ollama_%j.err

module load singularity/3.11.3

# Run Ollama inside the container
srun singularity exec --nv ollama.sif ollama serve
```

---

## 4. Submit the Job

```bash
sbatch ollama_job.sh
```

Check the job status:

```bash
squeue -u $USER
scontrol show job <jobid>
```

---

## 5. Monitor Progress

Ollama logs go into SLURM output files:

```bash
tail -f ollama_<jobid>.out
tail -f ollama_<jobid>.err
```

* `.out` → standard output (including server startup messages).
* `.err` → errors if the job fails.

---

## 6. Access the Ollama API

Once the job is running, Ollama serves on port **11434** of the allocated GPU node.

* On the compute node:

```bash
curl http://localhost:11434/api/generate -d '{"model":"llama3.2:latest","prompt":"Hello"}'
```

* From outside the cluster (login node or your laptop), use SSH port forwarding:

```bash
ssh -L 11434:<node-name>:11434 $USER@login-a
```

---

## 7. Tips & Troubleshooting

* **Job failed immediately?** Check `.err` file. Most likely the container doesn’t exist or Ollama isn’t installed.
* **Interactive debugging:**

```bash
srun -p vision --gres=gpu:1 --pty bash
module load singularity/3.11.3
singularity exec --nv ollama.sif ollama serve
```

* **Memory/CPU issues:** Adjust `--cpus-per-task` and `--mem` in the SLURM script.