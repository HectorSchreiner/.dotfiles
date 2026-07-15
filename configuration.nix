{ config, pkgs,  ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./modules/common-packages.nix
    ];

   environment.systemPackages = with pkgs; [
     # ai
     lmstudio

     # applications
     discord
     obs-studio
     pomodoro
     signal-desktop
     spotify
     telegram-desktop
     zathura

     # archives
     p7zip
     unzip
     zip

     # audio & bluetooth
     blueman
     bluez
     playerctl

     # browsers
     chromium
     firefox
     librewolf
     tor-browser

     # creative
     #blender
     #gimp
     #godot_4
     #imagemagick
     #kdenlive
     ffmpeg
     flameshot
     grim
     grimblast
     slurp
     swappy
     vlc

     # desktop & dotfiles
     alacritty
     dunst
     hyprcursor
     hyprlauncher
     hyprlock
     hyprpanel
     hyprpaper
     kitty
     rofi
     stow
     swaybg
     swaylock
     waybar
     wl-clipboard
     wlogout
     wofi
     xdotool

     # development
     binutils
     cargo
     clang
     clang-tools
     clippy
     cmake
     conda
     dart-sass
     direnv
     gcc
     gdb
     github-desktop
     gnumake
     gtkwave
     lld_20
     llvmPackages.bintools
     lua
     nil
     nixd
     nodejs
     openfpgaloader
     openjfx21
     pkg-config
     pnpm
     prettier
     python313
     rust-analyzer
     rustc
     rustfmt
     rustup
     sbt
     scenebuilder
     sqlite
     tokei
     urjtag
     uv
     wasm-bindgen-cli
     wasm-pack
     zulu

     # drone
     mono
     qgroundcontrol

     # essentials
     bat
     btop
     curl
     dig
     dust
     eza
     fastfetch
     file
     flatpak
     fzf
     git
     htop
     ltrace
     nitch
     os-prober
     strace
     tmux
     usbutils
     wget
     yazi
     zoxide
     zsh

     # hacker
     #aircrack-ng
     burpsuite
     #exploitdb
     exiftool
     #ffuf
     gobuster
     hashcat
     hashcat-utils
     john
     metasploit
     #netexec
     nmap
     rustscan
     wireshark
     zeek

     # hardware & system
     atkmm
     brightnessctl
     cairo
     freeglut
     gdk-pixbuf
     glib
     gobject-introspection
     gtk3
     gtksourceview3
     libgtop
     libiconv
     libsoup_3
     libxkbcommon
     pango
     solaar
     webkitgtk_4_1

     # math & school
     marp-cli
     sage

     # network
     inetutils
     netcat
     networkmanagerapplet
     openssh
     openssl_3
     openvpn
     remmina
     wgnord
     mullvad-vpn
     wireguard-tools
     wireguard-ui
     xrdp

     # password & keyring
     bitwarden-desktop
     gnome-keyring
     kdePackages.signon-kwallet-extension
     libsecret
     pass

     # text & editors
     libreoffice-qt6-fresh
     neovim
     obsidian
     onlyoffice-desktopeditors
     thunderbird
     typst
     vim
     vscode
     zed-editor

     # themes
     adwaita-icon-theme
     starship

     # virtualisation & containers
     distrobox
     docker-compose
     spice
     spice-gtk
     spice-protocol
     virt-manager
     virt-viewer
     virtio-win
     win-spice
   ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      pkgs.nerd-fonts.jetbrains-mono
    ];
  };

  services.udev.packages = with pkgs; [ 
    openfpgaloader 
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    glib
  ];


  programs.steam.enable = true;
  hardware.graphics.enable32Bit = true;

  services.gnome.gnome-keyring.enable = true;
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boo
  services.blueman.enable = true;

  programs.hyprland.enable = true; # enable Hyprland

  programs.zoxide.enableBashIntegration= true;

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

  services.displayManager.ly = {
  enable = true;
  settings = {
    # hide_borders = true;
    save = true;
    load = true;
  };
};

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 5432 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "no";
      AllowUsers = [ "hector" ];
    };
  };

  services.fail2ban.enable = true;

  services.fprintd.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  services.endlessh = {
    enable = true;
    port = 22;
    openFirewall = false;
  };
  # Enable sound with pipewire.

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.hector = {
    isNormalUser = true;
    description = "hector";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "wireshark" "docker" "plugdev" "dialout"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  # wireshark fix
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
  };
  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };

  programs.bash = {
  interactiveShellInit = ''
    eval "$(starship init bash)"
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

    function nnix() {
      cd ~/.dotfiles
      nvim ~/.dotfiles/configuration.nix
      git add .
      git commit
      git push
    }

    eval "$(direnv hook bash)"

    alias nordvpn-albania="sudo openvpn --config ~/secrets/albania-nordvpn-conf.ovpn --auth-user-pass ~/secrets/nord-creds.txt"
    alias nordvpn-denmark="sudo openvpn --config ~/secrets/denmark-nordvpn-conf.ovpn --auth-user-pass ~/secrets/nord-creds.txt"
    alias rcedit="sudo nvim ~/.bashrc"
    alias rebuild="sudo nixos-rebuild switch --flake ~/.dotfiles"
    alias gpp="g++ -std=c++23"
    alias dot="cd ~/.dotfiles"
    alias conf="cd ~/.config/"
    alias nixedit="nvim ~/.dotfiles/configuration.nix"
    alias h="cd ~/"
    alias l="eza -l"
    alias tree="eza -T --icons"
    alias ..="cd .."
    alias zed="zeditor"
    alias rst="cd ~/Programming/rust"
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
    alias dx="/home/hector/.cargo/bin/dx"
  '';
  };

  programs.firefox.enable = true;

  services.ollama = {
    enable = true;
  };

  services.open-webui.enable = true;

  programs.dconf.enable = true;
  #hardware.graphics.enable = true;
 
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
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

}

