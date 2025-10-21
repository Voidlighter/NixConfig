# Big thanks to "tony" on YouTube: https://youtu.be/2QjzI5dXwDY
#
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    omarchy-nix = {
      url = "github:henrysipp/omarchy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.veridia = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./default.nix
        inputs.omarchy-nix.nixosModules.default
        inputs.home-manager.nixosModules.default
        {
          omarchy = {
            full_name = "Cade";
            email_address = "cade@voidlighter.org";
            theme = "tokyo-night";
          };
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.cade = {
              imports = [ ./home.nix inputs.omarchy-nix.homeManagerModules.default ];
            };
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
