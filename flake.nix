{
  description = "Cade's Root Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      # url = "github:nix-community/home-manager/release-25.05";  # or "release-23.11"
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #disko = {
    #  url = "github:nix-community/disko";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    musnix.url = "github:musnix/musnix";
    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    mkSystem = modules:
      nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = {inherit inputs outputs;};
      };
  in rec {
    inherit nixpkgs;
    inherit nixpkgs-stable;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild switch --flake ./dotfiles#your-hostname'
    nixosConfigurations = {
      veridia = mkSystem [./hosts/veridia]; # Desktop PC
      elysia = mkSystem [./hosts/elysia]; # Surface Pro Laptop
      laserbeak = mkSystem [./hosts/laserbeak]; # Testing Laptop
      vapor = mkSystem [./hosts/vapor]; # Steam Deck
      small = mkSystem [./hosts/small]; # Testing Laptop
      crateria = mkSystem [./hosts/crateria]; # Supercomputer Access
      workship = mkSystem [./hosts/workship]; # Supercomputer Access
      mothership = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        system = "x86_64-linux";
        modules = [
          inputs.disko.nixosModules.disko
          ./hosts/mothership/default.nix
        ];
      };
    };
    homeConfigurations = {
      "cade@crateria" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          osConfig = self.nixosConfigurations.crateria.config;
        };
        modules = [./hosts/crateria/home.nix];
      };
      "cade@elysia" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          config = self.nixosConfigurations.elysia.config;
        };
        modules = [./hosts/elysia/home.nix];
      };
    };

    # Your custom packages
    # Accessible through 'nix build', 'nix shell', e.g.,
    # nix shell /home/reinis/dotfiles#mypkgs.x86_64-linux.arcanPackages.arcan
    mypkgs = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {inherit pkgs;}
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
        import ./shell.nix {inherit pkgs;}
    );

    # Your custom packages and modifications, exported as overlays
    overlays = import ./modules/overlays {inherit inputs;};

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;
  };
}
# Based on https://github.com/Misterio77/nix-starter-configs
# and https://github.com/ttrei/dotfiles/

