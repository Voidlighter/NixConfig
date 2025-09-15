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

      run() {
        echo "+ $*"
        "$@"
      }
      
      alias ll="ls -lah"
      alias grep="grep --color=auto"
      alias showpath="echo $PATH | tr ':' '\n'"

      alias nrs='run sudo nixos-rebuild switch --verbose --flake ~/NixConfig#${osConfig.my.hostname}'
      alias nrb='run sudo nixos-rebuild build --verbose --flake ~/NixConfig#${osConfig.my.hostname}'
      alias nrdb='run sudo nixos-rebuild dry-build --verbose --flake ~/NixConfig#${osConfig.my.hostname}'
      alias nrbt='run sudo nixos-rebuild boot --verbose --flake ~/NixConfig#${osConfig.my.hostname}'
      alias nb='nrb'
      alias ndb='nrdb'
      alias nbt='nrbt'

      nr() {
        if [[ "$1" == "switch" || "$1" == "s" ]]; then
          shift; nrs "$@"
        elif [[ "$1" == "build" || "$1" == "b" ]]; then
          shift; nrb "$@"
        elif [[ "$1" == "dry-build" || "$1" == "db" ]]; then
          shift; nrdb "$@"
        elif [[ "$1" == "boot" || "$1" == "bt" ]]; then
          shift; nrbt "$@"
        else
          echo "usage: nr {switch|s|build|b|dry-build|db|boot|bt} [args...]"
          return 2
        fi
      }

      alias hms='run home-manager switch --verbose --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}'
      alias hmb='run home-manager build --verbose --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}'
      alias hmdb='run home-manager dry-build --verbose --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}'

      alias ncg='run nix-collect-garbage --delete-old'
      alias ndot='run nix-collect-garbage --delete-older-than'
    '';
  };
  # config.xdg.configFile."starship.toml".source = lib.mkForce ./starship.toml;
}
