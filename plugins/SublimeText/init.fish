if test -f /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
    alias subl '/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
else if test -f /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl
    alias subl '/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
end

complete -x -c subl -d "Load the given project" -a "project"
complete -x -c subl -d "Run the given command" -a "command"
complete -x -c subl -d "Open a new window" -s "n" -l "new-window"
complete -x -c subl -d "Add folders to the current window" -s "a" -l "add"
complete -x -c subl -d "Wait for the files to be closed before returning" -s "w" -l "wait"
complete -x -c subl -d "Don't activate the application" -s "b" -l "background"
complete -x -c subl -d "Keep the application activated after closing the file" -s "s" -l "stay"
complete -x -c subl -d "Show help and exit" -s "h" -l "help"
complete -x -c subl -d "Show version and exit" -s "v" -l "version"