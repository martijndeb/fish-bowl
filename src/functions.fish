# Load from the plugin path
function loadFishBowlPlugin --description "Loads a plugin for fish-bowl"
    set -l lPluginPath $FBPATH/plugins/$argv[1]

    if test -d $lPluginPath
        if test -f $lPluginPath/.enabled
            if test -f $lPluginPath/description
                if test -f $lPluginPath/init.fish
                    source $lPluginPath/init.fish
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

# Sets the active prompt
function setActivePrompt --description "Sets the active prompt to"
    set -l activePrompt $argv[1]

    set -l lPromptPath $FBPATH/prompts/$activePrompt.fish

    if test -f $lPromptPath
        echo $activePrompt > $FBPATH/prompts/.activeprompt
        source $lPromptPath
    end
end

# Reset the prompt
function resetPrompt --description "Reset to the default prompt"
    rm $FBPATH/prompts/.activeprompt
    setActivePrompt default
end

# Sets the active theme
function setActiveTheme --description "Sets the active theme to"
    set -l activeTheme $argv[1]

    set -l lThemePath $FBPATH/themes/$activeTheme.fish

    if test -f $lThemePath
        echo $activeTheme > $FBPATH/themes/.activetheme
        source $lThemePath
    end
end

# Reset the theme
function resetTheme --description "Reset to the default theme"
    rm $FBPATH/themes/.activetheme
    setActiveTheme default
end

# Find closest X
function findClosest --description "Find the closest argv[1]"
    set -l closest (pwd)

    while test $closest != '/'
        if test -e "$closest/$argv[1]"
            set -g lastClosest "$closest/"
            return 0
        end

        set -l closest (dirname $closest)
    end

    set -g lastClosest ""
    return 1
end