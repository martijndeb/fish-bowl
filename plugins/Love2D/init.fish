if test -f /Applications/love.app/Contents/MacOS/love
    alias love '/Applications/love.app/Contents/MacOS/love'
else
    set -l lovePath (which love)
    if test -f $lovePath
        alias love $lovePath
    end
end