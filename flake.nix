{
  description = "pdf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        pythonPkgs = pkgs.python3Packages;
        mypkg = pythonPkgs.buildPythonPackage {
          pname = "pdf";
          version = "0.1.0";
          src = ./.;

          pyproject = true;

          build-system = [
            pythonPkgs.setuptools
            pythonPkgs.wheel
          ];

          # runtime deps -> exported to dependents
          # propagatedBuildInputs = [ pythonPkgs.requests ];
        };
      in
      {
        packages = {
          default = mypkg;
          pdf = mypkg;
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [ (pkgs.python3.withPackages (ps: [ mypkg ])) ];
        };
        overlays = [ (final: prev: { pdf = mypkg; }) ];
      }
    );
}
