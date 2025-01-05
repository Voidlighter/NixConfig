{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "gruvbox-plus";
  src = pkgs.fetchurl {
    url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v6.0.2/gruvbox-plus-icon-pack-6.0.2.zip";
    # to get sha256, run
    sha256 = "1791ynnfdqjsmk15i5b8aaxvfdbwf6mxl972qblf18zhs4l2h86s";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
  '';
}
