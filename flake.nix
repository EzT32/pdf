{
  description = "Markdown to PDF converter";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
    in
    {
      packages = builtins.listToAttrs (map (system: {
        name = system;
        value = let
          pkgs = import nixpkgs { inherit system; };
        in pkgs.buildPythonApplication {
          pname = "pdf";
          version = "0.1.0";
          src = self;
          propagatedBuildInputs = [
            pkgs.pandoc
            pkgs.texlive.combined.scheme-small
          ];
          doCheck = false;
        };
      }) systems);

      defaultPackage.x86_64-linux = self.packages.x86_64-linux;
    };
}
