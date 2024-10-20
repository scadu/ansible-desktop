# Enable profiling
# zmodload zsh/zprof

# Generated by Hermit; START; DO NOT EDIT.
HERMIT_ROOT_BIN="${HERMIT_ROOT_BIN:-"$HOME/bin/hermit"}"
eval "$(test -x $HERMIT_ROOT_BIN && $HERMIT_ROOT_BIN shell-hooks --print --zsh)"
# Generated by Hermit; END; DO NOT EDIT.

# Plugin management
ZPLUGIN_HOME="${HOME}/.zsh_plugins"

# PATH
typeset -U path PATH
path=(~/.local/bin ~/bin $path)
export PATH

# List of plugins
# Format: "username/repo:commit_hash"
plugins=(
    "zsh-users/zsh-history-substring-search:47a7d416c652a109f6e8856081abc042b50125f4"
    "zsh-users/zsh-autosuggestions:v0.7.0"
    "zsh-users/zsh-completions:0.34.0"
    "zsh-users/zsh-syntax-highlighting:0.7.1"
)

# Function to install or update plugins
install_zsh_plugins() {
    mkdir -p "$ZPLUGIN_HOME"
    for plugin in "${plugins[@]}"; do
        IFS=':' read -r repo commit <<< "$plugin"
        local plugin_name=$(basename "$repo")
        local plugin_dir="${ZPLUGIN_HOME}/${plugin_name}"

        if [ ! -d "$plugin_dir" ]; then
            echo "Installing ${plugin_name}..."
            git clone "https://github.com/${repo}.git" "$plugin_dir"
            git -C "$plugin_dir" checkout "$commit"
        else
            echo "Updating ${plugin_name}..."
            git -C "$plugin_dir" fetch
            git -C "$plugin_dir" checkout "$commit"
        fi
    done
    echo "Plugins installed/updated. Run 'source ~/.zshrc' to apply changes."
}

# Compile zsh files
compile_zsh_files() {
    zcompile ~/.zshrc
    for plugin in "${plugins[@]}"; do
        IFS=':' read -r repo commit <<< "$plugin"
        plugin_name=$(basename "$repo")
        plugin_file="${ZPLUGIN_HOME}/${plugin_name}/${plugin_name}.plugin.zsh"
        if [ -f "$plugin_file" ]; then
            zcompile "$plugin_file"
        fi
    done
}

# Initialize completion system
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Source plugins if they exist
for plugin in "${plugins[@]}"; do
    IFS=':' read -r repo commit <<< "$plugin"
    plugin_name=$(basename "$repo")
    plugin_file="${ZPLUGIN_HOME}/${plugin_name}/${plugin_name}.plugin.zsh"
    if [ -f "$plugin_file" ]; then
        source "$plugin_file"
    fi
done

# Lazy-load fzf
fzf_load() {
    if [ -f ~/.fzf.zsh ]; then
        source ~/.fzf.zsh
    elif [ -f /usr/share/fzf/key-bindings.zsh ] && [ -f /usr/share/fzf/completion.zsh ]; then
        source /usr/share/fzf/key-bindings.zsh
        source /usr/share/fzf/completion.zsh
    fi
    unfunction fzf_load
}

# Keybindings for history-substring-search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Additional Zsh settings for better experience
setopt AUTO_CD EXTENDED_GLOB NOMATCH NOTIFY PROMPT_SUBST

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY HIST_EXPIRE_DUPS_FIRST \
       HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE \
       HIST_SAVE_NO_DUPS

# Initialize starship and zoxide
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Compile zsh files if they need to be recompiled
if [[ "$HOME/.zshrc" -nt "$HOME/.zshrc.zwc" || ! -f "$HOME/.zshrc.zwc" ]]; then
    compile_zsh_files
fi

# Enable profiling output
# zprof