# My Git Prompt
===============

## Screenshots

### Dark Terminal
![On black background terminal](https://s4.postimg.org/l03flsrel/dark.png)
### Light Terminal
![On white background terminal](https://s4.postimg.org/b42cm5lml/light.png)

## Introduction
  This is a script to show nice symbols when you're inside your local git directory. It is similar to what [Oh-My-Git](https://github.com/arialdomartini/oh-my-git.git) and [Prezto Powerline Prompt](https://github.com/davidjrice/prezto_powerline) do, but the only difference is you don't need to have powerline and the patched fonts to show this prompt. This project is still **WIP** and I will keep improving it.

## Installation
  To install, you simply just git clone this repository into wherever you want, into your ~/.my-git-prompt if you want to follow my instruction below.
```
git clone https://github.com/budimanjojo/my-git-prompt.git ~/.my-git-prompt
```
After that, and add this line to your .zshrc:
```
source /home/username/.my-git-prompt/git-prompt.zsh
```
**NOTE:**
- You can see that I'm using /home/username/ instead of just $HOME or ~/. Well, because I symlinked my .zshrc to my /root folder so that my root account can also get the same configuration. You can just modify it to whatever you feel like.
- Don't forget to disable your current PROMPT= or RPROMPT= or PS1= etc by simply comment it out (putting a # in front of the line) if you want to use this PROMPT.
  Enjoy. :)

## Customization
  To customize, simply edit the ~/my-zsh/git-prompt.zsh. Colors, symbols, and text can be easily modified by editing these lines in that file:
```
#_background_color="%{$bg[white]%}"
_branch_name_prefix_symbol="%{$fg[yellow]%}["
_branch_name_suffix_symbol="%{$fg[yellow]%}]"
_has_modifications_symbol="%{$fg[red]%}✎  " 
_has_modifications_cached_symbol="%{$fg[green]%}✍  "
_has_adds_symbol="%{$fg[green]%}✚  "
_has_deletions_symbol="%{$fg[red]%}✖  "
_has_deletions_cached_symbol="%{$fg[green]%}▬  "
_ready_to_commit_symbol="%{$fg[green]%}☻   "
_has_untracked_files_symbol="%{$fg[red]%}✭  "
_is_clean_symbol="%{$fg[green]%}✔ "
_is_dirty_symbol="%{$fg[red]%}✘ "
# colors
_commits_ahead_color="%{$fg[green]%}"
_commits_behind_color="%{$fg[green]%}"
_date_color="%{$fg[green]%}"
```

## Future Plan
  There are some things that I will work add in the future, or my to do list to be exact:
- [ ] Make an install script to automatically install this for you
- [ ] Simplify the way to modify the color
- [ ] Easier customization option, especially the right prompt when not in git mode (currently only showing date)
- [ ] Some statuses like detached head etc are not yet supported and is not priority, I prefer it simple :)

Thanks guys
