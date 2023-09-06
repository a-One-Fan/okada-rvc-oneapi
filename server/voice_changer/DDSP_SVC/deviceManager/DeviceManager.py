import torch

from voice_changer.utils.Device import get_a_device, get_per_api_device_count, get_per_api_device_properties, get_per_api_device_name

class DeviceManager(object):
    _instance = None

    @classmethod
    def get_instance(cls):
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def __init__(self):
        self.gpu_num = get_per_api_device_count()
        self.mps_enabled: bool = (
            getattr(torch.backends, "mps", None) is not None
            and torch.backends.mps.is_available()
        )

    def getDevice(self, id: int):
        if id < 0 or self.gpu_num == 0:
            if self.mps_enabled is False:
                dev = torch.device("cpu")
            else:
                dev = torch.device("mps")
        else:
            dev = torch.device(get_a_device(), index=id)
        return dev

    def halfPrecisionAvailable(self, id: int):
        if self.gpu_num == 0:
            return False
        if id < 0:
            return False

        try:
            gpuName = get_per_api_device_name(id).upper()
            if (
                ("16" in gpuName and "V100" not in gpuName)
                or "P40" in gpuName.upper()
                or "1070" in gpuName
                or "1080" in gpuName
            ):
                return False
        except Exception as e:
            print(e)
            return False

        return True

    def getDeviceMemory(self, id: int):
        try:
            return get_per_api_device_properties(id).total_memory
            # except Exception as e:
        except:  # NOQA
            # print(e)
            return 0
