# dotfiles
dotfiles used on RPI4

My dotfiles for Rasbian, managed by GNU [`stow`](https://www.gnu.org/software/stow/). May be extended to other devices/distros if I ever upgrade.  
More packages to come  

## Installing 
`stow` makes it easy to organize by application / topic. Each top level directory (eg, 'nvim') contains all necessary the config files relative to `$HOME`. Installing is as easy as:
```
~ $> git clone https://github.com/jack-mil/dotfiles  
~ $> cd dotfiles/  
~/dotfiles $> stow [nvim | git | fish | neofetch | etc...]  
```

All files will be symlinked to to correct locations, leaving the actual files here, nicely organized.
