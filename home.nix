{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "25.11"; # Please read the comment before changing.
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [
        #"electron-27.3.11" # I think teams or goofcord idk
        "olm-3.2.16" # for neochat
      ];
    };
  };
  nix.package = pkgs.nix;
  home = {
    packages = with pkgs; [
      # Utilities
      alacritty
      kdePackages.filelight
      fwupd
      gnome-disk-utility
      kdePackages.kcalc
      kdePackages.kcharselect
      gh
      protonvpn-gui
      mullvad-vpn
      wl-clipboard

      # Development
      gcc
      cargo
      rustc
      cmake
      ninja
      pkg-config
      jdk24
      maven
      android-studio

      # Browsers
      mullvad-browser
      ungoogled-chromium
      ladybird

      # Media
      vlc
      guvcview
      kdePackages.kdenlive
      kdePackages.krecorder
      snapshot
      deluge
      #kdePackages.ktorrent
      #blender
      gimp3-with-plugins

      # Writing
      libreoffice-qt-fresh
      kdePackages.ghostwriter
      mediawriter
      tt

      # OBS stuff
      obs-studio
      obs-studio-plugins.obs-vkcapture
      #obs-studio-plugins.wlrobs-untsable
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-backgroundremoval

      # Social
      goofcord
      kdePackages.neochat
      element-desktop

      # Gaming
      #(bottles.override { removeWarningPopup = true;})
      gamemode
      goverlay
      protonplus
      steam
      wineWowPackages.stable
      mcrcon
      #suyu
      ryubing
      luanti

      # Minecraft
      (prismlauncher.override {
        jdks = [
          temurin-bin-21
          temurin-bin-8
          temurin-bin-17
          glfw-wayland-minecraft
          gcc13
        ];
      })
      mcpelauncher-ui-qt

      # Productivity
      authenticator
      kdePackages.keysmith
      bitwarden-desktop

      # Conferencing
      #zoom-us
      #teams-for-linux

      # Development
      directx-headers

      #LLMs
      kdePackages.alpaka
      ollama-rocm

    ];
    file = {
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
    sessionVariables = {
      # These will be explicitly sourced when using a
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  #gtk = {
  #  enable = true;
  #  theme = {
  #  name = "Breeze-Dark";
  #  package = pkgs.kdePackages.breeze-gtk;
  #  };
  #};

  programs = {
    librewolf = {
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
        nativeMessagingHosts = with pkgs; [ kdePackages.plasma-browser-integration ];
      };
    };
    bat = {
      enable = true;
      themes = {
        catppuccin-mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "main";
            hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
            sparseCheckout = [
              "themes/Catppuccin Mocha.tmTheme"
            ];
          };
        };
      };
      config = {
        theme = "Catppuccin Mocha";
        style = "plain";
      };
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    fish = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        fetch = "clear && fastfetch";
        ".." = "cd ..";
        nfu = "cd /etc/nixos/ || exit && nix flake update";
        nrs = "cd /etc/nixos/ || exit && doas nixos-rebuild switch --flake .";
        nso = "cd /etc/nixos/ || exit && nix store optimise";
        ncg = "cd /etc/nixos/ || exit && doas nix-collect-garbage --delete-older-than 3d";
        hms = "cd /etc/nixos/ || exit && home-manager switch --flake .";
        unx = "cd /etc/nixos/ || exit && nix flake update && doas nixos-rebuild switch --flake . && home-manager switch --flake . && nix store optimise && doas nix-collect-garbage --delete-older-than 3d";
        ttm = "tt -quotes en -theme catppuccin-mocha";
        cat = "bat";
        cd = "z";
      };
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };
    fastfetch = {
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
          }
          {
            type = "de";
            key = "DE";
            keyColor = "blue";
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
    alacritty = {
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
        terminal.shell = {
          program = "${pkgs.fish}/bin/fish";
          args = [
            "-c"
            "fastfetch; exec fish"
          ];
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
    home-manager = {
      enable = true;
    };
  };

}
