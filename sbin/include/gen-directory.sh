#!/bin/bash


function directoryGen(){
    local dir="$1"
    while true
    do
        echo -n "# "
        read -r inputText
        if [[ "$inputText" =~ ^([a-zA-Z][a-zA-Z0-9]*)(\/[a-zA-Z][a-zA-Z0-9]*)*$ ]]
        then
            echo -e "\e[32m$inputText\e[39m"
            break
        else
            echo -e "\e[31mFollow this naming convention:"
            echo "- start with an alphabetical character"
            echo "- Do not use a dash '-', underscore '_', or other characters ($, *, accents, ...)"
            echo "- use the separator '/'"
            echo -e "\e[39m"
        fi
    done
    printf -v $dir "${inputText}"
}

