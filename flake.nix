rec {
  description = "Cross-platform IDE for working with ACPI tables (assembled/disassembled). Smooth and efficient editing environment, tens to hundreds of thousands of lines of code can be edited with ease.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages = flake-utils.lib.flattenTree rec {
          xiasl = pkgs.appimageTools.wrapType2 rec {
            name = "xiasl";
            version = "1.1.66";
            src = pkgs.fetchurl {
              url = "https://github.com/ic005k/Xiasl/releases/download/${version}/Xiasl-Linux-x86_64.AppImage";
              sha256 = "sha256-ZIwgH5r7fMjUCJVKnQhjE/iyrmN3fr1imBC2VmZEHLM=";
            };
          };
        };
        defaultPackage = packages.xiasl;
      }
    );
}
