# Customizing the Linux Terminal

## Table of Contents

- [Introduction](#introduction)
- [Installing Zsh](#installing-zsh)
  - [Zsh Themes](#zsh-themes)
    - [Murilasso](#murilasso)
    - [Pure](#pure)
- [Custom aliases](#custom-aliases)
  - [Control cd command behavior aliases](#control-cd-command-behavior-aliases)
  - [Shorcut Aliases](#shorcut-aliases)
  - [System Aliases](#system-aliases)
  - [Update Debian Linux server Aliases](#update-debian-linux-server-aliases)
  - [Vim aliases](#vim-aliases)
  - [Git Aliases](#git-aliases)
  - [Browser](#browser)
- [Add aliases and apply them immediately](#add-aliases-and-apply-them-immediately)
- [File content copy bash_aliases](#file-content-copy-bash_aliases)
- [File content copy zsh_aliases](#file-content-copy-zsh_aliases)
- [Plugins](#plugins)
  - [List of plugins](#list-of-plugins)

## Introduction

The terminal is a powerful tool that allows you to interact with your computer using text commands. By customizing the terminal, you can make it more efficient and enjoyable to use. In this guide, we will cover some common ways to customize the terminal, including changing the prompt, adding aliases, and installing plugins.

## Zsh

Zsh is a powerful shell that provides many features and customization options. To install Zsh on your system, you can use the package manager that comes with your distribution. For example, on Debian-based systems, you can install Zsh using the following command:

### Installing Zsh
1. Install Zsh on Debian-based systems
```bash
sudo apt update && sudo apt install zsh
```
- This step is optional but recommended. Install Oh My Zsh to get a lot of features and themes.
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
2. Change the default shell to Zsh (optional)
```bash
sudo chsh -s $(which zsh)
```
3. Configure Bash to start zsh to avoid problems. Add the following line to the `~/.bashrc` file
```bash
if [ -t 1 ]; then
    exec zsh
fi
```
```bash
# Command to add lines to file:
echo 'if [ -t 1 ]; then' >> ~/.bashrc && echo '    exec zsh' >> ~/.bashrc && echo 'fi' >> ~/.bashrc
```
4. Add configuration to the `.zshrc` file. I recommend using the following configuration and have vim already installed.
```bash

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Custom Aliases
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

export EDITOR=vim
export VISUAL=vim

# Terminal Customization

```
```bash
# Command to add lines to file:
echo '' >> ~/.zshrc && echo 'if [ -x /usr/bin/dircolors ]; then' >> ~/.zshrc && echo '    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"' >> ~/.zshrc && echo '    alias ls='ls --color=auto'' >> ~/.zshrc && echo '    #alias dir='dir --color=auto'' >> ~/.zshrc && echo '    #alias vdir='vdir --color=auto'' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '    alias grep='grep --color=auto'' >> ~/.zshrc && echo '    alias fgrep='fgrep --color=auto'' >> ~/.zshrc && echo '    alias egrep='egrep --color=auto'' >> ~/.zshrc && echo 'fi' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '# some more ls aliases' >> ~/.zshrc && echo 'alias ll='ls -alF'' >> ~/.zshrc && echo 'alias la='ls -A'' >> ~/.zshrc && echo 'alias l='ls -CF'' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '# Custom Aliases' >> ~/.zshrc && echo '' >> ~/.zshrc && echo 'if [ -f ~/.zsh_aliases ]; then' >> ~/.zshrc && echo '    . ~/.zsh_aliases' >> ~/.zshrc && echo 'fi' >> ~/.zshrc && echo '' >> ~/.zshrc && echo 'export EDITOR=vim' >> ~/.zshrc && echo 'export VISUAL=vim' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '# Terminal Customization' >> ~/.zshrc && echo '' >> ~/.zshrc
```


### Zsh Themes
Zsh comes with a variety of themes that you can use to customize the appearance of your terminal. To change the theme, you can set the `ZSH_THEME` variable in your `.zshrc` file. 

#### Tjkirch

In the `.zshrc` file change the `ZSH_THEME` variable for `tjkirch`.

#### Powerlevel10k

1. Install the Powerlevel10k theme.
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
2. Set the `ZSH_THEME` variable to `powerlevel10k/powerlevel10k` in the `.zshrc` file.
3. Run the following command to configure the Powerlevel10k theme.
```bash
p10k configure
```
4. Reload the terminal to apply the changes.
```bash
source ~/.zshrc
```

##### Personal Recommendations

###### Prompt Style
- Classic

###### Character Set
- Unicode

###### Prompt Color
- Dark

###### Show current time?
- 12-hour format

###### Prompt Separators
- Vertical

###### Prompt Heads
- Sharp

###### Prompt Tails
- Round

###### Prompt Height
- Two lines

###### Prompt Connection
- Disconnected

###### Prompt Frame
- No frame

###### Prompt Spacing
- Sparse

###### Prompt Flow
- Concise

###### Prompt Icons
- Many icons

###### Enable Transient Prompt?
- No

## Custom aliases

### Consideration

Before adding custom aliases, I recommend installing colorls to have a better visualization of the files and directories.

#### Install colorls
1. Install Ruby
```bash
sudo apt update && sudo apt install ruby-full -y
```
2. Install colorls
```bash
sudo gem install colorls
```
3. Verify the installation
```bash
colorls --version
```

### Control cd command behavior aliases
- `alias ..='cd ..'`
- `alias ...='cd ../../'`
- `alias ....='cd ../../../'`
- `alias .....='cd ../../../../'`
- `alias .1='cd ..'`
- `alias .2='cd ../../'`
- `alias .3='cd ../../../'`
- `alias .4='cd ../../../../'`
- `alias .5='cd ../../../../../'`

### Shorcut Aliases
- `alias cls='clear'  # clear the terminal screen`
- `alias h='history'`
- `alias j='jobs -l'`
- `alias clip='clip.exe' # Copy to clipboard`
- `alias copy='clip.exe' # Copy to clipboard`
- `alias lsa='colorls -al'`

### System Aliases
- `alias path='echo $PATH'`
- `alias reload='source ~/.bashrc'`
- `alias reload='source ~/.zshrc'` # for zsh

### Update Debian Linux server Aliases
- `alias update='sudo apt-get update && sudo apt-get upgrade' # update on one command`

### Executable Aliases
- `alias mount_drives='~/.drives/mount_drives.sh'`
- `alias umount_drives='~/.drives/umount_drives.sh'`

### Vim aliases
- `alias vi=vim`
- `alias svi='sudo vi'`
- `alias vis='vim "+set si"'`
- `alias edit='vim'`

### Git Aliases
- `alias gs='git status'`
- `alias ga='git add'`
- `alias gco='git commit -m'`
- `alias gch='git checkout'`
- `alias gb='git branch'`
- `alias gpl='git pull'`
- `alias gph='git push'`

### Browser
- `alias edge='/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'`

## Add aliases and apply them immediately

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
alias lsa='colorls -al'

# System Aliases
alias path='echo $PATH'
alias reload='source ~/.bashrc'

# Update Debian Linux server Aliases
alias update='sudo apt-get update && sudo apt-get upgrade' # update on one command

# Executable Aliases
alias mount_drives='~/.drives/mount_drives.sh'
alias umount_drives='~/.drives/umount_drives.sh'

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
alias lsa='colorls -al'

# System Aliases
alias path='echo $PATH'
alias reload='source ~/.zshrc'

# Update Debian Linux server Aliases
alias update='sudo apt-get update && sudo apt-get upgrade' # update on one command

# Executable Aliases
alias mount_drives='~/.drives/mount_drives.sh'
alias umount_drives='~/.drives/umount_drives.sh'

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

## Plugins

### List of plugins
- [zsh-autosuggestions](#zsh-autosuggestions)
- [zsh-syntax-highlighting](#zsh-syntax-highlighting)

### zsh-autosuggestions

Plugin to autocomplete commands based on the history of the terminal.
1. Clone the repository.
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```
2. Add the plugin in the `.zshrc` file.
```bash
plugins=(... zsh-autosuggestions)
```

### zsh-syntax-highlighting

Plugin to highlight written commands in green for existing commands and red for non-existent commands.

1. Clone the repository.
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```
2. Add the plugin in the `.zshrc` file.
```bash
plugins=(... zsh-syntax-highlighting)
```

### Fzf

1. Install Fzf.
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
```
2. Add the plugin in the `.zshrc` file. Add the following line to the `.zshrc` file.
```bash
## Enable fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Use fuzzy completion for Zsh history
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
```
```bash
# Command to add lines to file:
echo '## Enable fuzzy completion' >> ~/.zshrc && echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '## Use fuzzy completion for Zsh history' >> ~/.zshrc && echo "bindkey '^[[A' history-beginning-search-backward" >> ~/.zshrc && echo "bindkey '^[[B' history-beginning-search-forward" >> ~/.zshrc
```


