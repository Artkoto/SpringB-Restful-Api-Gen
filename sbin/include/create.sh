#!/bin/bash

# app type
packagings=(
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
    local appTemplate="" templateDir=""

    source "${scriptsFileDir}/include/gen-repositories.sh"
    source "${scriptsFileDir}/include/gen-name.sh"

    # Step 1 : general information about the application
    #Step 1.1 : App name
    echo "idicate the name of your application"
    nameGen appName
    # Step 1.2 : groupId
    echo "indicate the grouped. example: fr/company/team.."
    directoryGen groupId
    # Step 1.3 : artifactId
    echo "indicate the artifactId."
    nameGen artifactId
    # Step 1.4 : packaging
    choose_from_menu "Select the application type :" appType "${packagings[@]}"

    #Step 1.5 : verification of the input(TODO)
    # Step 1.6 : Template (TODO : add more template)
    appTemplate="default"
    # Step 1.7 : templateDir
    templateDir="${scriptsFileDir}/../etc/template/${appType}/${appTemplate}"
    # Step 1.8 : package
    package="${groupId}/${artifactId}"

    echo "${projectRoot} ${appName} ${templateDir} ${package}"
    #Gen repo
    gen-repos "${projectRoot}" "${templateDir}" "${appName}" "${package}" "${appType}"

    #Gen models
    controllersDir="${projectRoot}/${appName}/src/main/java/${package}/controller"   
    modelsDir="${projectRoot}/${appName}/src/main/java/${package}/model"
    repositoriesDir="${projectRoot}/${appName}/src/main/java/${package}/repository"
    servicesDir="${projectRoot}/${appName}/src/main/java/${package}/service"

    modelGen "${scriptsFileDir}" "${controllersDir}" "${modelsDir}" "${repositoriesDir}" "${servicesDir}" "${package}"

}