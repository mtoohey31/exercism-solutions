{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    with import nixpkgs { inherit system; }; {
      devShells.lua = mkShell {
        packages = [ exercism (lua.withPackages (ps: [ ps.busted ])) ];
      };
    });
}
