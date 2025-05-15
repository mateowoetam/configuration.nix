{ config, pkgs, ...}:
{
    environment.systemPackages = [
    pkgs.mangohud32_git
    pkgs.mangohud_git
    pkgs.mesa32_git
    pkgs.gamescope_git
    ];

    boot.kernelPackages = pkgs.linuxPackages_cachyos;
    #chaotic.scx.enable = true;

    #chaotic.hdr.enable = true;
}

