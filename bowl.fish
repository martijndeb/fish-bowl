# fish-bowl
set FISHBOWLVERSION 0.1
set FISHBOWLUSER (whoami)
set FISHBOWLPLATFORM (uname -s)

. $FBPATH/src/functions.fish

for pluginName in $FBPATH/plugins/*
    loadFishBowlPlugin (basename $pluginName)
end