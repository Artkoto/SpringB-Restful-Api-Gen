#!/bin/bash

# Yes or No
YesOrNo=(
    "Yes"
    "No"
    )

# racine du projet
scriptsFileDir="`dirname $0`"
projectRoot="`pwd`"

#incldes
source "${scriptsFileDir}/include/add-model.sh"
source "${scriptsFileDir}/include/create.sh"
source "${scriptsFileDir}/include/gen-directory.sh"
source "${scriptsFileDir}/include/selectmenuFonction.sh"

case $1 in
    "create" ) projectCraetion "$scriptsFileDir" "$projectRoot";;
    "add-model" ) modelGenBis "$scriptsFileDir" "$projectRoot";;
    * ) echo "Command $1 not found" ;;
    #todo : add command "help" for next time
esac