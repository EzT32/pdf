{ pkgs ? import <nixpkgs> {} }:

pkgs.buildPythonApplication {
  pname = "pdf";
  version = "0.1.0";
  src = ./.;

  propagatedBuildInputs = [
    pkgs.pandoc
    pkgs.texlive.combined.scheme-small
  ];

  doCheck = false;
}

