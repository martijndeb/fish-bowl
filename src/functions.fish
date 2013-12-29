# Load from the plugin path
function loadFishBowlPlugin --description "Loads a plugin for fish-bowl"
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

# Enables a plugin
function enablePlugin --description "Enables a plugin for fish-bowl"
    touch $FBPATH/plugins/$argv[1]/.enabled
    loadFishBowlPlugin $argv[1]
end

# Disables a plugin.
function disablePlugin --description "Disables a plugin for fish-bowl"
    rm $FBPATH/plugins/$argv[1]/.enabled
    printf 'Disabled plugin currently requires you to restart your shell\n'
end