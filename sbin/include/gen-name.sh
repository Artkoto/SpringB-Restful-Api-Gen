#!/bin/bash

#name
function nameGen(){
    local name="$1"
    while true
    do
        echo -n "# "
        read -r inputText
        if [[ "$inputText" =~ ^([a-zA-Z][a-zA-Z0-9_ -]{2,49})$ ]]
        then
            echo -e "\e[32m$inputText\e[39m"
            echo ""
            break
        else
            echo -e "\e[31mFollow this naming convention:"
            echo "- start with an alphabetical character"
            echo "- must not contain any special characters"
            echo "- 3 characters minimum"
            echo "- 50 characters maximum"
            echo -e "\e[39m"
        fi

    done
    printf -v $name "${inputText}"
}



