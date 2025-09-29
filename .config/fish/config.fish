fish_vi_key_bindings
# fish_config theme choose catppuccin-mocha

alias vi="vim"
alias n="nvim"
alias p="pwd"
alias filemanager='open . >/dev/null 2>&1'
alias get_idf=". $HOME/esp/esp-idf/export.fish"

# dotfiles
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lazydot='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ls
alias ls='lsd --group-dirs first'
alias l='lsd --blocks permission,links,size,date,name --date relative -l'
alias la='ls -A'
alias lla='l -a'
alias lt='ls --tree'

# Get External IP
alias getip='curl -s https://ipinfo.io/json | jq'

# Check Internet Speed
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

# git
## mods
# alias gcai="git --no-pager diff | mods 'write a commit message for this patch. also write the long commit message. use semantic commits. break the lines at 80 chars' >.git/gcai; git commit -a -F .git/gcai -e"

set -gx IDF_PATH $HOME/esp/esp-idf
set -gx EDITOR nvim
set -gx PATH $PATH $HOME/bin /usr/local/bin /usr/bin /bin /usr/sbin /sbin /usr/local/opt/python@3/libexec/bin
set -gx XDG_CONFIG_HOME "$HOME/.config"

set -U FZF_DEFAULT_COMMAND "fd -H"

set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/theme.yml"

set -gx fzf_history_opts "--border-label=command history" "--prompt= "
set -gx fzf_directory_opts "--bind=ctrl-o:execute($EDITOR {} &> /dev/tty),alt-o:execute(open {} &> /dev/tty),ctrl-space:execute(qlmanage -p {} &> /dev/tty)"
set -gx fzf_preview_dir_cmd 'lsd --color always --blocks permission,links,user,size,date,name --date relative -l'

set -gx GOPATH $HOME/go
set -gx GOBIN $GOPATH/bin
set -gx PATH $PATH $GOBIN

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]
    . "$HOME/google-cloud-sdk/path.fish.inc"
end

# fzf_configure_bindings --git_status=\cs --git_log=\cg --history=\cr --variables=\ce --processes=\cp --directory=\cf
fzf_configure_bindings --git_status=\cs --git_log=\cg --variables=\ce --processes=\cp --directory=\cf

zoxide init fish | source
starship init fish | source
atuin init fish | source

# pnpm
set -gx PNPM_HOME /Users/nadim/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
#
## set universally by themes
set -e -gU FZF_DEFAULT_OPTS

if [ -f "$HOME/.config/themes/current/fzf.fish" ]
    . "$HOME/.config/themes/current/fzf.fish"
end
