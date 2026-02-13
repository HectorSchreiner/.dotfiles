{ config, pkgs,  ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./modules/common-packages.nix
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
     dig
     ffmpeg
     strace
     ltrace
     vlc
     fastfetch
     flameshot
     grim
     swappy
     slurp
     nitch
     usbutils
     grimblast
     remmina        #rdp
     xrdp           #rdp
     btop
     marp-cli
     gdb
     hyprlock
     hyprlauncher

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
     distrobox

     # password keyring tools
     gnome-keyring
     libsecret
     kdePackages.signon-kwallet-extension
     wgnord
     gnome-keyring
     pomodoro
     pass

     brightnessctl light
     # creative software
     #blender
     #kdenlive
     #gimp
     #imagemagick
     #godot_4

     # drone configuration and drivers 
     qgroundcontrol
     mono

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
     tokei # get lines of code
     hyprpanel
     wl-clipboard
     dart-sass
     gtksourceview3
     webkitgtk_4_1
     libgtop
     pango
     os-prober
     gobject-introspection
     gtk3
     hyprpanel
     swaybg
     prettier

     # themes
     starship
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
     tor-browser
     
     # vm
     virt-manager
     virt-viewer
     spice 
     spice-gtk
     spice-protocol
     virtio-win
     win-spice
     
     # development tools
     github-desktop
     rustup
     lua
     cargo
     clang
     clang-tools
     cmake
     rustc
     clippy
     rustfmt
     wasm-bindgen-cli
     wasm-pack
     pkg-config     
     libxkbcommon
     docker-compose
     nodejs
     pnpm
     openjfx21
     zulu
     scenebuilder
     signal-desktop
     python313
     urjtag
     binutils
     gcc
     glib
     libsoup_3
     webkitgtk_4_1
     xdotool
     libiconv
     lld_20
     atkmm
     cairo
     sbt
     gtkwave
     gdk-pixbuf
     sqlite
     direnv

     # opengl-deps
     freeglut

     # hackertools
     nmap
     rustscan
     gobuster
     exiftool
     #netexec
     #ffuf
     metasploit
     #exploitdb
     burpsuite
     hashcat
     hashcat-utils
     john
     #aircrack-ng
     wireshark

     #  applications
     discord
     bitwarden-desktop
     telegram-desktop
     obs-studio
     spotify
     onlyoffice-desktopeditors
     thunderbird
     wireguard-ui
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      pkgs.nerd-fonts.jetbrains-mono
    ];
  };

  programs.steam.enable = true;
  hardware.graphics.enable32Bit = true;

  services.gnome.gnome-keyring.enable = true;
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];

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
    animation = "doom"; # Options: "doom", "matrix", or "off"
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
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "wireshark" "docker"];
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

