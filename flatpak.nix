{ config, pkgs, ... }:

{
  # Enable flatpak support
  services.flatpak.enable = true;

  # Add flatpak to system packages
  environment.systemPackages = with pkgs; [
    flatpak
  ];

  # Add Flathub repository
  environment.etc."flatpak/remotes.d/flathub.conf".source = pkgs.writeText "flathub.conf" ''
    [remote "flathub"]
    url=https://dl.flathub.org/repo/
    gpg-verify=true
    gpg-keys=flathub.gpg
  '';
}
