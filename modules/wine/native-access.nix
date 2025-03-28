# Lifted from https://github.com/yusefnapora/native-access-nix
# Wine-wrapped "Native Access", used to install software instruments, samples, etc.
# made by Native Instruments. Uses Native Access v1, since v2 doesn't work under wine yet.
{
  pkgs,
  fetchurl,
  fetchzip,
  makeDesktopItem,
  symlinkJoin,
  wrapWine,
  ...
}: let
  inherit (pkgs) writeShellScriptBin;

  name = "native-access";

  installer = fetchzip {
    url = "https://www.native-instruments.com/fileadmin/downloads/Native_Access_Installer_211108.zip";
    sha256 = "sha256-3Jq/W51IPtcV1uL/147diZXfX+I0q+dTlHna6j3Q+s0=";
  };

  installer-exe = "${installer}/Native Access 1.14.1 Setup PC.exe";

  wine = pkgs.wine.override {
    wineBuild = "wineWow";

    # stable might also work, but yabridge uses wine staging,
    # so this will probably result in less disk usage overall
    wineRelease = "staging";

    # prevent a prompt to install wine-mono on first launch
    embedInstallers = true;
  };
  wine-bin = "${wine}/bin/wine64";

  bin = wrapWine {
    inherit name wine;

    is64bits = true;

    # prevent the Native Access installer from installing a broken version of ucrtbase.dll
    tricks = ["ucrtbase2019"];

    firstrunScript = ''
      echo "-----------------------------"
      echo "| Installing Native Access  |"
      echo "-----------------------------"

      # The installer hangs trying to install the ISO driver
      # if windows version is less than 10. The app will run
      # if you set windows version to 7 after install, but it
      # crashes more often, so win10 works best.

      winecfg /v win10
      wine "${installer-exe}" /S

      echo "-------------------------"
      echo "| Installation complete |"
      echo "-------------------------"
    '';

    executable = "$WINEPREFIX/drive_c/Program Files/Native Instruments/Native Access/Native Access.exe";
  };

  xargs = "${pkgs.findutils}/bin/xargs";
  grep = "${pkgs.gnugrep}/bin/grep";
  unzip = "${pkgs.unzip}/bin/unzip";

  # script to install from downloaded ISO images, since Native Access fails
  # to mount them. Requires services.udisks2.enable to be set to true in your
  # nixos config (or your distro's equivalent if not using NixOS).

  plugin-install-script = writeShellScriptBin "ni-plugin-install" ''
    export APP_NAME="ni-plugin-install"
    export WINEARCH=win64
    export WINE_NIX_PROFILES="$HOME/.wine-nix-profiles"
    export WINE_NIX="$HOME/.wine-nix"
    export HOME="$WINE_NIX_PROFILES/${name}"
    export WINEPREFIX="$WINE_NIX/${name}"
    if [ ! -d "$WINEPREFIX" ] # if the prefix does not exist
    then
      echo "This script is designed to work with a wine-wrapped Native Access."
      echo "Please run ${name} first to create the wine prefix, then try again"
      exit 1
    fi
    if [ ! "$REPL" == "" ]; # if $REPL is setup then start a shell in the context
    then
      bash
      exit 0
    fi

    installer_src=""

    if [ ! "$1" == "" ]; then
      installer_src="$1"
    fi

    ni_downloads_dir=''${NI_DOWNLOADS_DIR:-"$HOME/Downloads"}

    if [ "$installer_src" == "" ]; then
      file_paths=$(ls "$ni_downloads_dir"/*.{zip,iso} 2>/dev/null)
      if [ "$file_paths" == "" ]; then
        echo "no installer files found in $ni_downloads_dir"
        echo "set the NI_DOWNLOADS_DIR environment variable if you're using a non-default location, or pass the full path to the installer .iso or .zip file as an argument to this script"
        exit 1
      fi

      echo "choose an installer file from $ni_downloads_dir:"
      select file in $(echo "$file_paths" | ${xargs} basename -a); do
        installer_src="$ni_downloads_dir/$file"
        break
      done
    fi

    workdir=""
    loop_dev=""
    function cleanup () {
      if [ ! "$workdir" == "" ]; then
        rm -rf "$workdir"
      fi

      if [ ! "$loop_dev" == "" ]; then
        echo "unmounting iso and removing loopack device $loop_dev"
        udisksctl unmount -b "$loop_dev"
        udisksctl loop-delete -b "$loop_dev"
      fi
      echo "cleanup complete"
    }

    trap cleanup EXIT

    function check_udisks_enabled() {
      type udisksctl >/dev/null 2>&1 || {
        echo "unable to mount ISO with udisks."
        echo "if you're on NixOS, add this to your config: services.udisks2.enabled = true;"
        exit 1
      }
    }

    function install_iso_udisks() {
      local iso_file="$1"
      loop_dev=$(udisksctl loop-setup -f "$iso_file" | ${grep} -Po '/dev/loop[0-9]+')
      if [ "$loop_dev" == "" ]; then
        echo "unable to setup loopback device"
        exit 1;
      fi
      local mount_point=$(udisksctl mount -t udf -o unhide -b $loop_dev | ${grep} -Po 'Mounted.* at \K(.*)$')

      local exes=( "$mount_point"/*.exe )
      local installer_exe=$(printf "''${exes[0]}")

      echo installing from $installer_exe
      ${wine-bin} "$installer_exe"
    }


    function install_zip() {
      local zipfile="$1"
      workdir=$(mktemp -d)
      if [[ ! "$workdir" || ! -d "$workdir" ]]; then
        echo "could not create temp dir"
        exit 1
      fi

      cd "$workdir"
      ${unzip} "$zipfile"
      local exes=( "$workdir"/*.exe )
      local installer_exe=$(printf "''${exes[0]}")

      echo "installing from $installer_exe"
      ${wine-bin} "$installer_exe"
    }


    if [[ "$installer_src" == *.iso ]]; then
      check_udisks_enabled
      install_iso_udisks "$installer_src"
    elif [[ "$installer_src" = *.zip ]]; then
      install_zip "$installer_src"
    else
      echo "unexpected file extension $file_ext"
      exit 1
    fi

    echo "Install complete! Close and re-open Native Access to finish license registration."
  '';

  desktop = makeDesktopItem {
    name = "Native Access";
    desktopName = "Native Access";
    type = "Application";
    exec = "${bin}/bin/native-access";
    icon = ./native-instruments-logo.png;
  };
in
  symlinkJoin {
    name = "native-access";
    paths = [bin desktop plugin-install-script pkgs.samba];
  }
