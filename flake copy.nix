{
  description = "Cade's Root Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs.follows = "nixos-cosmic/nixpkgs";
    # Also see the 'stable-packages' overlay at 'modules/overlays/default.nix'.
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
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
    defaultSystem = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${defaultSystem};

    defineHost = {
      name,
      path ? ./hosts/${name},
      system ? defaultSystem,
      nixos ? true,
      hm ? true,
      extraModules ? [],
      ...
    }: let
      nixosConfiguration =
        if nixos
        then
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {inherit inputs self;};
            modules = extraModules ++ ["${path}/default.nix"];
          }
        else null;

      homeConfiguration =
        if hm
        then
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};
            extraSpecialArgs = {
              inherit inputs self;
              osConfig =
                if nixos
                then nixosConfiguration.config
                else null;
            };
            modules = ["${path}/home.nix"];
          }
        else null;
    in {
      inherit nixosConfiguration homeConfiguration;
    };

    # Define your systems here
    allHosts = {
      veridia = defineHost {name = "veridia";};
      elysia = defineHost {name = "elysia";};
      laserbeak = defineHost {name = "laserbeak";};
      vapor = defineHost {name = "vapor";};
      small = defineHost {name = "small";};
      crateria = defineHost {name = "crateria";};
      workship = defineHost {name = "workship";};
      mothership = defineHost {
        name = "mothership";
        # extraModules = [inputs.disko.nixosModules.disko];
      };
      minifig = defineHost {
        name = "minifig";
        nixos = false;
        hm = true;
        # Optionally: system = "aarch64-linux";
      };
    };

    # Filter only the hosts that have configs
    getDefined = field:
      nixpkgs.lib.filterAttrs (_: v: v != null)
      (nixpkgs.lib.mapAttrs (_: v: v.${field}) allHosts);
  in rec {
    inherit nixpkgs nixpkgs-stable;

    nixosConfigurations = getDefined "nixosConfiguration";
    homeConfigurations = getDefined "homeConfiguration";

    mypkgs = import ./pkgs {inherit pkgs;};

    modified-pkgs = import nixpkgs {
      inherit defaultSystem;
      overlays = [overlays.modifications];
    };

    unmodified-pkgs = pkgs;

    devShells = import ./shell.nix {inherit pkgs;};

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
# Once based on https://github.com/Misterio77/nix-starter-configs
# and https://github.com/ttrei/dotfiles/

