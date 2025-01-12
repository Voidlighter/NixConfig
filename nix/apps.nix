{
  lib,
  inputs,
  config,
  options,
  pkgs,
  ...
}: {
  system = with pkgs; [
    neovim
    # inputs.pkgsStable.legacyPackages.${pkgs.system}.vim
    zsh
    wget
    git

    bat
    curl
    eza
    fd
    ripgrep
    zellij
    bottom
    zoxide
    fzf
    zsh-powerlevel10k
    xorg.xkill

    firefox
    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    inter
    rubik
    # Nix UI: Snowfallorg
    inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
    inputs.nix-software-center.packages.${system}.nix-software-center
    # Theming
    kde-rounded-corners
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qtstyleplugin-kvantum
  ];
  extraUtils = with pkgs; [
    hello
    qdirstat # Graphical disk usage analyzer
  ];
  baseApps = with pkgs; [
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
  ];
  office = with pkgs; [
    rnote
    libreoffice
    remnote
    obsidian
    xournalpp

    zoom-us
    # thunderbird
  ];
  social = with pkgs; [
    element-desktop
  ];
  coding = with pkgs; [
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
  ];
  keyboard = with pkgs; [
    wally-cli
    keymapp
  ];
  java = with pkgs; [
    jetbrains.idea-ultimate
    jetbrains.jcef
    maven
    temurin-bin-21
    mariadb
  ];
  video = with pkgs; [
    davinci-resolve
    # davinci-resolve-studio
  ];
  music = with pkgs; [
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
  ];
  streaming = with pkgs; [
    obs-studio
  ];
  art = with pkgs; [
    krita
    inkscape-with-extensions
  ];
  gaming = with pkgs; [
    # steam
  ];
  vmware = with pkgs; [
    virtualbox
  ];
  android = with pkgs; [
    android-udev-rules
    android-tools
    fwupd
  ];
  plasma = with pkgs; [
    kdePackages.kate
    kde-gtk-config
  ];
  theming = with pkgs; [
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    papirus-folders
    papirus-icon-theme
    themix-gui
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
}
