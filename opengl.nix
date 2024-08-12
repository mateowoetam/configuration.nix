{ pkgs, ...}:

{

hardware.opengl = {
  enable =true;
  driSupport = true;
  driSupport32Bit = true;
};
  services.xserver.videoDrivers = [ "amdgpu" ]; # change to "nvidia" for Nvidia GPUs
  #hardware.nvidia.modesetting.enable = true; # uncomment for Nvidia GPUs

  #Configure NVidia GPU mode run "nix shell nixpkgs#pciutils -c lspci | grep ' VGA '" to figrue out your GPU PCI port
  # Choose only one SYNC mode or OFFLOAD mode 
  # SYNC: GPU always on better perfornace
  # OFFLOAD: GPU only on when needed

  #SYNC
  #hardware.nvidia.prime = {
    #sync.enable = true; 
    ## integrated (CPU) 
    #amd/puBusId = ""; # looks something like "PCI:0:0:0"
    #intelBusId = "";

    ## dedicated
    #nvidiaBusId = "";
  #};

  #OFFLOAD
  #hardware.nvidia.prime = {
      #offload = {
        #enable = true;
        #enableOffloadCmd = true;
      #};
      ## integrated (CPU) 
      #amd/puBusId = ""; # looks something like "PCI:0:0:0"
      #intelBusId = "";
  
      ## dedicated
      #nvidiaBusId = "";
    #};  
  ## Specialisation 
  #specialisation = {
    #gaming-time.configuration = {
      #hardware.nvidia = {
        #prime.sync.enable = lib.mkForce true;
        #prime.offload = {
          #enable = lib.mkForce false;
          #enableOffloadcmd = lib.mkForce false;
      #};
    #};
  #];
}
