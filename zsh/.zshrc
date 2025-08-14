export CLICOLOR=1
export LSCOLORS="gxfxcxdxbxegedabagacad"

source ~/.zsh_aliases
eval "$(oh-my-posh init zsh --config ~/oh-my-posh.theme.omp.json)"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-web-search/web-search.zsh

export PATH="/opt/GO/1.23.1/bin/:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey -s ^f "tmux-sessionizer\n"


export PATH="$HOME/opt/bin/:$PATH"
