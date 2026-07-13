{ config, pkgs, ... }:

let
  customBibata = pkgs.stdenv.mkDerivation {
    name = "bibata-modern-darkred";
    src = ./Bibata-Modern-DarkRed; 
    
    dontUnpack = true;
    dontBuild = true;
    
    installPhase = ''
      mkdir -p $out/share/icons/Bibata-Modern-DarkRed
      cp -R $src/* $out/share/icons/Bibata-Modern-DarkRed/
    '';
  };
in
{
  home.username = "hanyashi";
  home.homeDirectory = "/home/hanyashi";
  home.stateVersion = "25.11";
  
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "rm ~/.gtkrc-2.0.backup && sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
    };
  };

  home.packages = with pkgs; [
    bat
    grimblast
    slurp
    grim
    wl-clipboard
    brightnessctl
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = customBibata;
    name = "Bibata-Modern-DarkRed";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;

    gtk4.theme = null;
  };

  qt = {
    enable = false;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}