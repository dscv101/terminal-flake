{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Useful CLI programs
    cli.url = "github:xvrqt/cli-flake";
    neovim.url = "/home/xvrqt/dev/neovim-flake";
    #neovim.url = "github:xvrqt/neovim-flake";
  };

  outputs = {
    cli,
    neovim,
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
            # Extremely customized NeoVim
            neovim.homeManagerModules.${system}.default
            # List of useful fonts
            (import ./fonts.nix {inherit pkgs;})
          ];

          # Enable our terminal emulator
          programs.alacritty = {
            enable = true;
            settings = {
              import = ["/home/amy/.config/alacritty/theme.toml"];
              shell.args = ["--login"];
              shell.program = "${pkgs.zsh}/bin/zsh";
            };
          };

          # Configure and style Alacritty
          home = {
            file = {
              ".config/alacritty/theme.yml".source = ./themes/catppuccin-mocha.yml;
            };
          };
        };

        # I want it all (by default)
        default = homeManagerModules.maximal;
      };
    });
}
