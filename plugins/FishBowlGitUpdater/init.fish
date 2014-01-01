function checkForFishBowlUpdate --description "Check for updates when using a git based copy"
    set -l currentPath (pwd)
    cd $FBPATH

    if is_git
        set -l localVersion (git rev-list --max-count=1 master)
        set -l remoteVersion (git rev-list --max-count=1 origin/master)
        printf 'Local version:  %s\n' $localVersion
        printf 'Remote version: %s\n' $remoteVersion

        if test $localVersion != $remoteVersion
            printf '\nUpdates are available. Please run git pull ~/.config/fish-bowl\n'
        end
    end

    cd $currentPath
end