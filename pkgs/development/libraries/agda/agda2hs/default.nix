{
  lib,
  mkDerivation,
  fetchFromGitHub,
}:

mkDerivation {
  version = "1.3-unstable-2024-12-18";
  pname = "agda2hs";

  src = fetchFromGitHub {
    owner = "agda";
    repo = "agda2hs";
    rev = "268a1379ef9f323644122f48a8165cec2068489e";
    hash = "sha256-hHdjhsYhQQVdUF6fvLxEp11C9RJp/nhz8Szv0EFC6tI=";
  };

  preBuild = ''
    # Haskell.Extra.Delay and Haskell.Prim.Thunk use sized types
    echo "{-# OPTIONS --sized-types #-}" > Everything.agda
    echo "module Everything where" >> Everything.agda
    find lib -name '*.agda' | sed -e 's/lib\///;s/\//./g;s/\.agda$//;s/^/import /' >> Everything.agda
  '';

  meta = with lib; {
    homepage = "https://github.com/agda/agda2hs";
    description = "Standard library for compiling Agda code to readable Haskell";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with maintainers; [
      alexarice
      turion
    ];
  };
}
