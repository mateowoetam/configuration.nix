{ config, pkgs, ...}:
{
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
}


