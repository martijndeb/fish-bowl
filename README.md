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
disablePlugin <plugin>
```