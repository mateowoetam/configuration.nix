# flake.nix
{
  description = "My first Flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    #suyu = {
     # url = "git+https://git.suyu.dev/suyu/nix-flake";
     # inputs.nixpkgs.follows = "nixpkgs";
    #};
    #nix-software-center.url = "github:snowfallorg/nix-software-center";
  };

  outputs = {self, nixpkgs, ...}@inputs: {
    # Set up for NixOS
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        inputs.stylix.nixosModules.stylix
        inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
        inputs.chaotic.nixosModules.default
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.nix-gaming.nixosModules.platformOptimizations
      ];
    };

    # Set up for Home Manager
    homeConfigurations.user = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };

      extraSpecialArgs = {inherit inputs;};

      modules = [
        ./home.nix
        inputs.chaotic.homeManagerModules.default
        #inputs.nix-gaming.homeManagerModules.platformOptimizations
      ];
    };
  };
}
