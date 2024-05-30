{
  inputs = {
    foliage.url = "github:andreabedini/foliage";
    nixpkgs.follows = "foliage/nixpkgs";
    flake-utils.follows = "foliage/flake-utils";
  };

  outputs = { self, nixpkgs, foliage, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShells.default = with pkgs; mkShellNoCC {
            name = "kronor-haskell-packages";
            buildInputs = [
              bash
              coreutils
              curlMinimal.bin
              gitMinimal
              gnutar
              foliage.packages.${system}.default
            ];
          };
        });

  nixConfig = {
    extra-substituters = [
      "https://foliage.cachix.org"
    ];
    extra-trusted-public-keys = [
      "foliage.cachix.org-1:kAFyYLnk8JcRURWReWZCatM9v3Rk24F5wNMpEj14Q/g="
    ];
  };
}
