{
  lib,
  pkgs,
  gaming ? false,
  lightweight ? true,
  school ? false,
  coding ? true,
  javaCoding ? false,
  videoEditing ? false,
  streaming ? false,
  android ? false,
  art ? false,
  ...
}:
with pkgs;
  lib.optionals lightweight [
    hello
    jetbrains-mono

    hyprland
    unstable.waybar
    unstable.mako
    unstable.libnotify
    unstable.swww
    unstable.rofi-wayland

    unstable.floorp
    ungoogled-chromium
    ## other
    libreoffice
    qownnotes
    kdePackages.kate
    protonvpn-gui
    libsForQt5.kdeconnect-kde
    signal-desktop
    kde-gtk-config
    spotify

    # CLI Utilities
    bat
    curl
    eza
    fd
    ripgrep
    zellij
    bottom
    zoxide
    fzf
    starship

    # Keyboard
    vial
  ]
  ++ lib.optionals coding [
    alacritty
    vscodium
    zed-editor
    # nix
    alejandra
    deadnix
    statix
    nil
    python3
    biome
  ]
  ++ lib.optionals javaCoding [
    jetbrains.idea-ultimate
    jetbrains.jcef
    maven
    temurin-bin-21
    mysql
    mysql-shell
  ]
  ++ lib.optionals videoEditing [
    davinci-resolve
  ]
  ++ lib.optionals streaming [
    obs-studio
  ]
  ++ lib.optionals school [
    zoom-us
  ]
  ++ lib.optionals art [
    krita
  ]
  ++ lib.optionals gaming [
    steam
  ]
  ++ lib.optionals android [
    android-udev-rules
    android-tools
    fwupd
  ]
