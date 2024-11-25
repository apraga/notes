# llama-cpp

## Localement

```bash
nix profile install nixpkg#llama
wget https://huggingface.co/TheBloke/Llama-2-7B-GGUF/resolve/main/llama-2-7b.Q2_K.gguf?download=true
llama-cli -m llama-2-7b.Q2_K.gguf -p "Building a website can be done in 10 simple steps:\nStep 1:" -n 400 -e
```

## Cluster CHUGA

Suivre https://github.com/kaust-generative-ai/local-deployment-llama-cpp
On active CUDA
```bash
./bin/install-miniforge.sh
``` 

Pour être sûr d'avoir CUDA détecté, on se met sur le noeud GPU en interactif 
```bash
srun --nodes=1 --ntasks-per-node=1 --time=03:00:00 --gres=gpu --partition servoz --pty bash -i
./bin/create-conda-env.sh
./bin/create-conda-env.sh environment-nvidia-gpu.yml
conda activate /data/home/apraga/local-deployment-llama-cpp/env
```
Pour compiler depuis le code source, ./bin/build-llama-cpp-nvidia-gpu.sh ne semble pas fonctionner pas donc à la main. 
```bash
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp
cmake -B build  -DCMAKE_INSTALL_PREFIX=env -DCMAKE_INSTALL_RPATH=env/lib -DLLAMA_CURL=ON -DGGML_LLAMAFILE=OFF   -DGGML_CUDA=ON   -DGGML_BLAS=ON    -DGGML_BLAS_VENDOR=OpenBLAS
```
On quitte le noeud de calcul en interactif et on compile avec `compile.sh`
```

#!/bin/bash

#SBATCH --job-name=compile-llamacpp
#SBATCH --output=compile-llamacpp
#SBATCH --time=4:00:00                          ## Job Duration
#SBATCH --ntasks-per-node=12                            ## Number of tasks (analyses) to run
#SBATCH --nodes=1
#SBATCH --partition=servoz
#SBATCH --gres=gpu

. /data/home/apraga/.bashrc
conda activate /data/home/apraga/local-deployment-llama-cpp/env
cmake --build build/ --config Release -j 12 --parallel
```
Et lancer 
```bash
sbatch compile.sh
```

Mettre https://huggingface.co/TheBloke/Llama-2-7B-GGUF/blob/main/llama-2-7b.Q2_K.gguf sur le cluster avec sshfs

srun --nodes=1 --ntasks-per-node=1 --time=03:00:00 --gres=gpu --partition servoz --pty bash -i
(base) [apraga@HPC-CHU-Node011 ~]$ cd local-deployment-llama-cpp/
(base) [apraga@HPC-CHU-Node011 local-deployment-llama-cpp]$ conda activate ./env
(/data/home/apraga/local-deployment-llama-cpp/env) [apraga@HPC-CHU-Node011 local-deployment-llama-cpp]$ llama-cli
llama-cli -m ../llama-2-7b.Q2_K.gguf -p "Building a website can be done in 10 simple steps:nStep 1:" -n 400 -e

Problème de driver CUDA 

Mais la version semble la bonne (10.2)


Wed Oct 30 15:29:48 2024
nvidia-smi NVIDIA-SMI 4409501    Driver Version: 4409501    CUDA Version: 102     |

# Ancienne version 


Pas moyen de télécharger depuis le cluster...

On ne suit pas les instructions du README mais yhttps://github.com/meta-llama/llama-recipes/blob/main/recipes/quickstart/Running_Llama3_Anywhere/Running_Llama_on_Mac_Windows_Linux.ipynb
1. on installe tout localement + téléchargement
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama3.1:70b

Sur le cluster, pas de téléchargement possible...

curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz
scp ollama-linux-amd64.tgz chu:
ssh chu
mkdir ollama
tar -xvf ollama-linux-amd64.tgz -C ollama
/ollama/bin/ollama serve

Dans un autre terminal
/ollama/bin/ollama -v
ollama version is 0.3.13
