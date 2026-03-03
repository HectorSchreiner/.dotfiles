# GruvBox Themed Dotfiles
These are my Gruvbox dotfiles for nixos. 
![Gruvbox](screenshots/desktop.png)
![Gruvbox](screenshots/desktop_2.png)
![Gruvbox](screenshots/desktop_3.png)
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9815b905-96cc-4b7b-8436-33a1df8c84af" />


# Programs
- Hyprland
- Hyprpapr
- Hyprpanel
- Wofi
- Ghostty
- Tmux
- Neovim
- Zen-Browser

# Setup
```bash
git clone https://github.com/HectorSchreiner/.dotfiles
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
