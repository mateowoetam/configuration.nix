{ config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
      rocmPackages.rocm-core
      rocmPackages.rocm-runtime
      rocmPackages.rocmm-device-libs
      rocmPackages.clr
      rocmPackages.rocm-smi
      rocmPackages.rocminfo
    ];
}
