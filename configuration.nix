# Edit this configuraiton file to define what should be installed one
# your system. Help is available in the configuration.nix(5) man pag
# and in the NixOS manual (accessible by running 'nixos-help').
{ config, pkgs, lib, ...}:

with lib;

{
  imports =
    [ # include the results of the hardware scan.
      ./hardware-configuration.nix
      #./keyboard.nix #unnecessary with my new way to install layout in .config
      ./chaotic.nix
      ./sddm.nix
    ];
  # Bootloader
  boot.loader.systemd-boot.enable = lib.mkForce false; #true without secureboot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  boot.loader.efi.efiSysMountPoint = "/boot";  # Ensure this points to your EFI partition
  # Optional: Control the number of generations shown in the boot menu
  boot.loader.systemd-boot.editor = true;  # Allow editing kernel parameters at boot time
  boot.loader.systemd-boot.configurationLimit = 10;  # Show up to 10 generations
  boot.kernelParams = [ 
     "amdgpu.dc=1" 
     "acpi_osi=Linux"
  ];
  boot.lanzaboote = {
      enable = true;
      enrollKeys = true;
      pkiBundle = "/var/lib/sbctl";
  };
  #boot.initrd.luks.devices = {
    #cryptroot = {
      #device = "/dev/disk/by-partuuid/uuid-goes-here";  # Use PARTUUID for LUKS
      #allowDiscards = true;  # Used if primary device is a SSD
      #preLVM = true;
    #};
  #};

  # TPM2
  security.tpm2.enable = true;

  
  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.modemmanager.enable = false;
  #services.nscd.enable = false; # for chache of name service requests
  
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;
  # Bluetooth Codecs
  # Set your time zone.
  time.timeZone = "America/Mexico_City"; # Europe/Berlin # America/Mexico_City
  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  # Enable the X11 windowing system
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = false;
    #xkb.layout = "us";
    #xkb.variant = "";
  };
  programs.xwayland.enable = true;

  # Wireguard
  networking.wireguard = { 
    enable = true;
  };  
  #Mullvad
  services.mullvad-vpn.enable = true;

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    #theme = "breeze";
    settings = {
       };
  };
  

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sound with pipewire
  services.pipewire = {
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

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.user = {
     isNormalUser = true;
     description = "User";
     extraGroups = [ "networkmanager" "wheel" "gamemode" "cpugovctl" "sysctlgroup" "libvirtd" "kvm" "input" "plugdev" "tss"];
   };
  # Configure privilege escalation utilities
  # Enable doas and disable sudo
  security.doas.enable = true;
  security.sudo.enable = false;

  # Configure doas
  security.doas.extraRules = [{
    users = [ "user" ];  # Replace "otto" with your username
    keepEnv = true;
    persist = true;
  }];
  # Allow unfree packages = true;
  nixpkgs.config.allowUnfree = true;
  # Auto system update
  system.autoUpgrade.enable = false;
  # Deconfigure Firefox
  programs.firefox.enable = false;
  # ADB
  programs.adb.enable = true;
  # List packages installed in system profile. To search, run;
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    (pkgs.uutils-coreutils.override {prefix ="";})
    kdePackages.wallpaper-engine-plugin
    #kdePackages.krohnkite # tiling extension for KWin

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

  # Enable flatpak support
  services.flatpak.enable = true;
  # Add Flathub repository
  environment.etc."flatpak/remotes.d/flathub.conf".source = pkgs.writeText "flathub.conf" ''
    [remote "flathub"]
    url=https://dl.flathub.org/repo/
    gpg-verify=true
    gpg-keys=flathub.gpg
  '';
  # Hardware Configuration #Steam #Controller #OpenGL #fwupd
  #hardware.xone.enable = true;
  #hardware.xpadneo.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
  hardware.cpu.amd.updateMicrocode = true;
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;
  services.fwupd.enable = true;

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      atkinson-hyperlegible
      geist-font
    ];
  };

  # Nano text editor
  programs.nano = {
     enable = true;
     nanorc = "
        #set mouse
        set autoindent
        set linenumbers
     ";
     syntaxHighlight = true;
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
  programs.virt-manager = {
  enable = true;
  package = pkgs.virt-manager.overrideAttrs (oldAttrs: { nativeBuildInputs = oldAttrs.nativeBuildInputs or [] ++ [ pkgs.wrapGAppsHook ]; buildInputs = pkgs.lib.lists.subtractLists [ pkgs.wrapGAppsHook ] oldAttrs.buildInputs ++ [ pkgs.gst_all_1.gst-plugins-base pkgs.gst_all_1.gst-plugins-good ]; });
  };
  boot.kernelModules = [ "kvm-amd" ];
  services.spice-vdagentd.enable = true;
  
  programs.appimage.enable = true;
  programs.appimage.binfmt = true; 
  
  # flakes configuraiton
  nix.settings = {
   allowed-users = ["*"];
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
   trusted-users = [ "root" "user" ];
   extra-sandbox-paths = [];
   experimental-features = [ "nix-command" "flakes" ];
  };

  # This value detemines the NixOS release from which the defalt
  # settings for stateful data, like file locaitons and database versions
  #on your system were take. It's perfectly fine and recomended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
