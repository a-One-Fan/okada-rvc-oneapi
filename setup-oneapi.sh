if [[ ! -e /opt/intel/oneapi/setvars.sh ]]; then
    echo "Please install the oneAPI base toolkit. "
    echo "https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit-download.html?operatingsystem=linux&distributions=aptpackagemanager"
    exit 1
fi

echo "This script will install, if not already installed, Python 3.10, libportaudio2, libasound-dev and megatools."
read -p "Continue? Y/n:" yn
if [[ $yn == [nN] ]]; then
    exit 0
fi

python3.10 --version
if [[ $? != 0 ]]; then
    sudo apt install python3.10
fi

sudo apt install libportaudio2 libasound-dev megatools

python3.10 -m venv rvcvenv
source ./rvcvenv/bin/activate
pip install astunparse numpy==1.25.2 pyyaml pytest psutil setuptools cffi typing_extensions future six requests hypothesis expecttest types-dataclasses dataclasses Pillow SoundFIle==0.12.1 kaldi-io==0.9.8 scipy==1.11.2
mkdir megatemp
cd ./megatemp
megadl https://mega.nz/file/ndIRTYzQ#tn8teb5dXZQ6GNJBfRxykI1zQ58f-xBu8wNi-usYYho
tar -xzvf ./wheels.tar.gz
python -m pip install torch-2.0.1a0+gite9ebda2-cp310-cp310-linux_x86_64.whl
python -m pip install --no-deps torchvision-0.15.2a0+fa99a53-cp310-cp310-linux_x86_64.whl
python -m pip install --no-deps torchaudio-2.0.2+31de77d-cp310-cp310-linux_x86_64.whl
python -m pip install intel_extension_for_pytorch-2.0.110+gite29c5fb-cp310-cp310-linux_x86_64.whl
cd ..
rm -rf ./megatemp
cd ./server
pip install -r requirements.txt
cd ..