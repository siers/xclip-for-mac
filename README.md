# xclip for mac

This project provides an executable with a xclip-compatible interface, which can be useful,
if you're too lazy to refactor your linux dev shell utilities.

If you pipe to it and write something in it, or pass `-o` in the arguments at any position,
it will act as `pbcopy`.
If you write nothing to it, it will become `pbpaste`.

## nix

    with (import <nixpkgs> {});

    haskellPackages.callPackage ({ mkDerivation, base, bytestring, process, stdenv, fetchgit }:
      mkDerivation {
        pname = "xclip";
        version = "0.1.0.0";
        src = fetchgit {
          rev = "59f3d3bdc01df6be666e5d5cd9f95fa3d4443c9d";
          url = "https://github.com/siers/xclip-for-mac";
          sha256 = "0fbbi1zapla8b0ybllwsz1akb6aldqggjb0m5a54qmsbx4sbynvr";
        };
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [ base bytestring process ];
        description = "xclip for mac";
        license = "unlicense";
        platforms = stdenv.lib.platforms.darwin;
      }) {}
