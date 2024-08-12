{ config, pkgs, ...}:

{

stylix = {
  enable = true;
  base16SCheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
};

}
