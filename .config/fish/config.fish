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
set -Ux FZF_DEFAULT_OPTS "--reverse \
		--border rounded \
		--no-info \
		--pointer='' \
		--marker=' ' \
		--ansi \
		--color='16,bg+:-1,gutter:-1,prompt:4,pointer:5,marker:6'"
	
set -Ux FZF_TMUX_OPTS "-p \
		--reverse \
		--border rounded \
		--no-info \
		--pointer='' \
		--marker=' ' \
		--ansi \
		--color='16,bg+:-1,gutter:-1,prompt:4,pointer:5,marker:6'"

set -Ux FZF_CTRL_R_OPTS "--border-label=' history ' \
		--header='ctrl-d: delete' \
		--prompt='  '"

set fzf_preview_dir_cmd 'lsd --blocks permission,links,user,size,date,name --date relative -l'

set -gx GOPATH $HOME/go
set -gx GOBIN $GOPATH/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end

zoxide init fish | source
starship init fish | source

