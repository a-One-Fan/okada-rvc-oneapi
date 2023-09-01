This is a version of RVC with oneAPI support. This README is a work in progress.

So far, this has been tested on WSL2.

# Installation:

- Install the oneAPI base toolkit

https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit-download.html?operatingsystem=linux&distributions=aptpackagemanager

- Get conda

Go to https://repo.anaconda.com/archive/

Copy the link for the newest conda (e.g. the one called "Anaconda3-2023.07-2-Linux-x86_64.sh"), `wget` it, run it and install. Don't forget to `chmod` it if it refuses to run.

- Create a conda environment, install this repo's requirements

This repo requires torchaudio. Intel do not officially provide torchaudio wheels. You may get my compiled wheels from mega.nz, via megatools in the command line.
From inside this repo's folder,

```sh
conda create -n rvc python=3.10
conda activate rvc
sudo apt install libportaudio2 libasound-dev megatools
pip install astunparse numpy==1.25.2 pyyaml pytest psutil setuptools cffi typing_extensions future six requests hypothesis expecttest types-dataclasses dataclasses Pillow SoundFIle==0.12.1 kaldi-io==0.9.8 scipy==1.11.2
mkdir megatemp
cd ./megatemp
megadl https://mega.nz/file/ndIRTYzQ#tn8teb5dXZQ6GNJBfRxykI1zQ58f-xBu8wNi-usYYho
tar -xzvf ./wheels.tar.gz
python -m pip install torch-2.0.1a0+gite9ebda2-cp310-cp310-linux_x86_64.whl
python -m pip install --no-deps torchvision-0.15.2a0+fa99a53-cp310-cp310-linux_x86_64.whl
python -m pip install --no-deps torchaudio-2.0.2+31de77d-cp310-cp310-linux_x86_64.whl
intel_extension_for_pytorch-2.0.110+gite29c5fb-cp310-cp310-linux_x86_64.whl
cd ..
rm -rf ./megatemp
cd ./server
pip install -r requirements.txt
cd ..
```

If you do not wish to get my wheels, you can compile them yourself with Intel's convenient compile script: https://github.com/intel/intel-extension-for-pytorch/blob/xpu-master/scripts/compile_bundle.sh

This will take a while.

- Create an alias to source oneAPI environment scipts easily

```sh
echo 'alias oneapi="source /opt/intel/oneapi/mkl/latest/env/vars.sh; source /opt/intel/oneapi/compiler/latest/env/vars.sh"' >> ~/.bash_aliases
```

Before running, you will need to source these, with the convenient alias. In the future, a file will source them for you.

# Run?

From within this repository's directory,

```sh
conda activate rvc
oneapi
cd ./server
python3 MMVCServerSIO.py -p 18888 --https true \
    --content_vec_500 pretrain/checkpoint_best_legacy_500.pt  \
    --content_vec_500_onnx pretrain/content_vec_500.onnx \
    --content_vec_500_onnx_on true \
    --hubert_base pretrain/hubert_base.pt \
    --hubert_base_jp pretrain/rinna_hubert_base_jp.pt \
    --hubert_soft pretrain/hubert/hubert-soft-0d54a1f4.pt \
    --nsf_hifigan pretrain/nsf_hifigan/model \
    --crepe_onnx_full pretrain/crepe_onnx_full.onnx \
    --crepe_onnx_tiny pretrain/crepe_onnx_tiny.onnx \
    --rmvpe pretrain/rmvpe.pt \
    --model_dir model_dir \
    --samples samples.json
```

[Old README](/README_old.md)