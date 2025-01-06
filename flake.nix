{
  description = "Cade's Root Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # Also see the 'stable-packages' overlay at 'overlays/default.nix'.
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable.url = "github:nix-community/home-manager/release-24.11";

    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in rec {
    inherit nixpkgs;
    inherit nixpkgs-stable;

    # Your custom packages
    # Accessible through 'nix build', 'nix shell', e.g.,
    # nix shell /home/reinis/dotfiles#mypkgs.x86_64-linux.arcanPackages.arcan
    mypkgs = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./nix/pkgs {inherit pkgs;}
    );
    # nixpkgs with your modifications applied
    # nix shell /home/reinis/dotfiles#modified-pkgs.x86_64-linux.arcanPackages.arcan
    modified-pkgs = forAllSystems (
      system:
        import nixpkgs {
          inherit system;
          overlays = [overlays.modifications];
        }
    );
    # Unmodified nixpkgs
    # nix shell /home/reinis/dotfiles#unmodified-pkgs.x86_64-linux.arcanPackages.arcan
    # Probably could have called this "pkgs", but I'm not sure if that could break something.
    unmodified-pkgs = forAllSystems (
      system: nixpkgs.legacyPackages.${system}
    );
    # Devshell for bootstrapping
    # Acessible through 'nix develop'
    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./nix/shell.nix {inherit pkgs;}
    );

    # Your custom packages and modifications, exported as overlays
    overlays = import ./nix/overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./nix/modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./nix/modules/home-manager;

    user.name = "cade";
    user.Name = "Cade";

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild switch --flake .#your-hostname'
    nixosConfigurations = {
      # Work PC
      veridia = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          user = outputs.user;
          host = "veridia";
        };
        modules = [
          ./nix/hosts/veridia/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.cade = import ./nix/home-manager/veridia.nix;
              extraSpecialArgs = {
                inherit inputs outputs;
                user = outputs.user;
              };
            };
          }
        ];
      };
      # Surface Pro Laptop
      elysia = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          user = outputs.user;
          host = "elysia";
        };
        modules = [
          # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          nixos-hardware.nixosModules.microsoft-surface-common
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
          ./nix/hosts/elysia/configuration.nix
          home-manager.nixosModules.home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.cade = import ./nix/home-manager/elysia.nix;
              extraSpecialArgs = {
                inherit inputs outputs;
                user = outputs.user;
              };
            };
          }
        ];
      };
      # Steam Deck
      vapor = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          user = outputs.user;
          host = "vapor";
        };
        modules = [
          inputs.jovian.nixosModules.default
          ./nix/hosts/vapor/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          home-manager.nixosModules.home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.cade = import ./nix/home-manager/vapor.nix;
              extraSpecialArgs = {
                inherit inputs outputs;
                user = outputs.user;
              };
            };
          }
        ];
      };
    };
  };
}
# Based on https://github.com/Misterio77/nix-starter-configs
# and https://github.com/ttrei/dotfiles/

