# Load from the plugin path
function loadFishBowlPlugin
    set -l lPluginPath $FBPATH/plugins/$argv[1]

    if test -d $lPluginPath
        if test -f $lPluginPath/.enabled
            if test -f $lPluginPath/description
                if test -f $lPluginPath/init.fish
                    . $lPluginPath/init.fish
                else
                    printf 'Plugin %s is missing a init.fish\n' $argv[1]
                end
            else
                printf 'Plugin %s is missing a description\n' $argv[1]
            end
        end
    end
end