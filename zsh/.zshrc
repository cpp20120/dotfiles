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
)

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# User configuration
#Znap
[[ -f ~/Git/zsh-snap/znap.zsh]] ||
    git clone --depth 1 == \
        https://github.com/marlonrichert/zsh-snap.git ~Git/zsh-snap

source ~/Git/zsh-snap/snap.zsh #Znap start
 
znap prompt sindresorhus/pure

#auto dowmload and start
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
