{ config, pkgs, ...}:
{
  imports = [
    ./hardware-configuration.nix
    ./superuser.nix
    ./boot-loader.nix
    ./networking.nix
    ./display-manager.nix
    ./time-locale.nix
    ./sound.nix
    ./flakes.nix
    ./users.nix
    ./printing.nix
    ./packages.nix
    ./flatpak.nix
    ./steam-hardware.nix
  ];

  # Set the state version for NixOS
  system.stateVersion = "24.05"; # Adjust this to math your NixOS version

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Auto system update
  system.autoUpgrade = {
        enable = true;
  };
}
