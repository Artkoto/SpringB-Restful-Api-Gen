#!/bin/bash


function gen-repos(){
    local projectRoot="$1" templateDir="$2" appName="$3" package="$4" appType="$5"

    mkdir -p --verbose "${projectRoot}/${appName}" 
    #creation of files at the project roots
    file-parsing "${templateDir}/.gitignore" "${projectRoot}/${appName}/.gitignore"
    file-parsing "${templateDir}/README.md" "${projectRoot}/${appName}/README.md"
    file-parsing "${templateDir}/LICENSE" "${projectRoot}/${appName}/LICENSE"
    file-parsing "${templateDir}/HELP.md" "${projectRoot}/${appName}/HELP.md"
    file-parsing "${templateDir}/mvnw" "${projectRoot}/${appName}/mvnw"
    file-parsing "${templateDir}/mvnw.cmd" "${projectRoot}/${appName}/mvnw.cmd"
    file-parsing "${templateDir}/pom.xml" "${projectRoot}/${appName}/pom.xml"
    file-parsing "${templateDir}/docker-compose.yml" "${projectRoot}/${appName}/docker-compose.yml"
    file-parsing "${templateDir}/Dockerfile" "${projectRoot}/${appName}/Dockerfile"

    #creation of the CRS folder
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/resources"
    mkdir -p --verbose "${projectRoot}/${appName}/src/test/java/${package}"

    #creation of the test file
    file-parsing "${templateDir}/src/test/java/ApplicationTest.java" "${projectRoot}/${appName}/src/test/java/${package}/${appName^}Test.java"

    #content of main
    #resources
    file-parsing "${templateDir}/src/main/resources/application.properties" "${projectRoot}/${appName}/src/main/resources/application.properties"

    #java
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/monitor"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/controller"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/model"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/repository"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/service"

    file-parsing "${templateDir}/src/main/java/SpringBootApplication.java" "${projectRoot}/${appName}/src/main/java/${package}/${appName^}Application.java"

    file-parsing "${templateDir}/src/main/java/monitor/ControllerMonitor.java" "${projectRoot}/${appName}/src/main/java/${package}/monitor/ControllerMonitor.java"

    if [ "$appType" = "war" ]
    then
        file-parsing "${templateDir}/src/main/java/ServletInitializer.java" "${projectRoot}/${appName}/src/main/java/${package}/ServletInitializer.java"
    fi

}