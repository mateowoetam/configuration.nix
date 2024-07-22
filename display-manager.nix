{ config, pkgs, ...}:
{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}
