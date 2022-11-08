#!/bin/bash


function gen-repos(){
    local projectRoot="$1" templateDir="$2" appName="$3" package="$4"

    mkdir -p --verbose "${projectRoot}/${appName}" 
    #creation of files at the project roots 
    projectRootFiles=(`find ${templateDir}/.* ${templateDir}/* -maxdepth 0 -type f -printf '%f \n'`)
    for rootFile in "${projectRootFiles[@]}"
    do
        file-parsing "${templateDir}/${rootFile}" "${projectRoot}/${appName}/${rootFile}"
    done

    #creation of the CRS folder
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/resources"
    mkdir -p --verbose "${projectRoot}/${appName}/src/test/java/${package}"

    #creation of the test file
    file-parsing "${templateDir}/src/test/java/ApplicationTest.java" "${projectRoot}/${appName}/src/test/java/${package}/${appName^}Test.java"

    #content of main
    #resources
    projectResourcesFiles=(`find ${templateDir}/src/main/resources/* -maxdepth 0 -type f -printf '%f \n'`)
    for resourcesFile in "${projectResourcesFiles[@]}"
    do
        file-parsing "${templateDir}/src/main/resources/${resourcesFile}" "${projectRoot}/${appName}/src/main/resources/${resourcesFile}"
    done

    #java
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/monitor"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/controller"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/model"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/repository"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/service"

    file-parsing "${templateDir}/src/main/java/monitor/ControllerMonitor.java" "${projectRoot}/${appName}/src/main/java/${package}/monitor/ControllerMonitor.java"
    
    #Main files
    projectMainFiles=(`find ${templateDir}/src/main/java/* -maxdepth 0 -type f -printf '%f \n'`)
    for mainFile in "${projectMainFiles[@]}"
    do
        file-parsing "${templateDir}/src/main/java/${mainFile}" "${projectRoot}/${appName}/src/main/java/${package}/$(echo "${mainFile}" | sed "s/AppName/${appName^}/gi")"
    done

}