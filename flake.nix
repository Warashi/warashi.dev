{
  description = "warashi.dev";

  inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  flake-utils.url = "github:numtide/flake-utils";

  gokarna = {
    url = "github:526avijitgupta/gokarna";
    flake = false;
  };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }@inputs:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [hugo nodejs go];
        };
        packages = pkgs.callPackage ./build.nix {
          theme = inputs.gokarna;
        };
      }
    );
}
