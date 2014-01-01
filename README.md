fish-bowl
=========

A framework for managing your [fish shell](http://www.fishshell.com) configuration. It can augment your shell experience with extras like themes, plugins and predefined prompts.
By default no plugins, themes or prompts are enabled. Your config should be augmented, not filled with bloat. Keeping it light, keep it small.

Since this is a very early version, we assume ~/.config/fish and ~/.config/fish-bowl everywhere.

Installation
=========
New installation:
```
git clone https://github.com/sexybiggetje/fish-bowl.git ~/.config/fish-bowl
chmod +x ~/.config/fish-bowl/utils/install.sh
sh ~/.config/fish-bowl/utils/install.sh
```

Updating fish bowl from git
```
cd $FBPATH
git pull
```

Checking for updates
=========
You can manually check for plugins now using the checkForFishBowlUpdate command. This only works if you installed using git clone.
```
enablePlugin FishBowlGitUpdater
checkForFishBowlUpdate
```

Working with plugins
=========
Enabling a plugin
```
enablePlugin <pluginname>
```

Disabling a plugin
```
disablePlugin <pluginname>
```

Creating a new plugin
```
cp $FBPATH/plugins/dummy $FBPATH/plugins/<pluginname>
# Read instructions, then replace with a description for your plugin
vi $FBPATH/plugins/<pluginname>/description
vi $FBPATH/plugins/<pluginname>/init.fish
enablePlugin <pluginname>
# Test and send a pull request
```

Custom prompts
=========
Loading a custom prompt
```
setActivePrompt <promptname>
```

Resetting to default
```
resetPrompt
```

Custom themes
=========
Loading a custom theme
```
setActiveTheme <themename>
```

Resetting to default
```
resetTheme
```
