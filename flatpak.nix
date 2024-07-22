{ config, pkgs, ...}:
{
  # Enable flatpak support
  services.flatpak.enable = true;

  # Add flatpak repositories (optional)
  environment.systemPackages = with pkgs; [
    flatpak
  ];

  # Add Flathub repositories (optional)
  nixpkgs.config.packagesOverrides = pkgs: {
    flatpak = pkgs.flatpak.overrideAttrs (oldAttrs; rec {
      postInstall = ''
        ${oldAttrs.postInstall or ""}
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
      });
    };
}
