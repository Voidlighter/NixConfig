{
  description = "Cade's Root Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    # this makes it so home-manager uses the same nixpkgs version as defined above
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    # the @ inputs syntax lets us not include "inputs." at the beginning of nixpkgs, while
    # still being able to access the rest of the inputs we didn't want to name here
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
    # pkgs = nixpkgs.legacyPackages.system;
    pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
  in {
    # packages.${system}.hello = pkgs.hello;

    # packages.${system}.default = pkgs.hello;

    # pkgs.mkShell is a function that takes a set as its input
    # devShells.${system}.default = pkgs.mkShell {
    #   buildInputs = [
    #     pkgs.neovim
    #     pkgsStable.vim
    #   ];
    # };

    nixosConfigurations = {
      veridia = nixpkgs.lib.nixosSystem {
        # inherit inputs is a shorthand of "inputs = inputs" so we can use it and its variables
        # (inputs, pkgs, etc) in specialArgs
        specialArgs = {inherit inputs system;};
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
