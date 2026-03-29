function avantosaws -d "load aws env vars for avantos"
    set config (fd --max-depth 1 --glob '*' ~/dev/a/aws/ | fzf --prompt="AWS Environments > " --height=~50% --layout=reverse --border --exit-0)

    if test -z "$config"
        echo "No AWS environment selected."
        return 1
    else
        echo "Loading AWS environment from: $config"
        . $config
        return 0
    end
end
