{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    ...
  }: {
    nixosConfigurations.veridia = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [./default.nix];
    };
  };
}
