if test -f /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
    alias subl '/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
else if test -f /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl
    alias subl '/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
else
    set -l sublPath (which subl)
    if test -f $sublPath
        alias subl $sublPath
    end
end