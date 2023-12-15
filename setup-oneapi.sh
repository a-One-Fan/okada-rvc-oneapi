python3.10 -m venv rvcvenv
source ./rvcvenv/bin/activate
pip install --upgrade pip
pip install astunparse numpy==1.25.2 pyyaml pytest psutil setuptools cffi typing_extensions future six requests hypothesis expecttest types-dataclasses dataclasses Pillow SoundFIle==0.12.1 kaldi-io==0.9.8 scipy==1.11.2
python -m pip install torch==2.1.0a0 torchvision==0.16.0a0 torchaudio==2.1.0a0 intel-extension-for-pytorch==2.1.10+xpu --extra-index-url https://pytorch-extension.intel.com/release-whl/stable/xpu/us/
cd ./server
pip install -r requirements.txt
cd ..