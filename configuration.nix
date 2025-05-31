# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

   environment.systemPackages = with pkgs; [
     # essentials
     vim
     neovim
     wget
     flatpak
     curl
     wget
     git
     fastfetch
     neofetch
     openvpn
     bat
     eza
     fzf
     playerctl
     openssl_3
     openssh
     p7zip
     inetutils
     dig
     gimp
     tmux
     zsh
     ffmpeg
     imagemagick
     strace
     ltrace
     htop
     vlc
     networkmanagerapplet
     gnome-keyring
     libsecret
     kdePackages.signon-kwallet-extension
     file
     wgnord
     wireguard-tools
     flameshot
     grim
     zip
     unzip
     gnome-keyring
     git
     pomodoro
     pass
     grimblast
     xbrightness
     xrdp
     remmina
     netcat
     zoxide
     btop
     pkg-config     
     docker-compose
     bat
     dust
     tokei
     
     hyprpanel
     wl-clipboard
     dart-sass
     gtksourceview3
     libgtop

     # audio and bluetooth
     blueman
     bluez

     #math and school
     sage
     typst

     # dotfiles
     kitty
     alacritty
     #ghostty
     waybar
     dunst
     hyprpaper
     wofi
     rofi
     stow
     hyprcursor
     wlogout
     swaylock

     # themes
     starship
     nerdfonts
     adwaita-icon-theme

     # text
     obsidian
     vscode
     libreoffice-qt6-fresh
     zed-editor

     # browsers
     firefox
     librewolf
     chromium
     
     # vm
     virt-manager
     virt-viewer
     spice 
     spice-gtk
     spice-protocol
     win-virtio
     win-spice
     
     # development tools
     github-desktop
     rustup
     cargo
     python39
     clang
     rustc
     clippy
     rustfmt
     hugo
     wasm-bindgen-cli
     wasm-pack
     python313Packages.pip
     
     godot_4

     # hackertools
     nmap
     rustscan
     gobuster
     exiftool
     netexec
     ffuf
     metasploit
     exploitdb
     burpsuite
     hashcat
     hashcat-utils
     john
     aircrack-ng
     wireshark

     # applications
     spotify
     discord
     bitwarden
     telegram-desktop
  ];

  services.gnome.gnome-keyring.enable = true;
  services.flatpak.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boo
  services.blueman.enable = true;

  programs.hyprland.enable = true; # enable Hyprland

  virtualisation.docker = {
    enable = true;

  };

  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  #virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.openssh.enable = true;
  # Enable sound with pipewire.

  security.rtkit.enable = true;




  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hector = {
    isNormalUser = true;
    description = "hector";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  services.ollama = {
    enable = true;
  };

  services.open-webui.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  programs.dconf.enable = true;
 
 programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/user/my-nixos-config";
  };
  
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

 


  system.stateVersion = "24.05"; # Did you read the comment?

}

