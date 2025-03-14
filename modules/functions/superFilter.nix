{
  lib,
  pkgs,
}: let
  allElems = pkgs.callPackage ./allElems.nix {inherit lib;};
in
  # recursively find set names contained in args, and if found, collect everything in their set.
  # for example, superFilter ["a"] {a = {b = 5; c = 10;}} returns [5 10] while ["b"] just returns [5]
  let
    superFilter = args: input:
      lib.flatten (builtins.filter (elem: elem != []) (
        if (lib.isAttrs input && !lib.attrsets.isDerivation input)
        then
          (lib.concatMap (name: [
            (
              if (builtins.elem name args)
              then (allElems (builtins.getAttr name input))
              else lib.flatten (superFilter args (builtins.getAttr name input))
            )
          ]) (lib.attrNames input))
        else []
      ));
  in
    superFilter
