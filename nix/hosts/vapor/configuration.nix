{
  pkgs,
  pkgs-stable,
  inputs,
  user,
  host,
  options,
  ...
}: {
  imports = [
    ./../common.nix
    ./hardware-configuration.nix

    ../../modules/remote-build/build-reciever.nix

    "${inputs.jovian}/modules"
  ];

  config = {
    uses-kde = true;
    uses-sddm = false;
    added-system-packages = with pkgs; [steam-rom-manager];
    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        user = "cade";
        desktopSession = "plasma";
      };
      # hardware = {
      #   has.amd.gpu = true;
      # };
      devices.steamdeck = {
        enable = true;
        autoUpdate = true;
      };
      decky-loader = {
        enable = true;
      };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.05"; # Did you read the comment?
  };
}
