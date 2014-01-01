# https://github.com/lunks/fish-nuggets/blob/master/functions/is-git.fish
function is_git
    env git rev-parse --git-dir ^/dev/null >/dev/null
end