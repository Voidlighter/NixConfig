{
  description = "Cade's System Configuration Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    musnix.url = "github:musnix/musnix";
    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    affinity-nix.url = "github:mrshmllow/affinity-nix";
    eden = {
      url = "github:grantimatter/eden-flake";
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
            ./host-${me.hostname}/config.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs me; };
                users.${me.username} = import ./host-${me.hostname}/home.nix;
              };
            }
          ];
        };
        vapor = let
          me = {
            inherit username fullname email stateVersion;
            hostname = "vapor";
            system = "x86_64-linux";
          };
        in nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs me; };
          system = me.system;
          modules = [
            ./host-${me.hostname}/config.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs me; };
                users.${me.username} = import ./host-${me.hostname}/home.nix;
              };
            }
          ];
        };
        elysia = let
          me = {
            inherit username fullname email stateVersion;
            hostname = "elysia";
            system = "x86_64-linux";
          };
        in nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs me; };
          system = me.system;
          modules = [
            ./host-${me.hostname}/config.nix
            inputs.home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs me; };
                users.${me.username} = import ./host-${me.hostname}/home.nix;
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
# "vimjoyer" on YouTube: 
# Misterio77's nix starter configs: https://github.com/Misterio77/nix-starter-configs
# Ttrei's dotfiles: https://github.com/ttrei/dotfiles/
