{ config, pkgs, ...}:
{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };
  services.displayManager.sddm.enable = true;
  services.destkopManager.plasma6.enable = true;
}
