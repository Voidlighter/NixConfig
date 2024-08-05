{
  description = "Cade's Root Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    # the @ inputs syntax lets us not include "inputs." at the beginning of nixpkgs, while
    # still being able to access the rest of the inputs we didn't want to name here
    inherit (self) outputs;
    pkgs-unstable = nixpkgs-unstable;
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      # overlays = import ./overlays {inherit inputs;};
      overlays = [
        (final: prev: {
          unstable = nixpkgs-unstable;
        })
      ];
    };
    # pkgs = nixpkgs.legacyPackages.system;
    # pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    # Supported systems for your flake packages, shell, etc.
    # systems = [
    #   # "aarch64-linux"
    #   # "i686-linux"
    #   "x86_64-linux"
    #   # "aarch64-darwin"
    #   # "x86_64-darwin"
    # ];
    system = "x86_64-linux";
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    # forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    # packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    # formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    # overlays =

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    # nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    # homeManagerModules = import ./modules/home-manager;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      home-manager
      neovim
      wget
      git
      firefox
    ];

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      veridia = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          username = "cade";
          host = "veridia";
        };
        modules = [
          # > Our main nixos configuration file <
          ./hosts/veridia/configuration.nix
        ];
      };
      elysia = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          username = "cade";
          host = "elysia";
        };
        modules = [
          # > Our main nixos configuration file <
          ./hosts/elysia/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "cade@veridia" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        inherit pkgs pkgs-unstable;
        # pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs outputs;
          username = "cade";
          host = "veridia";
        };
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/veridia.nix
        ];
      };
      "cade@elysia" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        inherit pkgs pkgs-unstable;
        # pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs outputs;
          username = "cade";
          host = "elysia";
        };
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/elysia.nix
        ];
      };
    };
  };
}
# Based on https://github.com/Misterio77/nix-starter-configs
# and https://github.com/ttrei/dotfiles/

