#!/bin/bash

# Yes or No
YesOrNo=(
    "Yes"
    "No"
    )
# app type
packagings=(
    "jar"
    "war"
    )
package=""
# racine du projet
scriptsFileDir="`dirname $0`"
workSpaceDir="`pwd`"

#incldes
source "${scriptsFileDir}/include/add-model.sh"
source "${scriptsFileDir}/include/create.sh"
source "${scriptsFileDir}/include/gen-directory.sh"
source "${scriptsFileDir}/include/gen-name.sh"
source "${scriptsFileDir}/include/parser.sh"
source "${scriptsFileDir}/include/selectmenuFonction.sh"

case $1 in
    "create" ) projectCraetion "$scriptsFileDir" "$workSpaceDir";;
    "add-model" ) modelGenAux "$scriptsFileDir" "$workSpaceDir";;
    * ) echo "Command $1 not found" ;;
    #todo : add command "help" for next time
esac