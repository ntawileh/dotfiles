function cdr -d "cd back to the root folder of the current repository"
    set root (git rev-parse --show-toplevel 2>/dev/null)
    if test $status -eq 0
        cd $root
    else
        echo "Not in a git repository."
        return 1
    end
end
