# Custom aliases

## Control cd command behavior aliases
- `alias ..='cd ..'`
- `alias ...='cd ../../'`
- `alias ....='cd ../../../'`
- `alias .....='cd ../../../../'`
- `alias .1='cd ..'`
- `alias .2='cd ../../'`
- `alias .3='cd ../../../'`
- `alias .4='cd ../../../../'`
- `alias .5='cd ../../../../../'`

## Shorcut Aliases
- `alias cls='clear'  # clear the terminal screen`
- `alias h='history'`
- `alias j='jobs -l'`
- `alias clip='clip.exe' # Copy to clipboard`
- `alias copy='clip.exe' # Copy to clipboard`

## System Aliases
- `alias path='echo $PATH'`
- `alias reload='source ~/.bashrc'`
- `alias reload='source ~/.zshrc'` # for zsh

## Update Debian Linux server Aliases
- `alias update='sudo apt-get update && sudo apt-get upgrade' # update on one command`

## Vim aliases
- `alias vi=vim`
- `alias svi='sudo vi'`
- `alias vis='vim "+set si"'`
- `alias edit='vim'`

## Git Aliases
- `alias gs='git status'`
- `alias ga='git add'`
- `alias gco='git commit -m'`
- `alias gch='git checkout'`
- `alias gb='git branch'`
- `alias gpl='git pull'`
- `alias gph='git push'`

## Browser
- `alias edge='/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'`

# Add aliases and apply them immediately

To add a new alias, you can define it in the `.bashrc` file and then apply the changes by running `source ~/.bashrc` or `. ~/.bashrc`. This will make the new alias available in the current shell session.

Alternatively, you can define an alias directly in the terminal session by using the `alias` command followed by the alias definition. For example:

```bash
alias ll='ls -alF'
```

You also can create a .bash_aliases file in your home directory and add your custom aliases there. Then, include the following line in your `.bashrc` file to load the `.bash_aliases` file:

```bash
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```

This will automatically load your custom aliases from the `.bash_aliases` file when you start a new shell session

## File content copy bash_aliases
```bash
# Custom aliases

# Control cd command behavior aliases
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .1='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

# Shorcut Aliases
alias cls='clear'  # clear the terminal screen
alias h='history'
alias j='jobs -l'
alias clip='clip.exe' # Copy to clipboard
alias copy='clip.exe' # Copy to clipboard
alias lsa='ls -al'

# System Aliases
alias path='echo $PATH'
alias reload='source ~/.bashrc'

# Update Debian Linux server Aliases
alias update='sudo apt-get update && sudo apt-get upgrade' # update on one command

# Vim aliases
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gco='git commit -m'
alias gch='git checkout'
alias gb='git branch'
alias gpl='git pull'
alias gph='git push'

# Python Aliases
alias py=python
alias py3=python3

# Browser
alias edge='/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'
```

## File content copy zsh_aliases
```bash
# Custom aliases

# Control cd command behavior aliases
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .1='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

# Shorcut Aliases
alias cls='clear'  # clear the terminal screen
alias h='history'
alias j='jobs -l'
alias clip='clip.exe' # Copy to clipboard
alias copy='clip.exe' # Copy to clipboard
alias lsa='ls -al'

# System Aliases
alias path='echo $PATH'
alias reload='source ~/.zshrc'

# Update Debian Linux server Aliases
alias update='sudo apt-get update && sudo apt-get upgrade' # update on one command

# Vim aliases
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gco='git commit -m'
alias gch='git checkout'
alias gb='git branch'
alias gpl='git pull'
alias gph='git push'

# Python Aliases
alias py=python
alias py3=python3

# Browser
alias edge='/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'
```
