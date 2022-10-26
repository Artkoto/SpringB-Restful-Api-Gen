#!/bin/bash


function gen-repos(){
    local projectRoot="$1" templateDir="$2" appName="$3" package="$4" appType="$5"

    mkdir -p --verbose "${projectRoot}/${appName}" 
    #creation of files at the project roots
    cat "${templateDir}/.gitignore" > "${projectRoot}/${appName}/.gitignore"
    cat "${templateDir}/README.md" > "${projectRoot}/${appName}/README.md"
    cat "${templateDir}/LICENSE" > "${projectRoot}/${appName}/LICENSE"
    cat "${templateDir}/HELP.md" > "${projectRoot}/${appName}/HELP.md"
    cat "${templateDir}/mvnw" > "${projectRoot}/${appName}/mvnw"
    cat "${templateDir}/mvnw.cmd" > "${projectRoot}/${appName}/mvnw.cmd"
    cat "${templateDir}/pom.xml" > "${projectRoot}/${appName}/pom.xml" #test
    # sed -i "{s/\${{package}}/${{package}}/gi; s/\${appName}/${appName}/gi}" "${projectRoot}/${appName}/pom.xml"
    cat "${templateDir}/docker-compose.yml" > "${projectRoot}/${appName}/docker-compose.yaml"
    cat "${templateDir}/Dockerfile" > "${projectRoot}/${appName}/Dockerfile"

    #creation of the CRS folder
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/resources"
    mkdir -p --verbose "${projectRoot}/${appName}/src/test/java/${package}"

    #creation of the test file
    cat "${templateDir}/src/test/java/ApplicationTest.java" > "${projectRoot}/${appName}/src/test/java/${package}/${appName^}Test.java"

    #content of main
    #resources
    cat "${templateDir}/src/main/resources/application.properties" > "${projectRoot}/${appName}/src/main/resources/application.properties"

    #java
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/monitor"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/controller"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/model"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/repository"
    mkdir -p --verbose "${projectRoot}/${appName}/src/main/java/${package}/service"

    cat "${templateDir}/src/main/java/SpringBootApplication.java" > "${projectRoot}/${appName}/src/main/java/${package}/${appName^}Application.java"

    cat "${templateDir}/.gitignore" > "${projectRoot}/${appName}/src/main/java/${package}/monitor/ControllerMonitor.java"

    if [ "$appType" = "war" ]
    then
        cat "${templateDir}/src/main/java/ServletInitializer.java" > "${projectRoot}/${appName}/src/main/java/${package}/ServletInitializer.java"
    fi

}