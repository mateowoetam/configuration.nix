{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    flatpak
  ];

  # Enable Flatpak and add Flathub as a remote repository
  services.flatpak.enable = true;
  users.users.user = {
    extraGroups = [ "flatpak" ];
  };

  environment.etc."flatpak/remotes.d/flathub.conf".source = pkgs.writeText "flathub.conf" ''
    [remotes]
    [flathub]
    url=https://dl.flathub.org/repo/
    gpg-verify=true
    gpg-verify-summary=true
    gpg-keys=flathub.gpg
  '';
}
