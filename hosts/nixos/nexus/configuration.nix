{ config, pkgs, ... }:

let
  inherit (import ./settings.nix) host username keyboardLayout;
in
{
  imports = [
    ./hardware-configuration.nix
    ./users.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/audio.nix
    ../../modules/hardware/usb.nix
    ../../modules/core/boot.nix
    ../../modules/services/dbus.nix
    ../../modules/services/misc.nix
    ../../modules/services/ratbagd.nix
    ../../modules/services/ssh.nix
    ../../modules/services/tailscale.nix
    ../../modules/services/gnome-keyring.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/wayland.nix
    ../../modules/styles/stylix.nix
    ../../home/apps/steam.nix
  ];

  networking.hostName = host;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  # ========== #

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  # ======== #

  # ============== #
  # X11/Xorg stuff #
  # ============== #
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # TODO: make it switchable via user setttings
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = keyboardLayout;
    variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
 
  # ============== #

  environment.shells = with pkgs; [ zsh bash ];
  # Default Shell
  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;
  programs.thunar.enable = true;
  # programs.hyprland.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # nix stuff

    # hardware related
    pciutils # for things like lspci
    usbutils
    lshw
    ncdu
    bluez
    bluez-tools
    # bluez-alsa

    # mouse tools
    # evhz
    piper

    # gaming
    lutris

    # monitoring
    powertop
    btop

    # essential system packages
    # applications
    vim
    wget
    git
    tree
    # autorandr
    ripgrep
    zsh
    neofetch
    # dolphin
    # thunar
    # apps
    inkscape
    gimp
    mplayer
    trash-cli
    # xclip
    nurl

    # user packages
    firefox
    obsidian
    yazi
    tldr
    bat
    spotify
    yq
    jq
    ffmpeg
    nh
    fd
    glow
    # fzf
    # atuin
    lazygit

    # languages
    # required for neovim
    # neovide
    gcc
    clang
    go
    python3
    libGL
    nodejs
    pnpm
    rustup
    cargo
    unzip
    gnumake
    # nvm
    # python
    # pyenv


    # C related
    # gmp gmp.dev
    # isl
    # libffi libffi.dev
    # libmpc
    # libxcrypt
    # mpfr mpfr.dev
    # xz xz.dev
    # zlib zlib.dev
    # stdenv.cc
    # stdenv.cc.libc stdenv.cc.libc_dev
    # libGL
    # xorg.libX11
    # xorg.xorgproto
  ];

  system.stateVersion = "24.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
