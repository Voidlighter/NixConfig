{ inputs, pkgs, me, ... }: {

  imports = [
  ];

  config = {
    services.getty.autologinUser = "cade";
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
