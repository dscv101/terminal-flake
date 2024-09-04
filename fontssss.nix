{
  inputs = {};

  outputs = _: {
    home-manager-module = {pkgs, ...}: {
      fonts.fontconfig.enable = true;

      home.packages = [
        # Quite Large
        pkgs.nerdfonts

        # Open source emoji set
        #pkgs.emojione

        pkgs.noto-fonts
        pkgs.noto-fonts-cjk
        pkgs.noto-fonts-emoji

        pkgs.fira-code
        pkgs.fira-code-symbols

        pkgs.liberation_ttf
        pkgs.mplus-outline-fonts.githubRelease
        pkgs.dina-font
      ];
    };
  };
}
