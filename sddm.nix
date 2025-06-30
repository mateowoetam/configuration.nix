{ config, pkgs, lib, ... }:

let
  # Define the custom background package with the correct relative path
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "custom-wallpaper";
    src = ./sddm.png;  # Use the relative path to the wallpaper
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out
      cp $src $out/background.png  # Copy the wallpaper to the output directory
    '';
  };

in {
  # KDE Plasma configuration
  services.displayManager.sddm = {
    enable = lib.mkDefault true;
    theme = "breeze";  # Use the Breeze theme
    wayland.enable = true;  # Enable Wayland if needed
  };

  # Create a custom SDDM theme configuration
  environment.systemPackages = with pkgs; [
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background = "${background-package}/background.png"  # Reference the wallpaper
    '')
  ];
}
