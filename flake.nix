# Big thanks to "tony" on YouTube: https://youtu.be/2QjzI5dXwDY
#
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    my.username = "cade";
  in
  {
    nixosConfigurations = {
      veridia = 
        let
          my.hostname = "veridia";
          my.system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem {
        system = my.system;
        modules = [
          ./config-${hostname}.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home-${hostname}.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
      elysia = 
        let
          my.hostname = "elysia";
          my.system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem {
        system = my.system;
        modules = [
          ./config-${hostname}.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home-${hostname}.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
