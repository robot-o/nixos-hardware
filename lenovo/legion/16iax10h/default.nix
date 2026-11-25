{
  lib,
  config,
  ...
}:
{
  imports = [
    ../../../common/cpu/intel
    ../../../common/gpu/nvidia/prime.nix
    ../../../common/gpu/nvidia/blackwell
    ../../../common/pc/laptop
    ../../../common/pc/ssd
    ../../../common/hidpi.nix
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];

  hardware = {
    nvidia = {
      powerManagement.enable = lib.mkDefault true;
      #
      prime = {
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:02:00:0";
      };
    };
  };


  # Cooling management
  services.thermald.enable = lib.mkDefault true;

  # √(2560² + 1600²) px / 16 in ≃ 189 dpi
  services.xserver.dpi = 189;
}
