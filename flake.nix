{

 description = "My first Flake!";

 inputs = {
   nixpkgs = {
     url = "github:NixOS/nixpkgs/nixos-24.05";
   };
   stylix = {
     url = "github:danth/stylix";
   };
   home-manager = {
     url = "github:nix-community/home-manager/release-24.05";
     inputs.nixpkgs.follows = "nixpkgs";
   };
 };

 outputs = { self, nixpkgs, home-manager, ... }@inputs:
   let
     lib = nixpkgs.lib;
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
   in {
   nixosConfigurations = {
     nixos = lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        inputs.stylix.nixosModules.stylix
      ];
     };
   };
   homeConfigurations = {
     user = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
      ];
     };

   };


 };


}
 
