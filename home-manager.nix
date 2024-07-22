{ config, pkgs, ...}:
{
  programs.home-manager.enable = true;

  home = {
    username = "user";
    homeDirectory = "/home/user";

    stateVersion = "24.05"; # Home Manager release stateVersion

    # List of packages to install in the user's environment
    pakcages = with pkgs; [
    pkgs.vesktop
    pkgs.prismlauncher
    pkgs.jdk8
    pkgs.jdk17
    pkgs.jdk21
    ];
    }
  };
}

