# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/iwaniv/.zshrc'

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

autoload -Uz compinit
compinit
# End of lines added by compinstall
eval "$(starship init zsh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#eval "$(fnm env --use-on-cd)"
source /home/iwaniv/Git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

. /opt/asdf-vm/asdf.sh

alias easyeffects="flatpak run com.github.wwmm.easyeffects"

#export WLR_NO_HARDWARE_CURSORS=1
#export QT_QPA_PLATFORM=wayland
export PATH=$PATH:~/.cargo/bin/
export PATH=$PATH:/opt/bin
fastfetch

