# GruvBox Themed Dotfiles
These are my Gruvbox dotfiles for nixos. 

# Showcase
Cool image of rice here...

# The configuraion uses the following programs
- Hyprland
- Hyprpapr
- Hyprpanel
- Hyprlock
- Wofi
- Ghostty
- Tmux
- Neovim
- Zen-Browser
- Nitch

# Setup
```bash
git clone https://github.com/HectorSchreiner/nixos_dotfiles/ ~/.dotfiles
rm ~/.dotfiles/hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ~/.dotfiles
sudo nixos-rebuild switch --flake ~/.dotfiles#nixos
```
I personally use Stow to manage my symlinks, you can use the following command, to link all the files to `~/.config`:
```bash
cd ~/.dotfiles/
stow nvim ghostty hypr hyprpanel wofi tmux
```

To remove the symlinks use:
```bash
cd ~/.dotfiles/
stow -D nvim ghostty hypr hyprpanel wofi tmux
```
