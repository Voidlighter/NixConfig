{
  description = "Cade's Root Flake";
  # Based on https://github.com/Misterio77/nix-starter-configs
  # and https://github.com/ttrei/dotfiles/

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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

    musnix.url = "github:musnix/musnix";

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    # nixpkgs-stable,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  in {
    inherit nixpkgs;
    # inherit nixpkgs-stable;

    # NixOS configuration entrypoint
    # Available through 'sudo nixos-rebuild switch --flake ~/directory#hostname'
    nixosConfigurations = {
      veridia = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        inherit system pkgs;
        modules = [
          ./hosts/veridia/default.nix
        ];
      };
      elysia = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        inherit system pkgs;
        modules = [
          ./hosts/elysia/default.nix
        ];
      };
      crateria = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        inherit system pkgs;
        modules = [
          ./hosts/crateria/default.nix
        ];
      };
      vapor = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        inherit system pkgs;
        modules = [
          ./hosts/vapor/default.nix
        ];
      };
      laserbeak = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        inherit system pkgs;
        modules = [
          ./hosts/laserbeak/default.nix
        ];
      };
    };
    # Home Manager configuration entrypoint
    # Available through 'home-manager switch --flake ~/directory#user@hostname'
    homeConfigurations = {
      "cade@veridia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
          osConfig = self.nixosConfigurations.veridia.config;
        };
        modules = [./hosts/veridia/home.nix];
      };
      "cade@elysia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
          osConfig = self.nixosConfigurations.elysia.config;
        };
        modules = [./hosts/elysia/home.nix];
      };
      "cade@crateria" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
          osConfig = self.nixosConfigurations.crateria.config;
        };
        modules = [./hosts/crateria/home.nix];
      };
      "cade@vapor" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
          osConfig = self.nixosConfigurations.vapor.config;
        };
        modules = [./hosts/vapor/home.nix];
      };
      "cade@laserbeak" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
          osConfig = self.nixosConfigurations.laserbeak.config;
        };
        modules = [./hosts/laserbeak/home.nix];
      };
    };
  };
}


