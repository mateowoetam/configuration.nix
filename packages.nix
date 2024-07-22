{ config, pkgs, ...}:
{
  environment.systemPakcages = with pkgs; [
    pkgs.librewolf
    pkgs.fastfetch
    pkgs.fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
    pkgs.git
    pkgs.wget
    # vim # Uncomment if needed
  ];
}
