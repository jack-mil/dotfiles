# Dotfiles #
A very messy collection of configuration files for my Linux environments

Somewhat outdated configs for Arch Linux.

Managed by GNU [`stow`](https://www.gnu.org/software/stow/). May be extended to other devices/distros if I ever upgrade.  
Mostly for backup/sync purposes  

## Installing 
`stow` makes it easy to organize by application / topic. Each top level directory (eg, 'nvim') contains all necessary the config files relative to `$HOME`. Installing is as easy as:
```
~ $> git clone https://github.com/jack-mil/dotfiles  
~ $> cd dotfiles/  
~/dotfiles $> stow [nvim | git | fish | neofetch | etc...]  
```

All files will be symlinked to to correct locations, leaving the actual files here, nicely organized.
