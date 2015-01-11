# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "leviathan"; # Define your hostname.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    emacs
    vim
  ];

  nixpkgs.config.allowUnfree = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.videoDrivers = [ "vmware" "cirrus" "vesa" ];
  services.xserver.desktopManager.gnome3.enable = true;
  # services.xserver.windowManager.gnome3.enable = true;
  # services.xserver.windowManager.gnome3.enableContribAndExtras = true;
  # services.xserver.windowManager.default = "gnome3";
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.sessionCommands = ''
  # '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.guest = {
    name = "ian";
    group = "users";
    extraGroups = ["wheel"];
    uid = 1000;
    createHome = true;
    home = "/home/ian";
    shell = "/run/current-system/sw/bin/bash";
  };
}
