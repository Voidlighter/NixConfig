{
  lib,
  inputs,
  config,
  options,
  pkgs,
  extraUtils ? true,
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
  vmware ? false,
  android ? false,
  plasma ? true,
  theming ? true,
  ...
}:
with pkgs;
  lib.optionals extraUtils [
    hello
    qdirstat # Graphical disk usage analyzer
  ]
  ++ lib.optionals baseApps [
    # Web Browser
    floorp
    ungoogled-chromium
    tor-browser

    # Internet Utils
    protonvpn-gui
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
    # lmms
    # ardour
    reaper
    # cardinal
    # bespokesynth-with-vst2

    #VSTS
    decent-sampler
    lsp-plugins
    samplv1
    vital
    #idk
    # zam-plugins
    # x42-plugins
  ]
  ++ lib.optionals streaming [
    obs-studio
  ]
  ++ lib.optionals art [
    krita
    inkscape-with-extensions
  ]
  ++ lib.optionals gaming [
    # steam
  ]
  ++ lib.optionals vmware [
    virtualbox
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
  ++ lib.optionals theming [
    # inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    papirus-folders
    papirus-icon-theme
    themix-gui
  ]
