# Edit this configuraiton file to define what should be installed one
# your system. Help is available in the configuration.nix(5) man pag
# and in the NixOS manual (accessible by running 'nixos-help').
{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  imports = [
    # include the results of the hardware scan.
    ./hardware-configuration.nix
    #./keyboard.nix #unnecessary with my new way to install layout in .config
    ./chaotic.nix
    ./sddm.nix
    ./cachix.nix
  ];
  # Bootloader
  boot = {
    loader = {
      systemd-boot = {
        enable = lib.mkForce false; # true without secureboot
        editor = true; # Allow editing kernel parameters at boot time
        configurationLimit = 10; # Show up to 10 generations
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot"; # Ensure this points to your EFI partition
      };
      grub.enable = false;
    };
    kernelParams = [
      "amdgpu.dc=1"
      "acpi_osi=Linux"
    ];
    kernelModules = [ "kvm-amd" ];
    lanzaboote = {
      enable = true;
      enrollKeys = false; # true # Only true first time
      pkiBundle = "/var/lib/sbctl";
    };
    #    initrd.luks.devices {
    #      cryptroot = {
    #        device = "/dev/disk/by-partuuid/uuid-goes-here";  # Use PARTUUID for LUKS
    #        allowDiscards = true;  # Used if primary device is a SSD
    #        preLVM = true;
    #      };
    #    };

  };
  # TPM2
  security = {
    tpm2.enable = true;
    # superuser
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "user" ]; # Replace "otto" with your username
          keepEnv = true;
          persist = true;
        }
      ];
    };
    sudo.enable = false;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
    modemmanager.enable = false;
    wireguard.enable = true;
  };

  # Hardware Configuration #Steam #Controller #OpenGL #fwupd #Bluetooth
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
    steam-hardware.enable = true;
    cpu.amd.updateMicrocode = true;
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  services = {
    blueman.enable = true;
    xserver.enable = false;
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings = {
      };
    };
    printing.enable = true;
    pipewire = {
      audio.enable = true;
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    libinput.enable = true; # touchpad
    mullvad-vpn.enable = true; # Mullvad
    flatpak = {
      enable = true;
    };
    fwupd.enable = true;
    spice-vdagentd.enable = true;
  };

  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.user = {
    isNormalUser = true;
    description = "User";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "cpugovctl"
      "sysctlgroup"
      "libvirtd"
      "kvm"
      "input"
      "plugdev"
      "tss"
    ];
  };
  # Set your time zone.
  time.timeZone = "America/Mexico_City"; # Europe/Berlin # America/Mexico_City
  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages = true;
  nixpkgs.config.allowUnfree = true;
  # Auto system update
  system.autoUpgrade.enable = false;
  # List packages installed in system profile. To search, run;
  # $ nix search wget
  environment = {
    etc."flatpak/remotes.d/flathub.conf".source = pkgs.writeText "flathub.conf" ''
    [remote "flathub"]
    url=https://dl.flathub.org/repo/
    gpg-verify=true
    gpg-keys=flathub.gpg

    '';
    systemPackages = with pkgs; [
      # Secureboot
      pkgs.sbctl

      # LUKS
      tpm2-tools
      tpm2-tss

      # Fish shell stuff
      pkgs.fish
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.grc
      fishPlugins.hydro
      fzf
      grc

      # General utilities
      pkgs.fastfetch
      pkgs.flatpak
      pkgs.git
      pkgs.libjxl
      pkgs.librewolf
      kdePackages.plasma-browser-integration
      pkgs.wget
      pkgs.tpm-tools
      pkgs.tpm2-tools
      pkgs.tpm2-tss
      pkgs.wayland
      pkgs.glfw-wayland-minecraft
      pkgs.rar
      pkgs.unrar-free
      pkgs.bat
      pkgs.tldr
      (pkgs.uutils-coreutils.override { prefix = ""; })
      kdePackages.wallpaper-engine-plugin
      pkgs.nixfmt-rfc-style
      pkgs.statix
      pkgs.cachix

      # ROCm stuff
      rocmPackages.rocm-core
      rocmPackages.rocm-device-libs
      rocmPackages.rocm-runtime
      rocmPackages.rocm-smi
      rocmPackages.rocminfo
      rocmPackages.clr

      # Zluda or Cuda on AMD
      pkgs.zluda

      # Virtualization stuff
      pkgs.spice-gtk
      pkgs.gst_all_1.gstreamer
      pkgs.gst_all_1.gst-plugins-base
      pkgs.gst_all_1.gst-plugins-good
      pkgs.gst_all_1.gst-plugins-bad

      # Drivers
      pkgs.dxvk
      pkgs.vkd3d-proton
    ];
  };

  programs = {
    xwayland.enable = true;
    firefox.enable = false;
    adb.enable = true;
    gamemode.enable = true;
    nano = {
      enable = true;
      nanorc = "
        #set mouse
        set autoindent
        set linenumbers
      ";
      syntaxHighlight = true;
    };
    virt-manager = {
      enable = true;
      package = pkgs.virt-manager.overrideAttrs (oldAttrs: {
        nativeBuildInputs = oldAttrs.nativeBuildInputs or [ ] ++ [ pkgs.wrapGAppsHook ];
        buildInputs = pkgs.lib.lists.subtractLists [ pkgs.wrapGAppsHook ] oldAttrs.buildInputs ++ [
          pkgs.gst_all_1.gst-plugins-base
          pkgs.gst_all_1.gst-plugins-good
        ];
      });
    };
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      atkinson-hyperlegible
      geist-font
    ];
  };

  # Virtualization software
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = [ pkgs.virtiofsd ];
        ovmf.enable = true;
        swtpm.enable = true;
        runAsRoot = true;
      };
    };
  };

  # flakes configuraiton
  nix.settings = {
    allowed-users = [ "*" ];
    auto-optimise-store = true;
    max-jobs = "auto";
    require-sigs = true;
    sandbox = true;
    sandbox-fallback = false;
    substituters = [
      "https://nix-community.cachix.org/"
      "https://chaotic-nyx.cachix.org/"
      "https://cache.nixos.org/"
    ];
    trusted-users = [
      "root"
      "user"
    ];
    extra-sandbox-paths = [ ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # This value detemines the NixOS release from which the defalt
  # settings for stateful data, like file locaitons and database versions
  #on your system were take. It's perfectly fine and recomended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
