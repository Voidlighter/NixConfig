{lib, pkgs}:
let allElems = input:
  if (lib.isList input)
    then lib.flatten (lib.concatMap (x: [(allElems x)]) (input))
  else if (lib.isAttrs input && !lib.attrsets.isDerivation input)
    then allElems (lib.attrValues input)
  else input;
in
let superFilter = args: input:
  lib.flatten (builtins.filter (elem: elem != []) (if (lib.isAttrs input && !lib.attrsets.isDerivation input)
    then (lib.concatMap (name:[(
      if (builtins.elem name args) 
        then (allElems (builtins.getAttr name input))
      else lib.flatten (superFilter args(builtins.getAttr name input))
      # else [lib.flatten (superFilter args (builtins.getAttr name input))]
      )]) (lib.attrNames input))
  else []));
in
superFilter ["a" "b" "l"] {
  a = {
    x = [pkgs.bat pkgs.curl];
    y = [pkgs.zsh pkgs.git];
  };
  b = [pkgs.eza pkgs.fzf];
  c = [pkgs.neovim];
  d = [pkgs.starship];
  e = {  
    ea = "stringy";
    eb = pkgs.bash;
    ec = ["x" "y" "z"];
    ed = { da = ["dax" "day" "daz"]; db = {dba = "dbax"; dbb = ["dbbx" "dbby"];};};
  };
}
# superFilter ["a l"] {a = ["ax" {aa = ["aax" {aaa = "aaax";} "aay"];} "ay"];} 
lib.elemAt (
) 1
# superFilter ["a" "d" "e"] {a = 1; b = 2; c = {d = 5; e = 10;};}
# superFilter ["a" "c"] {a = 1; b = 2; c = 3;}
# superFilter ["a" "c"] 
# superFilter ["a"] [1 7]


# allElems {
#   a = {
#     x = [pkgs.bat pkgs.curl];
#     y = [pkgs.zsh pkgs.git];
#   };
#   b = [pkgs.eza pkgs.fzf];
#   c = [pkgs.neovim];
#   d = [pkgs.starship];
#   e = {  
#     a = "stringy";
#     b = pkgs.bash;
#     c = ["x" "y" "z"];
#     d = { da = ["dax" "day" "daz"]; db = {dba = "dbax"; dbb = ["dbbx" "dbby"];};};
#   };
# }

# allElems [1 [2 [3 [{a = 4;}] 5] 6] 7]

lib.filterAttrsRecursive (name: value: name != "") {a = {b = {c = 2; }; }; }


lib.concatMap (x: [(x)]) [["A"] "b" "c"]

lib.concatMap (
  foo:(
    (
      if (builtins.isList foo) 
        then foo 
      else if (builtins.isAttrs foo && !(lib.attrsets.isDerivation foo)) 
        then (lib.attrValues foo) 
      else (lib.singleton foo) 
    )
  )
)




lib.concatMap (lib.singleton builtins.typeOf) (
  lib.attrValues (
  lib.getAttrs ["a" "b" "c"] {
    a = {
      x = [pkgs.bat pkgs.curl];
      y = [pkgs.zsh pkgs.git];
    };
    b = [pkgs.eza pkgs.fzf];
    c = [pkgs.neovim];
    d = [pkgs.starship];
  }
))


let
  allElems = input:
    if (builtins.isAttrs input && !lib.isDerivation input)
      then (allElems (lib.attrValues input))
    else if (builtins.isList input)
      then (lib.concatMap (j: allElems j) input)
    else input;
in
  allElems (
  lib.getAttrs ["a" "b" "c"] {
    a = {
      x = [pkgs.bat pkgs.curl];
      y = [pkgs.zsh pkgs.git];
    };
    b = [pkgs.eza pkgs.fzf];
    c = [pkgs.neovim];
    d = [pkgs.starship];
  }
)
