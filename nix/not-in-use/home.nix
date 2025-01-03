{
  pkgs,
  inputs,
}: {
  description = "Cade's Home Manager Base Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgsStable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    # this makes it so home-manager uses the same nixpkgs version as defined above
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    # this syntax lets us not include "inputs." at the beginning of nixpkgs, while
    # still being able to access the rest of the inputs we didn't want to name here
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    pkgsStable = inputs.nixpkgsStable.legacyPackages.x86_64-linux;
  in {
    # packages.x86_64-linux.hello = pkgs.hello;

    # packages.x86_64-linux.default = pkgs.hello;

    # pkgs.mkShell is a function that takes a set as its input
    # devShells.x86_64-linux.default = pkgs.mkShell {
    #   buildInputs = [
    #     pkgs.neovim
    #     pkgsStable.vim
    #   ];
    # };

    nixosConfigurations.veridia = nixpkgs.lib.nixosSystem {
      # inherit inputs is a shorthand of "inputs = inputs" so we can use it and its variables
      # (inputs, pkgs, etc) in specialArgs
      specialArgs = {inherit inputs;};
      modules = [
        ./home.nix
        ./configuration.nix
      ];
    };
  };
}
