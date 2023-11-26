fish_vi_key_bindings
set -g theme_display_vi yes
set -g theme_show_exit_status yes
set -g theme_display_date no
set -g theme_display_nvm no
set -g theme_color_scheme dracula
#set -g theme_display_k8s_context yes
set -g theme_display_git_master_branch no
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_sudo_user yes
#set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_display_ruby no


alias vi="vim"
alias p="pwd"
alias filemanager='open . >/dev/null 2>&1'
alias get_idf=". $HOME/esp/esp-idf/export.fish"
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# ls
alias ls='lsd --group-dirs first' 
alias l='lsd --blocks permission,links,user,size,date,name --date relative -l'
alias la='ls -A'
alias lla='l -a'
alias lt='ls --tree'

# Get External IP
alias getip='curl -s https://ipinfo.io/json | jq'

# Check Internet Speed
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

set -gx IDF_PATH $HOME/esp/esp-idf
set -gx EDITOR vim
set -gx PATH $PATH $HOME/bin /usr/local/bin /usr/bin /bin /usr/sbin /sbin /usr/local/opt/python@3/libexec/bin

set -U FZF_DEFAULT_COMMAND "fd -H"
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --ansi --height=80% --preview-window=wrap --marker=" "'

#set -Ux FZF_TMUX_OPTS -p 

set -gx fzf_history_opts "--border-label=command history" "--prompt= "
set -gx fzf_directory_opts "--bind=ctrl-o:execute($EDITOR {} &> /dev/tty),alt-o:execute(open {} &> /dev/tty),ctrl-space:execute(qlmanage -p {} &> /dev/tty)"
set -gx fzf_preview_dir_cmd 'lsd --color always --blocks permission,links,user,size,date,name --date relative -l'

set -gx GOPATH $HOME/go
set -gx GOBIN $GOPATH/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end

fzf_configure_bindings --git_status=\cs --git_log=\cg --history=\cr --variables=\ce --processes=\cp --directory=\cf

zoxide init fish | source
starship init fish | source


# pnpm
set -gx PNPM_HOME "/Users/nadimtawileh/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end