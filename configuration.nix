# Edit this configuraiton file to define what should be installed one
# your system. Help is available in the configuration.nix(5) man pag
# and in the NixOS manual (accessible by running 'nixos-help').
{ config, pkgs, ...}:

{
  imports =
    [ # include the results of the hardware scan.
      ./hardware-configuration.nix
      ./keyboard.nix
      ./chaotic.nix
    ];
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  boot.loader.efi.efiSysMountPoint = "/boot";  # Ensure this points to your EFI partition
  # Optional: Control the number of generations shown in the boot menu
  boot.loader.systemd-boot.editor = true;  # Allow editing kernel parameters at boot time
  boot.loader.systemd-boot.configurationLimit = 10;  # Show up to 10 generations
  boot.kernelParams = [ ''amdgpu.dc=1'' ''acpi_osi=Linux'' ];

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  # Uncomment and configure if using a proxy
  # proxy.default = "https://user:password@proxy:port/";
  # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Uncoment for Mullvad DNS
  # nameservers = [ "194.242.2.2#base,dns.mullvad.net" "194.242.2.3#adblock.dns.mullvad.net"];
  # services.resolved = {
  #   enable = true;
  #   dnssec = "true;
  #   domanis = [ "~." ];
  #   fallbackDns = [ "194.242.2.3#adblock.dns.mullvad.net" ];
  #   dnsovertls = "true";
  # };
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
  # Bluetooth Codeecs
  # Set your time zone.
  time.timeZone = "America/Mexico_City";
  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    layout = "zz";
    xkbVariant = "";
  };
  #services.displayManager.sddm.wayand.enable = true;
  services.displayManager.sddm.enable = true; #set false if sddm wayland is true
  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # Uncomment to enable JACK
    # jack.enable = true;
    # media-session.enable = true; # enabled by default
  };
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.user = {
     isNormalUser = true;
     description = "User";
     extraGroups = [ "networkmanager" "wheel" "gamemode" "cpugovctl" "sysctlgroup" "libvirtd" "kvm" "input" "plugdev"];
   };
  # Configure superuser
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
  system.autoUpgrade.enable = true;
  # Deconfigure Firefox
  programs.firefox.enable = false;
  # List packages installed in system profile. To search, run;
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.flatpak
    pkgs.librewolf
    pkgs.fastfetch
    # fish shell stuff
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
    pkgs.libjxl
    pkgs.graphene-hardened-malloc
    pkgs.plasma-browser-integration
    #ROCm stuff
    rocmPackages.rocm-core
    rocmPackages.rocm-runtime
    rocmPackages.rocm-device-libs
    rocmPackages.clr
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    # Virtualization stuff
    pkgs.spice-gtk
    #pkgs.sddm-kcm
    # vim # Uncomment if needed
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
  hardware.xone.enable = true;
  hardware.xpadneo.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.steam-hardware.enable = true;
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
  # Virtualization software
  virtualisation = {
     spiceUSBRedirection.enable = true;
     #waydroid.enable = true;
     libvirtd = {
       enable = true;
       qemu.vhostUserPackages = [ pkgs.virtiofsd ];
     };
  };
  #qemu.options = ''
    #-fsdev local,security_model=none,id=fsdev0,path=/path/to/shared/folder \
    #-device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=shared
  #'';
  programs.virt-manager.enable = true;
  boot.kernelModules = [ "kvm-amd" ];
  services.spice-vdagentd.enable = true;
  # flakes configuraiton
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  # Some programs need SUID wrappesr, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #     enable = true;
  #     enableSHHSupport = true;
  #};
  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openshh.enable = true;
  # Open ports in the firewall.
  # nentworking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorst = [ ... ];
  # networking.firewall.enable = false.

  # This value detemines the NixOS release from which the defalt
  # settings for stateful data, like file locaitons and database versions
  #on your system were take. It's perfectly fine and recomended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
