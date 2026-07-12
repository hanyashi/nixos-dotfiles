{ config, pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = false;
  services.desktopManager.plasma6.enable = true;
  services.xserver.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*"; 
  }; 

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL glib libx11 libxext libxkbcommon fontconfig freetype
    xorg.libxcb xorg.xcbutil xorg.xcbutilwm xorg.xcbutilimage
    xorg.xcbutilkeysyms xorg.xcbutilrenderutil xorg.libSM xorg.libICE
  ];

  environment.systemPackages = with pkgs; [
    firefox discord rofi discord-ptb obs-studio vscode scrcpy
    vlc spotify imagemagick lmms unrar unzip droidcam
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole kate gwenview okular elisa
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  boot.kernelModules = [ "v4l2loopback" ];

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  security.polkit.enable = true;
}