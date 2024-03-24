# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Path to powerlevel10k theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# List of plugins used
plugins=(git sudo zsh-syntax-highlighting zsh-autosuggestions web-search copyfile copybuffer history jsontools )
source $ZSH/oh-my-zsh.sh

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}


# Helpful Aliases 
alias l='eza -lh  --icons=auto'
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs

# Git Aliases
alias gac='git add . && git commit -m'
alias gs='git status'
alias gpush='git push origin'

# Important Aliases
alias yd='yt-dlp -f "bestvideo[height<=1080]+bestaudio" --embed-chapters --external-downloader aria2c --concurrent-fragments 4'
alias td='yt-dlp --external-downloader aria2c -o "%(title)s."'
alias vim='nvim'
alias grep='grep --color=auto'
alias ghistory='cat ~/.zsh_history | fzf'
alias up='yay -Syu && flatpak update'

# VPN Aliases
alias vpn-up='sudo tailscale up --exit-node=raspberrypi'
alias vpn-down='sudo tailscale down'
warp ()
{
    sudo systemctl "$1" warp-svc
}

# Other Aliases
alias cr='mpv --yt-dlp-raw-options=cookies-from-browser=firefox'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1'
lsfind ()
{
    ll "$1" | grep "$2"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Display Pokemon
# pokemon-colorscripts --no-title -r 1,3,6

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# NVM
# source /usr/share/nvm/init-nvm.sh

# Fnm
eval "$(fnm env --use-on-cd)"

 # typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet


eval "$(gh copilot alias -- zsh)"
