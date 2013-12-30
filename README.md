fish-bowl
=========

A framework for managing your fish shell configuration. It can augment your shell experience with extras like themes, plugins and predefined prompts.

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
# Read instructions, then peplace with a description for your plugin
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
