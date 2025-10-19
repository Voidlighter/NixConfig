{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = inputs@{ self, nixpkgs, nixos-hardware, ... }: {

    nixosConfigurations.elysia = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs nixos-hardware;};
      system = "x86_64-linux";
      modules = [ ./default.nix ];
    };
  };
}
