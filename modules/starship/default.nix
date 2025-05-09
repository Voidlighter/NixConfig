{lib, ...}: {
  config.programs.starship = {
    enable = true;
    # enableBashIntegration = true;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
      git_branch.style = "242";
      directory.style = "blue";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      python.disabled = true;
      ruby.disabled = true;
      hostname.ssh_only = false;
      hostname.style = "bold green";
    };
  };
  config.xdg.configFile."starship.toml".source = lib.mkForce ./starship.toml;
}
