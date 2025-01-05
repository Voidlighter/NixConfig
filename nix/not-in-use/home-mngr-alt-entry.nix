{
  # flake.nix

  # Standalone home-manager configuration entrypoint
  # Available through 'home-manager --flake .#your-username@your-hostname'
  # homeConfigurations = {
  #   # Work PC
  #   "cade@veridia" = home-manager.lib.homeManagerConfiguration {
  #     # Home-manager requires 'pkgs' instance
  #     # pkgs = inputs.nixpkgs;
  #     # pkgs = nixpkgs.legacyPackages.${system};
  #     pkgs = nixpkgs.legacyPackages.x86_64-linux;

  #     extraSpecialArgs = {
  #       inherit inputs outputs;
  #       user.name = "cade";
  #       user.Name = "Cade";
  #       host = "veridia";
  #     };
  #     modules = [
  #       # > Our main home-manager configuration file <
  #     ];
  #   };
  #   # Surface Pro Laptop
  #   "cade@elysia" = home-manager.lib.homeManagerConfiguration {
  #     # Home-manager requires 'pkgs' instance
  #     # inherit pkgs;
  #     # pkgs = nixpkgs.legacyPackages.${system};
  #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
  #     extraSpecialArgs = {
  #       inherit inputs outputs;
  #       user.name = "cade";
  #       user.Name = "Cade";
  #       host = "elysia";
  #     };
  #     modules = [
  #       # > Our main home-manager configuration file <
  #       ./nix/home-manager/elysia.nix
  #     ];
  #   };
  #   # Steam Deck
  #   "cade@vapor" = home-manager.lib.homeManagerConfiguration {
  #     # Home-manager requires 'pkgs' instance
  #     # inherit pkgs;
  #     # pkgs = nixpkgs.legacyPackages.${system};
  #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
  #     extraSpecialArgs = {
  #       inherit inputs outputs;
  #       user.name = "cade";
  #       user.Name = "Cade";
  #       host = "vapor";
  #     };
  #     modules = [
  #       # > Our main home-manager configuration file <
  #       ./nix/home-manager/vapor.nix
  #     ];
  #   };
  # };
}
