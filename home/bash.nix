{
  config,
  osConfig,
  pkgs,
  ...
}: let
  impureFlag =
    if osConfig.my.hostname == "crateria"
    then "--impure"
    else "";
in {
  programs.bash = {
    enable = true;
    historySize = 10000;

    bashrcExtra = ''
      # Vi mode
      # set -o vi

      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'

      eval -- "$(starship init bash)"

      run() {
        echo "+ $*"
        "$@"
      }


      alias ll="ls -lah"
      alias grep="grep --color=auto"
      alias showpath="echo $PATH | tr ':' '\n'"

      # nixos-rebuild helpers (add --impure only on host "crateria")
      alias nrs='run sudo nixos-rebuild switch --verbose ${impureFlag} --flake ~/NixConfig#${osConfig.my.hostname}'
      alias nrb='run sudo nixos-rebuild build --verbose ${impureFlag} --flake ~/NixConfig#${osConfig.my.hostname}'
      alias nrdb='run sudo nixos-rebuild dry-build --verbose ${impureFlag} --flake ~/NixConfig#${osConfig.my.hostname}'
      alias nrbt='run sudo nixos-rebuild boot --verbose ${impureFlag} --flake ~/NixConfig#${osConfig.my.hostname}'
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
          shift; nrdb "$@"
        fi
      }

      # home-manager helpers (same conditional flag)
      alias hms='run home-manager switch --verbose ${impureFlag} --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}'
      alias hmb='run home-manager build --verbose ${impureFlag} --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}'
      alias hmdb='run home-manager dry-build --verbose ${impureFlag} --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}'

      alias ncg='run nix-collect-garbage --delete-old'
      alias ndot='run nix-collect-garbage --delete-older-than'
    '';
  };
}
