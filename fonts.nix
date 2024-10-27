{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerdfonts

    fira-code
    fira-code-symbols

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    dina-font
    # Collision at last build
    #proggyfonts
    liberation_ttf
    mplus-outline-fonts.githubRelease
  ];
}
