# Dotfiles
these are my dotfiles, for my Nixos Laptop

# Programs
- Hyprland
- Hyprpanel
- Wofi
- Hyprlock

# Setup
```bash
git clone https://github.com/HectorSchreiner/nixos_dotfiles/ ~/.dotfiles
rm ~/.dotfiles/hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ~/.dotfiles
sudo nixos-rebuild switch --flake ~/.dotfiles#nixos
```
