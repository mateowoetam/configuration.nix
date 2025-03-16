{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
     "electron-27.3.11"
  ];

  nix.package = pkgs.nix;

  home.packages = [
    # Utilities
    pkgs.alacritty
    pkgs.filelight
    pkgs.fwupd
    pkgs.gnome-disk-utility
    pkgs.kcalc
    pkgs.kcharselect
    pkgs.localsend
    pkgs.metadata-cleaner
    pkgs.keepassxc
    pkgs.scrcpy
    pkgs.thonny
    pkgs.libsForQt5.kdeGear.keysmith
    pkgs.gh
    #pkgs.virtualbox
    #pkgs.vscodium

    # Browsers
    pkgs.libreoffice-qt6-fresh
    pkgs.mullvad-browser
    pkgs.ungoogled-chromium
    #pkgs.ladybird

    # Media
    pkgs.vlc
    #pkgs.libsForQt5.kamoso
    pkgs.guvcview
    pkgs.kdenlive
    pkgs.mediawriter
    #pkgs.gnome-sound-recorder
    pkgs.deluge
    pkgs.libsForQt5.ktorrent
    # OBS stuff
    pkgs.obs-studio
    pkgs.obs-studio-plugins.obs-vkcapture
    #pkgs.obs-studio-plugins.wlrobs-untsable
    pkgs.obs-studio-plugins.obs-vaapi
    pkgs.obs-studio-plugins.obs-backgroundremoval

    # Social
    pkgs.vesktop
    pkgs.goofcord
    #pkgs.legcord

    # Gaming
    #pkgs.bottles
    pkgs.gamemode
    pkgs.goverlay
    #pkgs.mangojuice
    #pkgs.protonplus
    pkgs.steam
    pkgs.wineWowPackages.stable

    # Minecraft
    (pkgs.prismlauncher.override { jdks = [pkgs.temurin-bin-21 pkgs.temurin-bin-8 pkgs.temurin-bin-17 ]; })

    # Productivity
    #pkgs.apostrophe
    #pkgs.folio
    pkgs.logseq
    pkgs.authenticator
    pkgs.bitwarden-desktop

    # Conferencing
    pkgs.zoom-us
    pkgs.teams-for-linux

    # Development
    pkgs.directx-headers

    #LLMs
    pkgs.kdePackages.alpaka


  ];
  # Declarative Flatpak apps
  #imports = [ ./flake.nix inputs.nix-flatpak ];
  #services.flatpak = {
    #remotes = [{
      #name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    #}];
    #packages = [
      #{ appId = "net.mullvad.MullvadBrowser"; origin = "flathub";}
      #{ appId = "io.github.ungoogled_software.ungoogled_chromium"; origin = "flathub";}
    #];
  #};

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  #gtk = {
  #  enable = true;
  #  theme = {
  #  name = "Breeze-Dark";
  #  package = pkgs.libsForQt5.breeze-gtk;
  #  };
  #};

        
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.cleanOnShutdown.history" = false;
      "privacy.cleanOnShutdown.downloads" = false;
      "security.OCSP.require" = false;
      #"media.eme.enabled" = true;
      #"general.useragent.override" = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36";
    };
    package = pkgs.librewolf-wayland.override {
      nativeMessagingHosts = with pkgs; [ plasma-browser-integration ];
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      fetch = "clear && fastfetch";
      ".." = "cd ..";
      garbage = "nix-collect-garbage -d";
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
  
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "linux";
        padding = {
          right = 1;
        };
      };
      display = {
        separator = ": ";
      };
      modules = [
        {
          type = "custom";
          format = "┌──────────── Software Information ────────────┐";
        }
        {
          type = "os";
          key = "OS";
          keyColor = "blue";
          format = "{3}";
        }
        {
          type = "kernel";
          key = "kernel";
          keyColor = "blue";
        }
        {
          type = "uptime";
          key = "Uptime";
          keyColor = "blue";
        }
        {
          type = "packages";
          key = "Pkgs";
          keyColor = "blue";
          #format = "{10} (nix-user), {15} (flatpak-user)";
        }
        {
          type = "de";
          key = "DE";
          keyColor = "blue";
          #format = "{2} {3}";
        }
        {
          type = "shell";
          key = "Shell";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "Term";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "├──────────── Hardware Information ────────────┤";
        }
        {
          type = "host";
          key = "Host";
          keyColor = "blue";
          format = "{2}";
        }
        {
          type = "display";
          key = "Res";
          keyColor = "blue";
        }
        {
          type = "cpu";
          key = "CPU";
          keyColor = "blue";
        }
        {
          type = "gpu";
          key = "GPU";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "RAM";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────────┘";
        }
      ];
    };
  };

  programs.alacritty = {
      enable = true;
      settings = {
        general.live_config_reload = true;
        window = {
          opacity = 0.9;
          dimensions = {
            lines = 22;
            columns = 84;
          };
        };
       terminal. shell = {
          program = "${pkgs.fish}/bin/fish";
          args = [ "-c" "fastfetch; exec fish" ];
        };
        font = {
          size = 10;
          bold = {
            family = "Geist Mono";
            style = "Regular";
          };
          bold_italic = {
            family = "Liberation Mono";
            style = "Heavy Italic";
          };
          italic = {
            family = "Liberation Mono";
            style = "Medium Italic";
          };
          normal = {
            family = "Geist Mono";
            style = "Medium";
          };
        };
        scrolling = {
          history = 10000;
          multiplier = 4;
        };
        colors = {
          primary = {
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            dim_foreground = "#7f849c";
            bright_foreground = "#cdd6f4";
          };
          cursor = {
            text = "#1e1e2e";
            cursor = "#f5e0dc";
          };
          vi_mode_cursor = {
            text = "#1e1e2e";
            cursor = "#b4befe";
          };
          search = {
            matches = {
              foreground = "#1e1e2e";
              background = "#a6adc8";
            };
            focused_match = {
              foreground = "#1e1e2e";
              background = "#a6e3a1";
            };
          };
          footer_bar = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
          hints = {
            start = {
              foreground = "#1e1e2e";
              background = "#f9e2af";
            };
            end = {
              foreground = "#1e1e2e";
              background = "#a6adc8";
            };
          };
          selection = {
            text = "#1e1e2e";
            background = "#f5e0dc";
          };
          normal = {
            black = "#45475a";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#89b4fa";
            magenta = "#f5c2e7";
            cyan = "#94e2d5";
            white = "#bac2de";
          };
          bright = {
            black = "#585b70";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#89b4fa";
            magenta = "#f5c2e7";
            cyan = "#94e2d5";
            white = "#a6adc8";
          };
          dim = {
            black = "#45475a";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#89b4fa";
            magenta = "#f5c2e7";
            cyan = "#94e2d5";
            white = "#bac2de";
          };
          indexed_colors = [
              {
                index = 16;
                color = "#fab387";
              }
              {
                index = 17;
                color = "#f5e0dc";
              }
            ];
          };
      cursor = {
        style = {
          shape = "beam";
          blinking = "on";
        };
      };
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

}
