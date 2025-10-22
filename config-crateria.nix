{ inputs, config, pkgs, me, ... }: {

  imports = [ ./config.nix ./hardware-${me.hostname}.nix ];

  config = {

    system.nixos.tags = [ "${me.hostname}-v2" ];

    my.apps = with pkgs; [ mattermost-desktop zoom-us thunderbird ];

  };
}
