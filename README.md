# Dotfiles #
### Dotfiles used on Arch Linux ###

My dotfiles for Arch, managed by GNU [`stow`](https://www.gnu.org/software/stow/). May be extended to other devices/distros if I ever upgrade.  
Mostly for backup/sync purposes  
More packages to come  

## Installing 
`stow` makes it easy to organize by application / topic. Each top level directory (eg, 'nvim') contains all necessary the config files relative to `$HOME`. Installing is as easy as:
```
~ $> git clone https://github.com/jack-mil/dotfiles  
~ $> cd dotfiles/  
~/dotfiles $> stow [nvim | git | fish | neofetch | etc...]  
```

All files will be symlinked to to correct locations, leaving the actual files here, nicely organized.

Stow includes a `--dotfiles` option that converts files with a `'dot-'` prefix to `(.)`. e.g. `dot-basrch` -> `.bashrc`. However a longstanding bug prevents this feature from working with directories like `.config`. I used [this patch](https://aur.archlinux.org/packages/stow-dotfiles-git/) to resolve this. The stow package has been unmaintained for some time. 

An alternative is to use [fling](https://github.com/bbkane/fling) which works well. It is not yet available on the AUR however.
