echo '\nThis fish-bowl installation assumes you have the fish shell installed.'
echo "Assuming that ./.config/fish is where your shell looks for its config file\n"

echo 'Proceed with installation? [return key = continue, other value = exit]'

read qContinue

if [ $qContinue == '']
then
    echo 'Proceeding with installation'
    if [ ! -d ~/.config/fish ]
    then
        echo 'Creating fish config directory'
        mkdir ~/.config/fish
    fi

    if [ ! -f ~/.config/fish/config.fish ]
    then
        echo 'Creating empty fish config'
        touch ~/.config/fish/config.fish
    fi

    if ! grep -q '~/.config/fish-bowl/bowl.fish' ~/.config/fish/config.fish
    then
        echo 'Appending fish-bowl template'
        cat ~/.config/fish-bowl/templates/config.fish >> ~/.config/fish/config.fish
    fi

    echo 'Finished installation'
else
    echo 'Aborted installation'
    exit 1
fi