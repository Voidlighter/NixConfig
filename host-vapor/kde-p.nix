{ inputs, pkgs, lib, me, ... }: {

  config = {
    # services.displayManager.sddm = {
    #   enable = true;
    #   theme = "breeze";
    #   wayland.enable = true;
    #   # enableHidpi = true;
    #   settings = {
    #     Autologin = {
    #       Session = "plasma.desktop";
    #       User = "cade";
    #     };
    #   };
    # };
    services.desktopManager.plasma6.enableQt5Integration = true;
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs; [
      # kdePackages.<package>
    ]; 
  };
}
