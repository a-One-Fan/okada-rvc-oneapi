This is a version of RVC with oneAPI support.

So far, this has been tested on WSL2.

# Installation:

- Sudo some dependencies

`sudo apt install python3.10 libportaudio2 libasound-dev intel-oneapi-dpcpp-cpp-2024.0 intel-oneapi-mkl-devel=2024.0.0-49656`

- Run setup-oneapi.sh

`./setup-oneapi.sh`

Done?

<br><br>

Installing the OneAPI base toolkit should be optional now. If the setup doesn't work or RVC doesn't launch, try installing it. Link:

https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit-download.html?operatingsystem=linux&distributions=aptpackagemanager

# Run:

`./start-oneapi.sh`

[Old README](/README_old.md)