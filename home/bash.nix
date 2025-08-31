{
  config,
  osConfig,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    # History settings
    historySize = 10000;
    # historyFileSize = 10000;
    # historyControl = [ "ignoredups" "ignorespace" ];
    # blesh.enable = true;

    bashrcExtra = ''
      # Vi mode
      # set -o vi

      # Enable bash history substring search (not built-in like zsh)
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'

      # starship
      eval -- "$(starship init bash)"
      
      # devbox
      # eval "$(devbox global shellenv)"

      run() {
        echo "+ $*"
        "$@"
      }
      
      alias ll="ls -lah"
      alias grep="grep --color=auto"
      alias showpath="echo $PATH | tr ':' '\n'"

      alias nrs='run nixos-rebuild switch --verbose --flake ~/NixConfig#${osConfig.my.hostname}'
      alias nb='run nixos-rebuild build --verbose --flake ~/NixConfig#${osConfig.my.hostname}'
      alias ndb='run nixos-rebuild dry-build --verbose --flake ~/NixConfig#${osConfig.my.hostname}'
      alias nrb='run nixos-rebuild boot --verbose --flake ~/NixConfig#${osConfig.my.hostname}'

      alias hms='run home-manager switch --verbose --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}'
      alias hmb='run home-manager build --verbose --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}'
      alias hmdb='run home-manager dry-build --verbose --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}'

      alias ncg='run nix-collect-garbage --delete-old'
      alias ndot='run nix-collect-garbage --delete-older-than'
    '';
  };
  # config.xdg.configFile."starship.toml".source = lib.mkForce ./starship.toml;
}
