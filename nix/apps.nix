{
  lib,
  pkgs,
  cliUtils ? true,
  baseApps ? true,
  office ? true,
  social ? true,
  plasma ? true,
  hyprland ? false,
  coding ? true,
  keyboard ? true,
  art ? false,
  javaCoding ? false,
  pythonCoding ? false,
  videoEditing ? false,
  gaming ? false,
  streaming ? false,
  android ? false,
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
  ++ lib.optionals javaCoding [
    jetbrains.idea-ultimate
    jetbrains.jcef
    maven
    temurin-bin-21
    mariadb
  ]
  ++ lib.optionals videoEditing [
    davinci-resolve
    # davinci-resolve-studio
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
