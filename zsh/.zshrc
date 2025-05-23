ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.p10k.zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' max-errors 3 numeric
zstyle :compinstall filename '/home/cppshizoid/.zshrc'

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# Uncomment the following line to change how often thttps://youtu.be/cKxs5gUjl5A?t=490o auto-update (in days).
# zstyle ':omz:update' frequency 13
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf zsh-autosuggestions rust tmux ansible dotnet kubectl mvn gradle npm history systemd jsontools sudo dnf copyfile copybuffer thefuck vscode)
#alt+c directory search
#ctrl+r history search
#ctrl+t file search
source $ZSH/oh-my-zsh.sh
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi


#vulkan
export PATH=/usr/local/vulkan${PATH:+:$PATH}

# Compilation flags
export ARCHFLAGS="-arch x86_64 -fuse-ld=mold"
export CC=clang
export CXX=clang++
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias s="source ~/.zshrc"
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias cat='bat --theme="Catppuccin Mocha"'
alias du='dust'
alias cl='clear'
alias count='find . -type f | wc -l'
alias e='echo'
alias gh='history|grep'
alias nf='fastfetch'
alias nv='nvim'
alias v='vim'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias to=". gotodir"

alias weather="~/Scripts/weather.sh"
alias rfv='~/Scripts/rfv.zsh'
alias rfc='~/Scripts/rfc.zsh'
alias rfg='~/Scripts/fzf-git.zsh'
alias dnff='~/Scripts/dnf.sh'
alias flf='go-flatpak'
#mounted devices
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

#jb ide
alias clion= '~/.local/share/JetBrains/Toolbox/scripts/clion'
alias rider= '~/.local/share/JetBrains/Toolbox/scripts/rider'
alias pycharm= '~/.local/share/JetBrains/Toolbox/scripts/pycharm'
alias idea= '~/.local/share/JetBrains/Toolbox/scripts/idea'
alias datagrip= '~/.local/share/JetBrains/Toolbox/scripts/datagrip'
alias androidstudio= '~/.local/share/JetBrains/Toolbox/scripts/studio'

#nvitop
alias nvitop='pipx run nvitop'

#docker
alias docstats='docker stats $(docker ps -q)'                                  # stats on images
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dim='docker images'
alias dps='docker ps'
alias dpsa='docker ps -a'

#exa
alias ls='eza'
alias l='eza -l --all --group-directories-first --git'
alias ll='eza -l --all --all --group-directories-first --git'
alias lt='eza -T --git-ignore --level=2 --group-directories-first'
alias llt='eza -lT --git-ignore --level=2 --group-directories-first'
alias lT='eza -T --git-ignore --level=4 --group-directories-first'
alias t='eza --tree --level=2 --long'
#rust
alias crg_run='cargo build && cargo run'

#clang
alias cclg_run='f(){ clang -Wall -o testc "$@" -std=c11 -lm -fuse-ld=mold && ./testc; unset -f f;}; f'
alias clg_dbg='f(){ clang++ -g -Wall -Wextra -Werror -o test "$@" -std=c++23 -fuse-ld=mold && ./test; unset -f f;}; f'
alias clg_run='f(){ clang++ -Wall -o test "$@" -std=c++23 -fuse-ld=mold && ./test; unset -f f;}; f'
alias clg_tst='f(){ clang++ -Wall -Wextra -Werror -o test "$@" -std=c++2c -fuse-ld=mold && ./test; unset -f f;}; f'
#clang-format
alias clgf='clang-format --style=Google --dump-config > .clang-format'

#gcc
alias glg_run='f() {g++ -Wall -o test "$@" -std=c++2a && ./test; unset -f f;}; f'

#docker
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dim='docker images'
alias dps='docker ps'
alias dpsa='docker ps -a'

#clickhouse
alias clickhouse='~./clickhouse'

#dotnet
alias di='dotnet --info'
alias dv='dotnet --version'
alias dlr='dotnet --list-runtimes'
alias dls='dotnet --list-sdks'
alias db='dotnet build'
alias dbd='dotnet build --diagnostics'
alias dc='dotnet clean'
alias dm='dotnet migrate'
alias dms='dotnet msbuild'
alias dn='dotnet new'
alias dr='dotnet run'
alias dsc='dotnet script'
alias ds='dotnet sln'
alias dch='dotnet sdk check'
alias dap='dotnet add package'
alias drp='dotnet remove package'
alias dwi='dotnet workload install'
alias dwl='dotnet workload list'
alias dws='dotnet workload search'
alias dwu='dotnet workload uninstall'
alias dwup='dotnet workload update'
alias dti='dotnet tool install'
alias dtl='dotnet tool list'
alias dts='dotnet tool search'
alias dtu='dotnet tool uninstall'
alias dtup='dotnet tool update'
alias nuget='dotnet nuget'

#python
alias pipi='pip install'
alias p='python'
alias up='python -m pip install --upgrade pip'

#django
alias pym='python manager.py'
alias dj-sp='django-admin startproject'
alias dj-sa='pym startapp'
alias dj-rs='pym runserver'
alias dj-mm='pym makemigrations'
alias dj-mg='pym migrate'
alias dj-sm='pym sqlmigrate'
alias dj-ch='pym check'
alias dj-sh='pym shell'
alias dj-ds='pym dbshell'
alias dj-cs='pym createsuperuser'
alias dj-ts='pym test'

#colima
alias colima='/usr/local/bin/colima-Linux-x86_64'
#system
alias dnfi="sudo dnf5 install"
alias fli="flatpak install"
alias flu="flatpak update"
alias update="sudo dnf5 update -y; flatpak update; zinit update"

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

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

#zinit plugins
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light junegunn/fzf
zinit light z-shell/zsh-zoxide
zinit load ellie/atuin
zinit ice depth=1; zplugin light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab
zinit light darvid/zsh-poetry
#zplug
#
source ~/.zplug/init.zsh

zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh
zplug "chitoku-k/fzf-zsh-completions"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

#fzf-tab
zstyle ':completion:*' fzf-search-display true
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

#cargo
export PATH=$PATH:/home/cppshizoid/.cargo/bin
#go
export PATH=$PATH:/home/cppshizoid/go/bin
#dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
#vcpkg
export VCPKG_ROOT=/usr/bin/vcpkg
export PATH=$VCPKG_ROOT:$PATH
#ninja
export CMAKE_GENERATOR=Ninja

#fzf
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='**'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

_fzf_and_run_windget() {
  _fzf_comprun
  zle accept-line
}
zle -N         fzf-and-run-widget
bindkey '^[^I' fzf-and-run-widget

#gradle
#export PATH=$PATH:/opt/gradle/gradle-8.2.1/bin

#sdkman
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
#docker-composev2
#export PATH=
#docker-rootless
export PATH=/home/cppshizoid/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock
#deno
export DENO_INSTALL="/home/cppshizoid/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

##!/bin/zsh
if
IFS=: read -ra selected < <(
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
)
[ -n "${selected[0]}" ] && nvim "${selected[0]}" "+${selected[1]}"fi

# Searches only from flathub repository
# CLR=$(for i in {0..7}; do echo "tput setaf $i"; done)
BLK=\$(tput setaf 0); RED=\$(tput setaf 1); GRN=\$(tput setaf 2); YLW=\$(tput setaf 3); BLU=\$(tput setaf 4);
MGN=\$(tput setaf 5); CYN=\$(tput setaf 6); WHT=\$(tput setaf 7); BLD=\$(tput bold); RST=\$(tput sgr0);

AWK_VAR="awk -v BLK=${BLK} -v RED=${RED} -v GRN=${GRN} -v YLW=${YLW} -v BLU=${BLU} -v MGN=${MGN} -v CYN=${CYN} -v WHT=${WHT} -v BLD=${BLD} -v RST=${RST}"

# CLR=$(for i in {0..7}; do echo "tput setaf $i"; done)
BLK=\$(tput setaf 0); RED=\$(tput setaf 1); GRN=\$(tput setaf 2); YLW=\$(tput setaf 3); BLU=\$(tput setaf 4);
MGN=\$(tput setaf 5); CYN=\$(tput setaf 6); WHT=\$(tput setaf 7); BLD=\$(tput bold); RST=\$(tput sgr0);

AWK_VAR="awk -v BLK=${BLK} -v RED=${RED} -v GRN=${GRN} -v YLW=${YLW} -v BLU=${BLU} -v MGN=${MGN} -v CYN=${CYN} -v WHT=${WHT} -v BLD=${BLD} -v RST=${RST}"

# Searches only from flathub repository
fzf-flatpak-install-widget() {
  flatpak remote-ls flathub --cached --columns=app,name,description \
  | awk -v cyn=$(tput setaf 6) -v blu=$(tput setaf 4) -v bld=$(tput bold) -v res=$(tput sgr0) \
  '{
    app_info="";
    for(i=2;i<=NF;i++){
      app_info=cyn app_info" "$i
    };
    print blu bld $2" -" res app_info "|" $1
    }' \
  | column -t -s "|" -R 3 \
  | fzf \
    --ansi \
    --with-nth=1.. \
    --prompt="Install > " \
    --preview-window "nohidden,40%,<50(down,50%,border-rounded)" \
    --preview "flatpak --system remote-info flathub {-1} | $AWK_VAR -F\":\" '{print YLW BLD \$1 RST WHT \$2}'" \
    --bind "enter:execute(flatpak install flathub {-1})" # when pressed enter it doesn't showing the key pressed but it is reading the input
  zle reset-prompt
}
bindkey '^[f' fzf-flatpak-install-widget #alt-f
zle -N fzf-flatpak-install-widget

fzf-flatpak-uninstall-widget() {
  touch /tmp/uns
  flatpak list --columns=application,name \
  | awk -v cyn=$(tput setaf 6) -v blu=$(tput setaf 4) -v bld=$(tput bold) -v res=$(tput sgr0)  \
  '{
    app_id="";
    for(i=2;i<=NF;i++){
      app_id" "$i
    };
    print bld cyn $2 " - " res blu $1
   }' \
  | column -t \
  | fzf \
    --ansi \
    --with-nth=1.. \
    --prompt="  Uninstall > " \
    --header="M-u: Uninstall | M-r: Run" \
    --header-first \
    --preview-window "nohidden,50%,<50(up,50%,border-rounded)" \
    --preview  "flatpak info {3} | $AWK_VAR -F\":\" '{print RED BLD  \$1 RST \$2}'" \
    --bind "alt-r:change-prompt(Run > )+execute-silent(touch /tmp/run && rm -r /tmp/uns)" \
    --bind "alt-u:change-prompt(Uninstall > )+execute-silent(touch /tmp/uns && rm -r /tmp/run)" \
    --bind "enter:execute(
    if [ -f /tmp/uns ]; then
      flatpak uninstall {3};
    elif [ -f /tmp/run ]; then
      flatpak run {3};
    fi
    )" # same as the install one but when pressed  entered the message is something like this
# "Proceed with these changes to the system installation? [Y/n]:" but it will uninstall the selected app weird but idk y
  rm -f /tmp/{uns,run} &> /dev/null
  zle reset-prompt
}
bindkey '^[f^[u' fzf-flatpak-uninstall-widget #alt-f + alt-u
zle -N fzf-flatpak-uninstall-widget

function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

#!/usr/bin/bash
readonly basename="$(basename "$0")"

if ! hash fzf &> /dev/null; then
    printf 'Error: Missing dep: fzf is required to use %s.\n' "${basename}" >&2
    exit 64
fi

#Colors
declare -r esc=$'\033'
declare -r BLUE="${esc}[1m${esc}[34m"
declare -r RED="${esc}[31m"
declare -r GREEN="${esc}[32m"
declare -r YELLOW="${esc}[33m"
declare -r CYAN="${esc}[36m"
# Base commands
readonly QRY="dnf --cacheonly --quiet repoquery "
readonly PRVW="dnf --cacheonly --quiet --color=always info"
readonly QRY_PRFX='  '
readonly QRY_SFFX=' > '
# Install mode
readonly INS_QRYS="${QRY} --qf '${CYAN}%{name}'"
readonly INS_PRVW="${PRVW}"
readonly INS_PRMPT="${CYAN}${QRY_PRFX}Install packages${QRY_SFFX}"
# Remove mode
readonly RMV_QRYS="${QRY} --installed --qf '${RED}%{name}'"
readonly RMV_PRVW="${PRVW} --installed"
readonly RMV_PRMPT="${RED}${QRY_PRFX}Remove packages${QRY_SFFX}"
# Remove-userinstalled mode
readonly RUI_QRYS="${QRY} --userinstalled --qf '${YELLOW}%{name}'"
readonly RUI_PRVW="${PRVW} --installed"
readonly RUI_PRMPT="${YELLOW}${QRY_PRFX}Remove User-Installed${QRY_SFFX}"
# Updates mode
readonly UPD_QRY="${QRY} --upgrades --qf '${GREEN}%{name}'"
readonly UPD_QRYS="if [[ $(${UPD_QRY} | wc -c) -ne 0 ]]; then ${UPD_QRY}; else echo ${GREEN}No updates available.; echo Try refreshing metadata cache...; fi"
readonly UPD_PRVW="${PRVW}"
readonly UPD_PRMPT="${GREEN}${QRY_PRFX}Upgrade packages${QRY_SFFX}"

mapfile -d '' fhelp <<-EOF

        "${basename}"
        Interactive package manager for Fedora

        Alt-i       Install mode (default)
        Alt-r       Remove mode
        Alt-e       Remove User-Installed mode
        Alt-u       Updates mode
        Alt-m       Update package metadata cache

        Enter       Confirm selection
        Tab         Mark package ()
        Shift-Tab   Unmark package
        Ctrl-a      Select all

        ?           Help (this page)
        ESC         Quit
EOF

declare tmp_file
if tmp_file="$(mktemp --tmpdir "${basename}".XXXXXX)"; then
    printf 'in' > "${tmp_file}" &&
    SHELL='/bin/bash' \
    FZF_DEFAULT_COMMAND="${INS_QRYS}" \
	fzf \
    --ansi \
	--multi \
	--query=$* \
	--header=" ${basename} | Press Alt+? for help or ESC to quit" \
	--header-first \
	--prompt="${INS_PRMPT}" \
	--marker=' ' \
	--preview-window='right,67%,wrap' \
	--preview="${INS_PRVW} {1}" \
	--bind="enter:execute(if grep -q 'in' \"${tmp_file}\"; then sudo dnf install {+};
        elif grep -q 'rm' \"${tmp_file}\"; then sudo dnf remove {+}; \
        elif grep -q 'up' \"${tmp_file}\"; then sudo dnf upgrade {+}; fi; \
        read -s -r -n1 -p $'\n${BLUE}Press any key to continue...' && printf '\n')" \
	--bind="alt-i:unbind(alt-i)+reload(${INS_QRYS})+change-preview(${INS_PRVW} {1})+change-prompt(${INS_PRMPT})+execute-silent(printf 'in' > \"${tmp_file}\")+first+rebind(alt-r,alt-e,alt-u)" \
	--bind="alt-r:unbind(alt-r)+reload(${RMV_QRYS})+change-preview(${RMV_PRVW} {1})+change-prompt(${RMV_PRMPT})+execute-silent(printf 'rm' > \"${tmp_file}\")+first+rebind(alt-i,alt-e,alt-u)" \
	--bind="alt-e:unbind(alt-e)+reload(${RUI_QRYS})+change-preview(${RUI_PRVW} {1})+change-prompt(${RUI_PRMPT})+execute-silent(printf 'rm' > \"${tmp_file}\")+first+rebind(alt-i,alt-r,alt-u)" \
	--bind="alt-u:unbind(alt-u)+reload(${UPD_QRYS})+change-preview(${UPD_PRVW} {1})+change-prompt(${UPD_PRMPT})+execute-silent(printf 'up' > \"${tmp_file}\")+first+rebind(alt-i,alt-r,alt-e)" \
	--bind="alt-m:execute(sudo dnf makecache;read -s -r -n1 -p $'\n${BLUE}Press any key to continue...' && printf '\n')" \
	--bind="alt-?:preview(printf \"${fhelp[0]}\")" \
	--bind="ctrl-a:select-all"

    rm -f "${tmp_file}" &> /dev/null
else
    printf 'Error: Failed to create tmp file. $TMPDIR (or /tmp if $TMPDIR is unset) may not be writable.\n' >&2
    exit 65
fi

fzf-conda-activate () {
    choice=(
        $(
            conda env list |
            sed 's/\*/ /;1,2d' |
            xargs -I {} bash -c '
                name_path=( {} );
                py_version=( $(${name_path[1]}/bin/python --version) );
                echo ${name_path[0]} ${py_version[1]} ${name_path[1]}
            ' |
            column -t |
            fzf --layout=reverse \
                --info=inline \
                --border=rounded \
                --height=40 \
                --preview-window="right:30%" \
                --preview-label=" conda tree leaves " \
                --preview=$'
                    conda tree -p {3} leaves |
                    perl -F\'[^\\w-_]\' -lae \'print for grep /./, @F;\' |
                    sort
                '
        )
    )
    [[ -n "$choice" ]] && conda activate "$choice"
}
zle -N fzf-flatpak-uninstall-widget
zinit load ellie/atuin
# End of Zinit's installer chunk

export ATUIN_SESSION=$(atuin uuid)
export ATUIN_HISTORY="atuin history list"
_atuin_preexec(){
	local id; id=$(atuin history start -- "$1")
	export ATUIN_HISTORY_ID="$id"
}
_atuin_precmd(){
	local EXIT="$?"
	[[ -z "${ATUIN_HISTORY_ID}" ]] && return
	(RUST_LOG=error atuin history end --exit $EXIT -- $ATUIN_HISTORY_ID &) > /dev/null 2>&1
}
_atuin_search(){
	emulate -L zsh
	zle -I
	# Switch to cursor mode, then back to application
	echoti rmkx
	# swap stderr and stdout, so that the tui stuff works
	output=$(RUST_LOG=error atuin search -i -- $BUFFER 3>&1 1>&2 2>&3)
	echoti smkx
	if [[ -n $output ]] ; then
		RBUFFER=""
		LBUFFER=$output
	fi
	zle reset-prompt
}
add-zsh-hook preexec _atuin_preexec
add-zsh-hook precmd _atuin_precmd
zle -N _atuin_search_widget _atuin_search
if [[ -z $ATUIN_NOBIND ]]; then
	bindkey '^r' _atuin_search_widget
	# depends on terminal mode
	bindkey '^[[A' _atuin_search_widget
	bindkey '^[OA' _atuin_search_widget
fi
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(fzf --zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
compinit

# run
# add the line to your '.zshrc' file if it is useful for your case
compdef _gnu_generic fzf
autoload bashcompinit
bashcompinit
source /usr/bin/scripts/vcpkg_completion.zsh


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
