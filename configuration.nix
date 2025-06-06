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
     bat
     eza
     fzf
     tmux
     zsh
     htop
     file
     git
     dig
     ffmpeg
     strace
     ltrace
     vlc
     fastfetch
     flameshot
     grim
     nitch
     usbutils
     grimblast
     remmina        #rdp
     xrdp           #rdp
     btop

     p7zip
     zip
     unzip

     # Network tools
     openvpn
     playerctl
     openssl_3
     openssh
     inetutils
     networkmanagerapplet
     wireguard-tools
     netcat

     # password keyring tools
     gnome-keyring
     libsecret
     kdePackages.signon-kwallet-extension
     wgnord
     gnome-keyring
     pomodoro
     pass
     xbrightness

     # creative software
     blender
     kdenlive
     gimp
     imagemagick
     godot_4

     # audio and bluetooth
     blueman
     bluez

     #math and school
     sage
     typst

     # dotfiles
     kitty
     alacritty
     waybar
     dunst
     hyprpaper
     wofi
     rofi
     stow
     hyprcursor
     wlogout
     swaylock
     zoxide
     yazi
     bat
     dust
     tokei
     hyprpanel
     wl-clipboard
     dart-sass
     gtksourceview3
     libgtop

     # themes
     starship
     nerdfonts
     adwaita-icon-theme

     # text
     obsidian
     vscode
     libreoffice-qt6-fresh
     zed-editor

     # browsers zen browser as a flake
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
     pkg-config     
     docker-compose
     nodejs
     pnpm

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
  programs.zsh.enable = true;

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
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  #programs.zsh = {
   # enableCompletion = true;
    #autosuggestion.enable = true;
    #syntaxHighlighting.enable = true;
  #};

  users.users.hector = {
    isNormalUser = true;
    description = "hector";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];

  };
  
  environment.shellInit = ''
    eval "$(starship init zsh)"
    eval "$(zoxide init zsh)"
    nitch

    fzf_cd() {
      local dir
      dir=$(find . -type d 2>/dev/null | fzf --preview 'ls -la {}' --preview-window=up:40%:wrap --border --header="Select a directory to cd") && cd "$dir"
    }

    function y() {
	    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	    yazi "$@" --cwd-file="$tmp"
	    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		    builtin cd -- "$cwd"
	    fi
	    rm -f -- "$tmp"
    }

    alias rcedit="sudo nvim ~/.bashrc"
    alias rebuild="sudo nixos-rebuild switch --flake ~/.dotfiles"
    alias dot="cd ~/.dotfiles"
    alias conf="cd ~/.config/"
    alias nixedit="nvim ~/.dotfiles/configuration.nix"
    alias h="cd ~/"
    alias s="source ~/.zshrc"
    alias l="eza -l"
    alias tree="eza -T --icons"
    alias ..="cd .."
    alias zed="zeditor"
    alias source="source ~/.zshrc"
    alias rst="cd ~/Programming/rust"
    alias cd="z"
    alias ff="nitch"
    alias lconf="ls -al ~/.config/"
    alias gc="git commit . -m 'Updated'"
    alias gf="git fetch"
    alias gps="git push"
    alias gpl="git pull"
    alias tn="tmux new-session -s"
    alias tl="tmux list-sessions"
    alias ta="tmux attach-session"
    alias fcd="fzf_cd"


  '';

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

