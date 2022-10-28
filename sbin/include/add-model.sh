#!/bin/bash


function modelGen(){
    local templateDir="$1" 
    shift
    local controllersDir="$1"  modelsDir="$2"  repositoriesDir="$3"  servicesDir="$4" package="$5"
    declare -A modelParents
    declare -A modelPackages
    local i=0

    while true
    do

        choose_from_menu "Do you want to add a model? :" selected_choice "${YesOrNo[@]}"

        if [ "$selected_choice" = "Yes" ]
        then  
            echo "indicate the model name."
            nameGen models[$i]

            modelPackages["${models[$i]}"]=""
            #check if models are not empty.
            if [[ ${#models[*]} -ge 2 ]]
            then
                echo "Does the model inherit another model?"
                select yn in "Yes" "No"
                do
                case $yn in
                    Yes ) choose_from_menu "select parent :" modelParent_choice "${models[@]:0:${#models[*]}-1}" ;
                    modelParents["${models[$i]}"]="$modelParent_choice" ;
                    modelPackages["${models[$i]}"]=${modelPackages["$modelParent_choice"]};
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
                        modelPackages["${models[$i]}"]+="/${modelPackage}";
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


    #iterate on the models to generate elements
    unset i
    for i in "${models[@]}"
    do
    mkdir -p --verbose "${controllersDir}${modelPackages[$i]}"
    mkdir -p --verbose "${modelsDir}${modelPackages[$i]}"
    mkdir -p --verbose "${repositoriesDir}${modelPackages[$i]}"
    mkdir -p --verbose "${servicesDir}${modelPackages[$i]}"

    modelPackageName="${modelPackages[$i]}"

    model-file-parsing "${templateDir}/src/main/java/model/$([[ ${modelParents[$i]} != "" ]] && printf "ModelExtend" || printf "Model").java" "${modelsDir}${modelPackageName}/${i^}.java" "${i}" "${package}/model${modelPackageName}" "${modelParents[$i]}"
    model-file-parsing "${templateDir}/src/main/java/controller/Controller.java" "${controllersDir}${modelPackageName}/${i^}Controller.java" "${i}" "${package}/controller${modelPackageName}" "" 
    model-file-parsing "${templateDir}/src/main/java/repository/Repository.java" "${repositoriesDir}${modelPackageName}/${i^}Repository.java" "${i}" "${package}/repository${modelPackageName}" "" 
    model-file-parsing "${templateDir}/src/main/java/service/Service.java" "${servicesDir}${modelPackageName}/${i^}Service.java" "${i}" "${package}/service${modelPackageName}" "" 
    done
    
}

