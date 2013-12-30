function fish_prompt
    echo -n (whoami)
    echo -n '@'
    echo -n (hostname -s)
    echo -n ' '
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n '> '
end