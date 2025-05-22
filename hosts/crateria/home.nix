{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ../options.nix
    ../home-common.nix
  ];

  my.app.base.enable = true;
  my.app.utils.enable = true;
  my.app.office.enable = true;
  my.app.vmware.enable = true;
  my.app.work.enable = true;
  my.apps.extras = [pkgs.obsidian];
}
