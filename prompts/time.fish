function fish_prompt
    set_color $fish_color_cwd
    echo -n (date +"%H:%M")
    set_color normal
    echo -n ' '
    echo -n (whoami)
    echo -n '@'
    echo -n (hostname -s)
    echo -n ' '
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n '> '
end