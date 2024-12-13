{
  description = "Previewer for markdown files";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = {
    self,
    nixpkgs,
    poetry2nix,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {system = system;};
    inherit (poetry2nix.lib.mkPoetry2Nix {inherit pkgs;}) mkPoetryApplication;
    app = mkPoetryApplication {projectDir = ./.;};
  in {
    formatter.${system}.default = pkgs.alejandra;

    defaultPackage.${system} = app;

    apps.${system}.default = {
      type = "app";
      # replace <script> with the name in the [tool.poetry.scripts] section of your pyproject.toml
      program = "${app}/bin/preview_markdown";
    };
  };
}
