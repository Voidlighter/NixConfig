{
  lib,
  pkgs,
  cliUtils ? true,
  baseApps ? true,
  office ? true,
  social ? true,
  coding ? true,
  keyboard ? true,
  art ? false,
  java ? false,
  video ? false,
  music ? false,
  gaming ? false,
  streaming ? false,
  android ? false,
  plasma ? true,
  hyprland ? false,
  ...
}:
with pkgs;
  lib.optionals cliUtils [
    hello

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
    xorg.xkill
  ]
  ++ lib.optionals baseApps [
    jetbrains-mono

    # Web Browser
    floorp
    ungoogled-chromium
    tor-browser

    # Internet Utils
    unstable.protonvpn-gui
    wireguard-tools
    syncthing
    syncthingtray
    filezilla

    # Messaging
    signal-desktop

    # Media
    spotify
    vlc
  ]
  ++ lib.optionals office [
    rnote
    libreoffice
    remnote
    obsidian
    xournalpp

    zoom-us
    # thunderbird
  ]
  ++ lib.optionals social [
    element-desktop
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

    clang
    ccls # c / c++

    # Keyboard
    vial
  ]
  ++ lib.optionals keyboard [
    wally-cli
    keymapp
  ]
  ++ lib.optionals java [
    jetbrains.idea-ultimate
    jetbrains.jcef
    maven
    temurin-bin-21
    mariadb
  ]
  ++ lib.optionals video [
    davinci-resolve
    # davinci-resolve-studio
  ]
  ++ lib.optionals music [
    lmms
    reaper
  ]
  ++ lib.optionals streaming [
    obs-studio
  ]
  ++ lib.optionals art [
    krita
    inkscape-with-extensions
  ]
  ++ lib.optionals gaming [
    steam
  ]
  ++ lib.optionals android [
    android-udev-rules
    android-tools
    fwupd
  ]
  ++ lib.optionals plasma [
    kdePackages.kate
    kde-gtk-config
  ]
  ++ lib.optionals hyprland [
    # hyprland
    # unstable.waybar
    # unstable.mako
    # unstable.libnotify
    # unstable.swww
    # unstable.rofi-wayland
  ]
