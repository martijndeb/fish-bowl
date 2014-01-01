function checkForFishBowlUpdate --description "Check for updates when using a git based copy"
    set -l currentPath (pwd)
    cd $FBPATH

    if is_git
        printf 'Is git!'
    end
end