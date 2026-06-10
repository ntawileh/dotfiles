function avantosaws -d "load aws env vars for avantos"
    set config (fd --max-depth 1 --glob '*' ~/dev/a/aws/ | gum choose --header "Select AWS environment")

    if test -z "$config"
        echo "No AWS environment selected."
        return 1
    else
        echo "Loading AWS environment from: $config"
        . $config
        return 0
    end
end
