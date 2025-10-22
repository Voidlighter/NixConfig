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
      username = "cade";
      fullname = "Cade";
      email = "cade@voidlighter.org";
    in {
      nixosConfigurations = {
        veridia = let
          me = {
            inherit username fullname email;
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
                users.${me.username} = import ./home-${me.hostname}.nix;
              };
            }
          ];
        };
        elysia = let
          me.hostname = "elysia";
          me.system = "x86_64-linux";
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
                extraSpecialArgs = { inherit inputs me; };
                users.${me.username} = import ./home-${me.hostname}.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };
    };
}
