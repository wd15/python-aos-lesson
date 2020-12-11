{ pkgs ? (import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz";
    sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
  }) {}) }:
let
  pypkgs = pkgs.python3Packages;
  cmocean = pypkgs.buildPythonPackage rec {
    pname = "cmocean";
    version = "2.0";
    src = pypkgs.fetchPypi {
      inherit pname version;
      sha256 = "0fmhm7p1farwcq77n7mj3jsdyvkgd0z0pnx268z313jdk74a7vhk";
    };
    buildInputs = with pypkgs; [
      pytest
      numpy
      matplotlib
    ];
  };
in
  pkgs.mkShell rec {
    pname = "graspi-env";
    nativeBuildInputs = with pypkgs; [
      xarray
      netcdf4
      cartopy
      jupyter
      scipy
      pip
      cmocean
      basemap
    ];
  }
