{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Useful CLI programs
    cli.url = "github:xvrqt/cli-flake";
  };

  outputs = {
    cli,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in rec {
      homeManagerModules = {
        maximal = {
          imports = [
            # CLI Programs, Shell Configurations, Starship, ...
            cli.homeManagerModules.default
            # List of useful fonts
            (import ./fonts.nix {inherit pkgs;})
          ];

          # Enable our terminal emulator
          programs.alacritty = {
            enable = true;
          };

          # Configure and style Alacritty
          home = {
            file = {
              ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
              ".config/alacritty/theme.yml".source = ./themes/catppuccin-mocha.yml;
            };
          };
        };

        # I want it all (by default)
        default = homeManagerModules.maximal;
      };
    });
}
