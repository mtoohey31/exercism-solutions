{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";

    unison-nix = {
      url = "github:ceedubs/unison-nix";
      inputs = {
        nixpkgs-non-darwin.follows = "nixpkgs";
        nixpkgs-darwin.follows = "nixpkgs";
        flake-utils.follows = "utils";
      };
    };
  };

  outputs =
    { nixpkgs
    , utils
    , unison-nix
    , ...
    }: utils.lib.eachDefaultSystem (system: with import nixpkgs
      { overlays = [ unison-nix.overlay ]; inherit system; }; {
      devShells = {
        lua = mkShell {
          packages = [ exercism (lua.withPackages (ps: [ ps.busted ])) ];
        };

        unison = mkShell {
          packages = [ exercism unison-ucm ];
        };

        x86-64-assembly = mkShell {
          packages = [ exercism nasm ];
        };
      };
    });
}
