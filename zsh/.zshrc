if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
)

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# User configuration
#Znap
[[ -f ~/Git/zsh-snap/znap.zsh]] ||
    git clone --depth 1 == \
        https://github.com/marlonrichert/zsh-snap.git ~Git/zsh-snap

source ~/Git/zsh-snap/snap.zsh #Znap start

local FOUND_ATUIN=$+commands[atuin]

if [[ $FOUND_ATUIN -eq 1 ]]; then
  source <(atuin init zsh)
fi

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

znap prompt sindresorhus/pure

#auto dowmload and start
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh='nvim ~/.oh-my-zsh'
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
#exa aliases
if hash exa 2>/dev/null; then
    alias ls='exa'
    alias l='exa -l --all --group-directories-first --git'
    alias ll='exa -l --all --all --group-directories-first --git'
    alias lt='exa -T --git-ignore --level=2 --group-directories-first'
    alias llt='exa -lT --git-ignore --level=2 --group-directories-first'
    alias lT='exa -T --git-ignore --level=4 --group-directories-first'
else
    alias l='ls -lah'
    alias ll='ls -alF'
    alias la='ls -A'
fi


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

# Load syntax highlighting; 
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
