# Installing Ollama on a SLURM Cluster (No Sudo Required)

Ollama ships as a self-contained tarball, so no root or sudo access is needed.
Everything installs entirely under your home directory (or any path you own).

---

## 1. Installation

```bash
# Pick a version from https://github.com/ollama/ollama/releases
OLLAMA_VERSION="0.6.5"   # change to the latest release

mkdir -p ~/bin/ollama
curl -L "https://github.com/ollama/ollama/releases/download/v${OLLAMA_VERSION}/ollama-linux-amd64.tgz" \
     -o /tmp/ollama.tgz

tar -xzf /tmp/ollama.tgz -C ~/bin/ollama/
rm /tmp/ollama.tgz
```

After extraction the layout is:

```
~/bin/ollama/
├── bin/ollama          # main executable
├── cuda_v12/           # cuBLAS libs for CUDA 12.x
├── lib/                # other shared libs
└── libggml-*.so        # CPU GGML backends (AVX2, AVX512, …)
```

Add the binary to your `PATH` permanently:

```bash
echo 'export PATH="$HOME/bin/ollama/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Verify:

```bash
ollama --version
```

---

## 2. Upgrading

Re-extract the new tarball **over** the existing directory.
Models stored in `~/.ollama/models/` are **not touched**.

```bash
OLLAMA_VERSION="0.X.Y"   # target version

curl -L "https://github.com/ollama/ollama/releases/download/v${OLLAMA_VERSION}/ollama-linux-amd64.tgz" \
     -o /tmp/ollama.tgz

tar -xzf /tmp/ollama.tgz -C ~/bin/ollama/
rm /tmp/ollama.tgz

ollama --version   # confirm
```

> **Tip:** Check release notes on GitHub before upgrading — new versions
> occasionally change the model storage format or API endpoints.

---

## 3. Pulling models

Models are downloaded from the Ollama registry and stored in `~/.ollama/models/`
by default. These are GB-class files, so pull them on the **login node** before
submitting a job — do not pull inside a compute job.

```bash
# Start a temporary server on the login node
ollama serve &
OLLAMA_PID=$!

# Pull whichever models you need, e.g.:
ollama pull llama3.2:3b    # ~2 GB  — small, fast
ollama pull llama3.1:8b    # ~4.9 GB
ollama pull mistral:7b     # ~4.4 GB

# Stop the server when done
kill $OLLAMA_PID
```

List what you have pulled at any time:

```bash
ollama list
```

Browse all available models at [ollama.com/library](https://ollama.com/library).

---

## 4. Storing models outside your home directory

Home directory quotas on HPC clusters are often small. If that is the case,
point Ollama at a project or scratch directory instead:

```bash
export OLLAMA_MODELS="/path/to/large/storage/.ollama/models"
mkdir -p "$OLLAMA_MODELS"
```

Add this line to `~/.bashrc` **and** to every SLURM script that calls Ollama,
so the compute node also picks it up.

---

## 5. Running Ollama inside a SLURM job

Below is a minimal SLURM job script template.

```bash
#!/bin/bash
#SBATCH --job-name=ollama-job
#SBATCH --partition=<your-gpu-partition>   # check with: sinfo
#SBATCH --gres=gpu:1                       # request at least 1 GPU
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --output=ollama-%j.log

# ── Environment ──────────────────────────────────────────────────────────────
export OLLAMA_MODELS="${HOME}/.ollama/models"   # or your custom path
export OLLAMA_HOST="127.0.0.1:11434"

# ── Clean up any leftover Ollama from a previous job on this node ─────────────
pkill -u "$USER" -f "ollama" || true
sleep 5   # wait for the port to be released

# ── Start Ollama server ───────────────────────────────────────────────────────
~/bin/ollama/bin/ollama serve &
OLLAMA_PID=$!
sleep 15   # give Ollama time to load

# ── Your workload ─────────────────────────────────────────────────────────────
ollama run llama3.2:3b "Explain gradient descent in one paragraph."
# ... or call the REST API: curl http://127.0.0.1:11434/api/generate ...

# ── Cleanup ───────────────────────────────────────────────────────────────────
kill "$OLLAMA_PID" 2>/dev/null || true
```

> **Why `pkill` first?** SLURM may reuse a physical node across back-to-back
> jobs. A previous job's Ollama process can still be alive (or its port still
> in `TIME_WAIT`), causing `bind: address already in use` and silent 404 errors.

Submit the job:

```bash
sbatch my_ollama_job.sh
```

---

## 6. Checking GPU availability

Before submitting, inspect what partitions and GPUs your cluster offers:

```bash
sinfo -o "%P %G %N"        # list partitions with GPU types
scontrol show partition     # detailed partition info
nvidia-smi                  # from an interactive job to verify GPU access
```

Request an interactive GPU session for testing:

```bash
srun --partition=<gpu-partition> --gres=gpu:1 --mem=16G --pty bash
```

> **CUDA compatibility:** Ollama auto-detects the installed CUDA toolkit.
> If you see `CUDA error: no kernel image`, your GPU's compute capability
> (SM version) may not be supported by the CUDA version on the cluster.
> Check with `nvidia-smi` and compare against Ollama's release notes.

---

## 7. Troubleshooting

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| `bind: address already in use` | Leftover Ollama from a previous job | Add `pkill -u $USER -f ollama \|\| true; sleep 5` before `ollama serve` |
| 404 on `/api/generate` | Wrong model tag or model not pulled | Run `ollama list` on the login node to verify the exact tag |
| `Error: model not found` | `OLLAMA_MODELS` path differs between login and compute node | Set `OLLAMA_MODELS` explicitly in both `~/.bashrc` and the job script |
| Very slow inference (CPU) | GPU not used — CUDA libs missing or wrong path | Check `nvidia-smi` inside the job; ensure `~/bin/ollama/cuda_v12/` exists |
| Out-of-memory / OOM kill | Model too large for available VRAM | Use a smaller quantization (e.g. `:3b` instead of `:8b`), or request more GPUs with `--gres=gpu:2` |
| `CUDA error: no kernel image` | GPU SM version not supported by installed CUDA | Switch to a partition with a supported GPU, or use a CPU-only run as a fallback |
