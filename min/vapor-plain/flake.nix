{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {

    nixosConfigurations.vapor = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./default.nix ];
    };
  };
}
