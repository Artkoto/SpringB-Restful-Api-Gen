#!/bin/bash

# app type
packaging=(
    "jar"
    "war"
    )

#inputs modification
# inputsEdit={

# }

#projject creation function
function projectCraetion(){
    local scriptsFileDir="$1" projectRoot="$2"
    local appName="" groupId="" artifactId="" package="" appType=""

    source "${scriptsFileDir}/include/gen-repositories.sh"
    source "${scriptsFileDir}/include/gen-name.sh"

    # Etape 1 : general information about the application
    #Etape 1.1 : App name
    echo "idicate the name of your application"
    nameGen appName
    # Etape 1.2 : groupId
    echo "indicate the grouped. example: fr/company/team.."
    directoryGen groupId
    # Etape 1.3 : artifactId
    echo "indicate the artifactId."
    nameGen artifactId
    # Etape 1.4 : packaging
    choose_from_menu "Select the application type :" appType "${packaging[@]}"

    #Etape 1.5 : verification of the input(TODO)

    # Etape 1.6 : package
    package="${groupId}/${artifactId}"

    #Gen repo
    gen-repos projectRoot appName package

    #Gen models
    controllersDir="${projectRoot}/${appName}/src/main/java/${package}/controller"   
    modelsDir="${projectRoot}/${appName}/src/main/java/${package}/model"
    repositoriesDir="${projectRoot}/${appName}/src/main/java/${package}/repository"
    servicesDir="${projectRoot}/${appName}/src/main/java/${package}/service"

    modelGen controllersDir modelsDir repositoriesDir servicesDir package

}