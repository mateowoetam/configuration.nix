{ config, pkgs, ...}:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
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
  };
}

