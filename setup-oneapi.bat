@echo off
call %UserProfile%\miniconda3\Scripts\activate.bat
if not %errorlevel%==0 ^
    call %UserProfile%\anaconda3\Scripts\activate.bat
if not %errorlevel%==0 ^
    echo Conda was not found installed in your user folder. Install miniconda? & ^
    choice & ^
    if %errorlevel%==2 exit & ^
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe -o miniconda.exe & ^
    start /wait "" miniconda.exe /S & ^
    del miniconda.exe & ^
    call %UserProfile%\miniconda3\Scripts\activate.bat
call conda create -p ./conda_rvcenv python=3.10 -y
call conda activate ./conda_rvcenv
call conda install pkg-config libuv -y
call pip install astunparse numpy==1.25.2 pyyaml pytest psutil setuptools cffi typing_extensions future six requests hypothesis expecttest types-dataclasses dataclasses Pillow SoundFIle==0.12.1 kaldi-io==0.9.8 scipy==1.11.2
call pip install torch==2.1.0.post2 torchvision==0.16.0.post2 torchaudio==2.1.0.post2 intel-extension-for-pytorch==2.1.30.post0 --extra-index-url https://pytorch-extension.intel.com/release-whl/stable/xpu/us/
call pip install dpcpp-cpp-rt==2024.2.0 mkl-dpcpp==2024.2.0 onednn==2024.2.0
call cd ./server
call pip install -r requirements.txt
call cd ..
call conda deactivate
call conda deactivate