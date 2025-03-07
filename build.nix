{
  pkgs,
  lib,
  theme,
  baseURL,
  ...
}:
let
  callPackage = lib.callPackageWith (pkgs // packages);
  packages = {
    build = callPackage (
      {
        writeShellApplication,
        decrypt,
        nix,
      }:
      writeShellApplication {
        name = "build";
        runtimeInputs = [
          nix
          decrypt
        ];
        text = ''
          decrypt && git add -fN contents.org && nix build '.#public'; git rm -f contents.org
        '';
      }
    ) { };
    decrypt = callPackage (
      {
        writeShellApplication,
        age,
      }:
      writeShellApplication {
        name = "decrypt";
        runtimeInputs = [ age ];
        text = ''
          age -d -i "''${AGE_SECRET_KEY_FILE:-$HOME/.emacs.d/age/secret-key}" -o contents.org contents.org.age
        '';
      }
    ) { };
    contents = callPackage (
      {
        runCommand,
        emacsPackagesFor,
        emacs-nox,
      }:
      runCommand "contents"
        {
          src = ./contents.org;
          nativeBuildInputs = [
            ((emacsPackagesFor emacs-nox).emacsWithPackages (
              epkgs: with epkgs; [
                org
                ox-hugo
              ]
            ))
          ];
        }
        ''
          mkdir -p $out/static
          emacs --batch --eval "(progn (require 'org) (require 'ox-hugo) (setq org-hugo-base-dir \"$out\") (with-current-buffer (find-file-noselect \"$src\") (org-hugo-export-wim-to-md t)))"
        ''
    ) { };
    themes = callPackage (
      { runCommand, theme }:
      runCommand "themes" { src = theme; } ''
        mkdir -p $out
        cp -r $src $out/theme
      ''
    ) { inherit theme; };
    public = callPackage (
      {
        runCommand,
        go,
        hugo,
        nodejs,
        contents,
        themes,
      }:
      runCommand "public"
        {
          nativeBuildInputs = [
            go
            hugo
            nodejs
          ];
        }
        ''
          hugo --minify --noBuildLock --environment production --baseURL ${baseURL} --source ${./.} --theme theme --themesDir ${themes.outPath} --contentDir ${contents.outPath}/content --destination $out
        ''
    ) { };
  };
in
packages
// {
  default = packages.build;
}
