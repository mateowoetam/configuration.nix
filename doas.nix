{ config, pkgs, ... }:

{
  # Enable doas and disable sudo
  security.doas.enable = true;
  security.sudo.enable = false;

  # Configure doas
  security.doas.extraRules = [{
    users = [ "otto" ];  # Replace "otto" with your username
    keepEnv = true;
    persist = true;
  }];
}
