{
  description = "Cade's System Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      username = "cade";
      fullname = "Cade";
      email = "cade@voidlighter.org";
      stateVersion = "25.05";
    in {
      nixosConfigurations = {
        veridia = let
          me = {
            inherit username fullname email stateVersion;
            hostname = "veridia";
            system = "x86_64-linux";
          };
        in nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs me; };
          system = me.system;
          modules = [
            ./config-${me.hostname}.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs me; };
                users.${me.username} = import ./home.nix;
              };
            }
          ];
        };
        elysia = let
          me = {
            inherit username fullname email;
            hostname = "elysia";
            system = "x86_64-linux";
          };
        in nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs me; };
          system = me.system;
          modules = [
            ./config-${me.hostname}.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs me; };
                users.${me.username} = import ./home-${me.hostname}.nix;
              };
            }
          ];
        };
      };
    };
}
# Big thanks to:
#
# "tony" on YouTube: https://youtu.be/2QjzI5dXwDY
# Misterio77's nix starter configs: https://github.com/Misterio77/nix-starter-configs
# Ttrei's dotfiles: https://github.com/ttrei/dotfiles/
