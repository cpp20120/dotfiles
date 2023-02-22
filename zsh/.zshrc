typeset -g POWERLEVEL10K_INSTANT_PROMPT=quiet

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

ZSH_THEME="powerlevel10k/powerlevel10k"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto      # update automatically without asking

ENABLE_CORRECTION="true"

HIST_STAMPS="mm/dd/yyyy"

plugins=(git
	zsh-autosuggestions
    	znap
    	web-search
    	zsh-history-substring-search
    	poetry
)

source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/git/git.plugin.zsh
source ~/.config/zsh/zsh-autocomplete/zsh-autocomplete.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-enquirer/zsh-history-enquirer-plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fpath+=~/.zfunc

 DISABLE_MAGIC_FUNCTIONS="true"
 ENABLE_CORRECTION="true"
 COMPLETION_WAITING_DOTS="true"
 HIST_STAMPS="mm/dd/yyyy"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi

#extract archives
extract () {
 if [ -f $1 ] ; then
 case $1 in
 *.tar.bz2)   tar xjf $1        ;;
 *.tar.gz)    tar xzf $1     ;;
 *.bz2)       bunzip2 $1       ;;
 *.rar)       unrar x $1     ;;
 *.gz)        gunzip $1     ;;
 *.tar)       tar xf $1        ;;
 *.tbz2)      tar xjf $1      ;;
 *.tbz)       tar -xjvf $1    ;;
 *.tgz)       tar xzf $1       ;;
 *.zip)       unzip $1     ;;
 *.Z)         uncompress $1  ;;
 *.7z)        7z x $1    ;;
 *)           echo "I don't know how to extract '$1'..." ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi
}

#create archives
pk () {
 if [ $1 ] ; then
 case $1 in
 tbz)       tar cjvf $2.tar.bz2 $2      ;;
 tgz)       tar czvf $2.tar.gz  $2       ;;
 tar)      tar cpvf $2.tar  $2       ;;
 bz2)    bzip $2 ;;
 gz)        gzip -c -9 -n $2 > $2.gz ;;
 zip)       zip -r $2.zip $2   ;;
 7z)        7z a $2.7z $2    ;;
 *)         echo "'$1' cannot be packed via pk()" ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi
}

#zoxide
eval "$(zoxide init zsh)"

#aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias cat='bat'
alias du='dust'
alias clg_run='f(){ clang++ -Wall -o test "$@" -std=c++20 && ./test; unset -f f;}; f'
alias cl='clear'
alias count='find . -type f | wc -l'
alias e='echo'
alias gh='history|grep'
alias nf='neofetch'
alias nv='nvim'
alias v='vim'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias to=". gotodir"
__conda_setup="$('/home/cppshizoid/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/cppshizoid/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/cppshizoid/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/cppshizoid/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

nf

export PATH="~/.cargo/bin/erdtree"

eval "$(starship init zsh)"
