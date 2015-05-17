complete -x -c plecost -d "show help message and exit" -s "h" -l "help"
complete -x -c plecost -d "verbosity level 1" -s "v" -l "verbosity"
complete -x -c plecost -d "verbosity level 2" -a "vv"
complete -x -c plecost -d "verbosity level 3" -a "vvv"
complete -x -c plecost -d "report file with extension: xml|json" -a "c"

complete -x -c plecost -d "do not try to find plugins versions" -s "np" -l "no-plugins"
complete -x -c plecost -d "do not check Wordpress connectivity" -s "nc" -l "no-check-wordpress"
complete -x -c plecost -d "do not check Wordpress version" -s "nv" -l "no-wordpress-version"
complete -x -c plecost -d "force to scan even although not wordpress installation detected" -s "f" -l "force-scan"
complete -x -c plecost -d "jackass mode: unlimited connections to remote host" -s "j" -l "jackass-modes"

complete -x -c plecost -d "set custom word list. Default 200 most common" -s "w" -l "wordlist"
complete -x -c plecost -d "list embedded available word list" -s "l" -l "list-wordlist"

complete -x -c plecost -d "number of parallel processes" -s "c" -l "concurrency"
complete -x -c plecost -d "don't display banner" -a "nb"

complete -x -c plecost -d "Update CVE database" -l "update-cve"
complete -x -c plecost -d "Update plugins" -l "update-plugins"
complete -x -c plecost -d "Update CVE, plugins and core" -l "update-all"

complete -x -c plecost -d "display plugins in database" -s "sp" -l "show-plugins"
complete -x -c plecost -d "display CVEs for plugin" -s "vp" -l "plugin-cves"
complete -x -c plecost -d "display details of CVE" -l "cve"