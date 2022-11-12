#!/bin/bash

declare -a currentModels
declare -A modelPackages

#Add models 
function modelGen(){
    local templateDir="$1" 
    shift
    local controllersDir="$1"  modelsDir="$2"  repositoriesDir="$3"  servicesDir="$4"
    declare -A modelParents
    declare -a AllModels
    declare -a newModels
    local i=0

    while true
    do
        AllModels=("${currentModels[@]}" "${newModels[@]}")
        choose_from_menu "Do you want to add a model? :" selected_choice "${YesOrNo[@]}"

        if [ "$selected_choice" = "Yes" ]
        then
            #model name
            while true
            do  
                echo "indicate the model name."
                nameGen modelName
                #duplicate check
                if [[ ! ${AllModels[*],,} =~ (^|[[:space:]])"${modelName,,}"($|[[:space:]]) ]]
                then
                    break;
                fi
                echo -e "\e[31mThe model already exists\e[39m";
            done
            newModels[$i]="$modelName"
            modelPackages["${newModels[$i]}"]=""
            #check if models are not empty.
            if [[ ${#AllModels[*]} -ge 2 ]]
            then
                echo "Does the model inherit another model?"
                select yn in "Yes" "No"
                do
                case $yn in
                    Yes ) choose_from_menu "select parent :" modelParent_choice "${AllModels[@]}" ;
                    modelParents[$modelName]="$modelParent_choice" ;
                    modelPackages[$modelName]=${modelPackages["$modelParent_choice"]};
                        break;;
                    No ) break;;
                esac
                done
            fi

            echo "Put the model in a sus package?"
                select yn in "Yes" "No"
                do
                case $yn in
                    Yes ) 
                        echo "indicate the sus package name: ";
                        directoryGen modelPackage;
                        modelPackages[$modelName]+="/${modelPackage}";
                        break;;
                    No ) break;;
                esac
                done
            let i++
            echo ""
        else
            break
        fi

    done
    unset modelName
    unset i

    #iterate on the models to generate elements
    for i in "${newModels[@]}"
    do
        modelPackageName="${modelPackages[$i]}"

        mkdir -p --verbose "${controllersDir}${modelPackageName}"
        mkdir -p --verbose "${modelsDir}${modelPackageName}"
        mkdir -p --verbose "${repositoriesDir}${modelPackageName}"
        mkdir -p --verbose "${servicesDir}${modelPackageName}"

        model-file-parsing "${templateDir}/src/main/java/model/$([[ ${modelParents[$i]} != "" ]] && printf "ModelExtend" || printf "Model").java" "${modelsDir}${modelPackageName}/${i^}.java" "${i}" "${modelPackageName}" "${modelParents[$i]}"
        model-file-parsing "${templateDir}/src/main/java/controller/Controller.java" "${controllersDir}${modelPackageName}/${i^}Controller.java" "${i}" "${modelPackageName}" "" 
        model-file-parsing "${templateDir}/src/main/java/repository/Repository.java" "${repositoriesDir}${modelPackageName}/${i^}Repository.java" "${i}" "${modelPackageName}" "" 
        model-file-parsing "${templateDir}/src/main/java/service/Service.java" "${servicesDir}${modelPackageName}/${i^}Service.java" "${i}" "${modelPackageName}" "" 
    done
    unset i
    
}

#Add models to an existing project
function modelGenAux(){
    local scriptsFileDir="$1" workSpaceDir="$2"
    local appType="" templateDir=""
    
    # choose_from_menu "Please select the packaging used for your application:" appType "${packagings[@]}"
    appType="jar"
    #template
    templates=(`find ${scriptsFileDir}/../etc/template/${appType}/* -maxdepth 0 -type d -printf '%f \t'`)
    choose_from_menu "Please select the template used for your application :" appTemplate "${templates[@]}"
    templateDir="${scriptsFileDir}/../etc/template/${appType}/${appTemplate}"
    #package
    package="`sed -nre 's/^.*(package)\s*((\w+)(.\w+)*)+\s*;/\2/p' "$(find * -type f -wholename "src/main/java/*Application.java")" | sed "s/\./\//g"`"
    #paths
    modelsDir="`find * -type d -wholename "src/*/model"`"
    controllersDir="`find * -type d -wholename "src/*/controller"`"   
    repositoriesDir="`find * -type d -wholename "src/*/repository"`"
    servicesDir="`find * -type d -wholename "src/*/service"`"
    #current models
    currentModels=(`find * -type f -wholename "src/*model/*.java" | sed -nre 's/^.*\/(\w+)\.java/\1/p'`)

    #models packages
    #sed -nre 's/^.*(package)\s*((\w+)(.\w+)*)+\s*;/\2/p' file (modelpackage)
     #faire traitement sur les apckages . en /  et enlever le package principale {s/\./\//g; s/${package}//g; }
    for i in "${currentModels[@]}"
    do
        modelPackages[$i]="`sed -nre 's/^.*(package)\s*(.*.model)((.\w+)*)\s*;/\3/p' "$(find * -type f -wholename "src/main/java/*/model*/${i}.java")" | sed "s/\./\//g"`"
    done

    unset i

   modelGen "${templateDir}" "${controllersDir}" "${modelsDir}" "${repositoriesDir}" "${servicesDir}"

}

