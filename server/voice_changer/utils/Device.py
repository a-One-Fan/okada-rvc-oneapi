from dataclasses import dataclass

import torch
import platform

has_cuda = False
has_ipex = False

try:
    import intel_extension_for_pytorch as ipex
    if torch.xpu.device_count() > 0:
        has_ipex = True
        print(f"IPEX loaded, {torch.xpu.device_count()} XPU devices present")

        # Intel do not report the full, correct VRAM amount. The actual amount varies - ~80% for WIndows/WSL, 95% for Linux?
        # The following magic code remedies that.
        import os
        os.environ.setdefault('NEOReadDebugKeys', '1')
        os.environ.setdefault('ClDeviceGlobalMemSizeAvailablePercent', '100')
except:
    print("No IPEX, or XPU devices found.")

try:
    if torch.cuda.device_count() > 0:
        print(f"{torch.cuda.device_count()} CUDA devices present")
        has_cuda = True
        if torch.version.hip:
            print("HIP is used. If this works without further porting for ROCm, then that's pretty nice.")
except:
    print("No CUDA (or ROCM?) devices found.")

@dataclass()
class DeviceInfo:
    tdevice: torch.device
    id: int
    name: str
    memory: int

# TODO: What is mps / include CPU in here?
# ! Cross-compatibility with both XPU and ROCm/CUDA might not work yet due to hardcoded indices instead of devices in other places
def get_devices():
    devices: list[DeviceInfo] = []
    
    if has_ipex:
        for i in range(torch.xpu.device_count()):
            dev = torch.device('xpu', i)
            name = torch.xpu.get_device_name(dev)
            memory = torch.xpu.get_device_properties(dev).total_memory
            devices.append({"id": i, "name": name, "memory": memory})

    if has_cuda:
        for i in range(torch.cuda.device_count()):
            dev = torch.device('cuda', i)
            name = torch.cuda.get_device_name(dev)
            memory = torch.cuda.get_device_properties(dev).total_memory
            devices.append({"id": i, "name": name, "memory": memory})

    return devices

def get_device_count():
    count = 0

    if has_ipex:
        count += torch.xpu.device_count()
    if has_cuda:
        count += torch.cuda.device_count()

    return count