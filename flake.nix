{
  description = "warashi.dev";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    theme = {
      url = "github:526avijitgupta/gokarna";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      emacs-overlay,
      theme,
      ...
    }:
    let
      baseURL = "https://warashi.dev/";
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ emacs-overlay.overlays.default ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            hugo
            nodejs
            go
            nixfmt-rfc-style
          ];
        };
        packages = pkgs.callPackage ./build.nix { inherit theme baseURL; };
      }
    );
}
