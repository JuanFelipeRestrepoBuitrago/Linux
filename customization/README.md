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

# Mount Drives
mount_drives

# Terminal Customization

```
```bash
# Command to add lines to file:
echo '' >> ~/.zshrc && echo 'if [ -x /usr/bin/dircolors ]; then' >> ~/.zshrc && echo '    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"' >> ~/.zshrc && echo '    alias ls='ls --color=auto'' >> ~/.zshrc && echo '    #alias dir='dir --color=auto'' >> ~/.zshrc && echo '    #alias vdir='vdir --color=auto'' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '    alias grep='grep --color=auto'' >> ~/.zshrc && echo '    alias fgrep='fgrep --color=auto'' >> ~/.zshrc && echo '    alias egrep='egrep --color=auto'' >> ~/.zshrc && echo 'fi' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '# some more ls aliases' >> ~/.zshrc && echo 'alias ll='ls -alF'' >> ~/.zshrc && echo 'alias la='ls -A'' >> ~/.zshrc && echo 'alias l='ls -CF'' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '# Custom Aliases' >> ~/.zshrc && echo 'if [ -f ~/.zsh_aliases ]; then' >> ~/.zshrc && echo '    . ~/.zsh_aliases' >> ~/.zshrc && echo 'fi' >> ~/.zshrc && echo '' >> ~/.zshrc && echo 'export EDITOR=vim' >> ~/.zshrc && echo 'export VISUAL=vim' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '# Mount Drives' >> ~/.zshrc && echo 'mount_drives' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '# Terminal Customization' >> ~/.zshrc && echo '' >> ~/.zshrc
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
3. Add the following lines to the `.zshrc` file to enable the Powerlevel10k theme.
```bash
# Theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```
```bash
# Command to add lines to file:
echo '# Theme' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.' >> ~/.zshrc && echo '# Initialization code that may require console input (password prompts, [y/n]' >> ~/.zshrc && echo '# confirmations, etc.) must go above this block; everything else may go below.' >> ~/.zshrc && echo 'if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then' >> ~/.zshrc && echo '  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"' >> ~/.zshrc && echo 'fi' >> ~/.zshrc && echo '' >> ~/.zshrc && echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >> ~/.zshrc && echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
```
4. Run the following command to configure the Powerlevel10k theme.
```bash
p10k configure
```
5. Reload the terminal to apply the changes.
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

#### Copy .drives folder

1. Create a folder called `.drives` in the home directory.
```bash
mkdir ~/.drives
```

2. Create a file called `mount_drives.sh` in the `.drives` folder.
```bash
touch ~/.drives/mount_drives.sh
```

3. Create a file called `umount_drives.sh` in the `.drives` folder.
```bash
touch ~/.drives/umount_drives.sh
```

4. Add the following content to the `mount_drives.sh` file.
```bash
#!/bin/bash

# Function to check if a drive is already mounted
is_mounted() {
    local MOUNT_POINT="$1"
    if mountpoint -q "$MOUNT_POINT"; then
        return 0  # Mounted
    else
        return 1  # Not mounted
    fi
}

# Function to mount a drive if it's not already mounted
mount_drive() {
    local DRIVE_LETTER="$1"
    local MOUNT_POINT="$2"
    local MOUNT_COMMAND="$3"

    if is_mounted "$MOUNT_POINT"; then
        echo "$DRIVE_LETTER is already mounted at $MOUNT_POINT."
    else
        if [ ! -d "$MOUNT_POINT" ]; then
            sudo mkdir -p "$MOUNT_POINT"
        fi

        # Execute the provided mount command
        eval "$MOUNT_COMMAND"
        echo "$DRIVE_LETTER mounted at $MOUNT_POINT."
    fi
}

# Function to unmount a drive if it's disconnected
unmount_drive() {
    local MOUNT_POINT="$1"

    if ! is_mounted "$MOUNT_POINT" && [ -d "$MOUNT_POINT" ]; then
        sudo umount "$MOUNT_POINT"
        sudo rmdir "$MOUNT_POINT"
        echo "$MOUNT_POINT is disconnected and removed."
    fi
}

# First drive
DRIVE_LETTER1="D:"
MOUNT_POINT1="/mnt/d"
MOUNT_COMMAND1="sudo mount -t drvfs $DRIVE_LETTER1 $MOUNT_POINT1"

# Second drive (replace with the appropriate command)
DRIVE_LETTER2="Z:"
MOUNT_POINT2="/mnt/z"
MOUNT_COMMAND2="sudo mount -t cifs //pipepi.ddns.net/Data $MOUNT_POINT2 -o username=pipepi,password=Santiagoa1a++"

# Mount the drives
mount_drive "$DRIVE_LETTER1" "$MOUNT_POINT1" "$MOUNT_COMMAND1"
mount_drive "$DRIVE_LETTER2" "$MOUNT_POINT2" "$MOUNT_COMMAND2"

# Unmount the drives if they are disconnected
unmount_drive "$MOUNT_POINT1"
unmount_drive "$MOUNT_POINT2"
```
```bash
# Command to add lines to file:
echo '#!/bin/bash' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '# Function to check if a drive is already mounted' >> ~/.drives/mount_drives.sh && echo 'is_mounted() {' >> ~/.drives/mount_drives.sh && echo '    local MOUNT_POINT="$1"' >> ~/.drives/mount_drives.sh && echo '    if mountpoint -q "$MOUNT_POINT"; then' >> ~/.drives/mount_drives.sh && echo '        return 0  # Mounted' >> ~/.drives/mount_drives.sh && echo '    else' >> ~/.drives/mount_drives.sh && echo '        return 1  # Not mounted' >> ~/.drives/mount_drives.sh && echo '    fi' >> ~/.drives/mount_drives.sh && echo '}' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '# Function to mount a drive if it'\''s not already mounted' >> ~/.drives/mount_drives.sh && echo 'mount_drive() {' >> ~/.drives/mount_drives.sh && echo '    local DRIVE_LETTER="$1"' >> ~/.drives/mount_drives.sh && echo '    local MOUNT_POINT="$2"' >> ~/.drives/mount_drives.sh && echo '    local MOUNT_COMMAND="$3"' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '    if is_mounted "$MOUNT_POINT"; then' >> ~/.drives/mount_drives.sh && echo '        echo "$DRIVE_LETTER is already mounted at $MOUNT_POINT."' >> ~/.drives/mount_drives.sh && echo '    else' >> ~/.drives/mount_drives.sh && echo '        if [ ! -d "$MOUNT_POINT" ]; then' >> ~/.drives/mount_drives.sh && echo '            sudo mkdir -p "$MOUNT_POINT"' >> ~/.drives/mount_drives.sh && echo '        fi' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '        # Execute the provided mount command' >> ~/.drives/mount_drives.sh && echo '        eval "$MOUNT_COMMAND"' >> ~/.drives/mount_drives.sh && echo '        echo "$DRIVE_LETTER mounted at $MOUNT_POINT."' >> ~/.drives/mount_drives.sh && echo '    fi' >> ~/.drives/mount_drives.sh && echo '}' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '# Function to unmount a drive if it'\''s disconnected' >> ~/.drives/mount_drives.sh && echo 'unmount_drive() {' >> ~/.drives/mount_drives.sh && echo '    local MOUNT_POINT="$1"' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '    if ! is_mounted "$MOUNT_POINT" && [ -d "$MOUNT_POINT" ]; then' >> ~/.drives/mount_drives.sh && echo '        sudo umount "$MOUNT_POINT"' >> ~/.drives/mount_drives.sh && echo '        sudo rmdir "$MOUNT_POINT"' >> ~/.drives/mount_drives.sh && echo '        echo "$MOUNT_POINT is disconnected and removed."' >> ~/.drives/mount_drives.sh && echo '    fi' >> ~/.drives/mount_drives.sh && echo '}' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '# First drive' >> ~/.drives/mount_drives.sh && echo 'DRIVE_LETTER1="D:"' >> ~/.drives/mount_drives.sh && echo 'MOUNT_POINT1="/mnt/d"' >> ~/.drives/mount_drives.sh && echo 'MOUNT_COMMAND1="sudo mount -t drvfs $DRIVE_LETTER1 $MOUNT_POINT1"' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '# Second drive (replace with the appropriate command)' >> ~/.drives/mount_drives.sh && echo 'DRIVE_LETTER2="Z:"' >> ~/.drives/mount_drives.sh && echo 'MOUNT_POINT2="/mnt/z"' >> ~/.drives/mount_drives.sh && echo 'MOUNT_COMMAND2="sudo mount -t cifs //pipepi.ddns.net/Data $MOUNT_POINT2 -o username=pipepi,password=Santiagoa1a++"' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '# Mount the drives' >> ~/.drives/mount_drives.sh && echo 'mount_drive "$DRIVE_LETTER1" "$MOUNT_POINT1" "$MOUNT_COMMAND1"' >> ~/.drives/mount_drives.sh && echo 'mount_drive "$DRIVE_LETTER2" "$MOUNT_POINT2" "$MOUNT_COMMAND2"' >> ~/.drives/mount_drives.sh && echo '' >> ~/.drives/mount_drives.sh && echo '# Unmount the drives if they are disconnected' >> ~/.drives/mount_drives.sh && echo 'unmount_drive "$MOUNT_POINT1"' >> ~/.drives/mount_drives.sh && echo 'unmount_drive "$MOUNT_POINT2"' >> ~/.drives/mount_drives.sh
```

5. Add the following content to the `umount_drives.sh` file.
```bash
#!/bin/bash

# Function to check if a drive is already mounted
is_mounted() {
    local MOUNT_POINT="$1"
    if mountpoint -q "$MOUNT_POINT"; then
        return 0  # Mounted
    else
        return 1  # Not mounted
    fi
}

umount_drive() {
    local MOUNT_POINT="$1"

    if is_mounted "$MOUNT_POINT"; then
        sudo umount "$MOUNT_POINT"
        echo "$MOUNT_POINT was disconnected."
    else 
        echo "$MOUNT_POINT was not mounted."
    fi
}

# First drive
MOUNT_POINT1="/mnt/d"

# Second drive
MOUNT_POINT2="/mnt/z"

# Unmount the drives if they are connected
umount_drive "$MOUNT_POINT1"
umount_drive "$MOUNT_POINT2"
```
```bash
# Command to add lines to file:
echo '#!/bin/bash' >> ~/.drives/umount_drives.sh && echo '' >> ~/.drives/umount_drives.sh && echo '# Function to check if a drive is already mounted' >> ~/.drives/umount_drives.sh && echo 'is_mounted() {' >> ~/.drives/umount_drives.sh && echo '    local MOUNT_POINT="$1"' >> ~/.drives/umount_drives.sh && echo '    if mountpoint -q "$MOUNT_POINT"; then' >> ~/.drives/umount_drives.sh && echo '        return 0  # Mounted' >> ~/.drives/umount_drives.sh && echo '    else' >> ~/.drives/umount_drives.sh && echo '        return 1  # Not mounted' >> ~/.drives/umount_drives.sh && echo '    fi' >> ~/.drives/umount_drives.sh && echo '}' >> ~/.drives/umount_drives.sh && echo '' >> ~/.drives/umount_drives.sh && echo 'umount_drive() {' >> ~/.drives/umount_drives.sh && echo '    local MOUNT_POINT="$1"' >> ~/.drives/umount_drives.sh && echo '' >> ~/.drives/umount_drives.sh && echo '    if is_mounted "$MOUNT_POINT"; then' >> ~/.drives/umount_drives.sh && echo '        sudo umount "$MOUNT_POINT"' >> ~/.drives/umount_drives.sh && echo '        echo "$MOUNT_POINT was disconnected."' >> ~/.drives/umount_drives.sh && echo '    else ' >> ~/.drives/umount_drives.sh && echo '        echo "$MOUNT_POINT was not mounted."' >> ~/.drives/umount_drives.sh && echo '    fi' >> ~/.drives/umount_drives.sh && echo '}' >> ~/.drives/umount_drives.sh && echo '' >> ~/.drives/umount_drives.sh && echo '# First drive' >> ~/.drives/umount_drives.sh && echo 'MOUNT_POINT1="/mnt/d"' >> ~/.drives/umount_drives.sh && echo '' >> ~/.drives/umount_drives.sh && echo '# Second drive' >> ~/.drives/umount_drives.sh && echo 'MOUNT_POINT2="/mnt/z"' >> ~/.drives/umount_drives.sh && echo '' >> ~/.drives/umount_drives.sh && echo '# Unmount the drives if they are connected' >> ~/.drives/umount_drives.sh && echo 'umount_drive "$MOUNT_POINT1"' >> ~/.drives/umount_drives.sh && echo 'umount_drive "$MOUNT_POINT2"' >> ~/.drives/umount_drives.sh
```

6. Make the files executable.
```bash
chmod +x ~/.drives/mount_drives.sh && chmod +x ~/.drives/umount_drives.sh
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
- `alias shutdownWSL='sudo shutdown -h now'`

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
alias shutdownWSL='sudo shutdown -h now'

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
alias shutdownWSL='sudo shutdown -h now'

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


