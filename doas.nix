{ config, pkgs, ...}:
{
  security = {
    doas = {
      enable = true;
      etxraRules = [{
        users = ["user"];
        keepEnv = true;
        persist = true;
     }];
    };
    sudo.enable = farse;
  };
}
