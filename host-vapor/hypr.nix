{ inputs, pkgs, me, ... }: {

  imports = [
    inputs.noctalia.nixosModules.default
  ];

  config = {
    services.getty.autologinUser = "cade";
    services.noctalia-shell.enable = true;
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
  };
}
