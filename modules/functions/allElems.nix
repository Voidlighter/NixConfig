{lib}:
# for sets and lists within other lists, get all the elements
let
  allElems = input:
    if (lib.isList input)
    then lib.flatten (lib.concatMap (x: [(allElems x)]) input)
    else if (lib.isAttrs input && !lib.attrsets.isDerivation input)
    then allElems (lib.attrValues input)
    else input;
in
  allElems
