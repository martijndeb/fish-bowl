function initializeHJSProject --description "Initiales a new HumboldtJS project"
    if test $argv
        printf 'Creating project %s\n' $argv[1]

        if test -d $argv[1]
            printf 'Project folder already exists'
        else
            printf '\nHumboldtJS-STL Provides you with some great additions to the core functionality of HumboldtJS like htmlp template support.\nDo you wish to download it and set it up for you?\n%s[type no to skip, anything else to continue]%s\n' (set_color -o) (set_color normal)
            read -l setupSTL

            printf '\n\nWhile we fetch and setup the empty project, surf to http://humboldtjs.com\n\n'

            curl -o master.zip -L https://github.com/humboldtjs/HumboldtJSEmpty/archive/master.zip
            unzip master.zip
            mv HumboldtJSEmpty-master $argv[1]
            mv $argv[1]/src/HumboldtJSEmpty.as $argv[1]/src/$argv[1].as

            for p in $argv[1]/src/$argv[1].as $argv[1]/build/build.xml
                if test -f $p
                    sed -i "" "s/HumboldtJSEmpty/$argv[1]/g" $p
                end
            end

            unlink master.zip

            cd $argv[1]

            printf 'Copying html-template\n'

            for p in bin-debug bin-release
                if not test -d $p
                    mkdir $p
                end

                cp -Rf html-template/* $p
                mv $p/index.template.html $p/index.html
                sed -i "" "s/\${title}/$argv[1]/g" $p/index.html
                sed -i "" "s/\${application}/$argv[1]/g" $p/index.html
            end

            if test $setupSTL != 'no'
                curl -o master.zip -L https://github.com/sexybiggetje/humboldtjs-stl/archive/master.zip
                unzip master.zip

                mv humboldtjs-stl-master stl

                sed -i "" "s/<arg value=\"..\/src\"\/>/<arg value=\"..\/src\"\/><arg value=\"-I\"\/><arg value=\"..\/stl\"\/>/g" build/build.xml

                unlink master.zip
            end

            printf 'Preparing first build\n'

            buildHJSProject debug
        end

        printf '\n\nDone setting up %s.\nIf you want to try out your project run serveHJSProject from:\n%s.\n\n' $argv[1] (pwd)
    else
        printf 'Please specify a project name\n'
    end
end

function buildHJSProject --description "Calls build script for HumboldtJS project"
    set -l lastPwd (pwd)

    if findClosest build/humboldtjs.jar
        cd $lastClosest

        if test -d $argv[1]
            ant -f build/build.xml "compile debug"
        else
            ant -f build/build.xml "compile $argv[1]"
        end

        cd $lastPwd
        return 0
    else
        printf 'Not inside a HumboldtJS project'
        return 1
    end
end

function serveHJSProject --description "Sets up a webserver for a HumboldtJS project"
    set -l lastPwd (pwd)

    if findClosest build/humboldtjs.jar
        cd $lastClosest

        if test -d $argv[1]
            php -S localhost:7777 -t bin-debug
        else
            php -S localhost:7777 -t "bin-$argv[1]"
        end

        cd $lastPwd
        return 0
    else
        printf 'Not inside a HumboldtJS project'
        return 1
    end
end

complete -x -c buildHJSProject -d "Builds the project using the debug target" -a "debug"
complete -x -c buildHJSProject -d "Builds the project using the release target" -a "release"
complete -x -c serveHJSProject -d "Starts a webserver from the bin-debug folder" -a "debug"
complete -x -c serveHJSProject -d "Starts a webserver from the bin-release folder" -a "release"
