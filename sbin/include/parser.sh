#!/bin/bash

function file-parsing(){
    local source="$1" target="$2"
    cat "${source}" > "${target}"
    sed -i "{s/\${{appName}}/${appName}/gi;
            s/\${{appName^}}/${appName^}/gi;
            s/\${{appName,,}}/${appName,,}/gi;
            s/\${{appType}}/${appType}/gi;
            s/\${{javaVersion}}/$(java -version 2>&1| sed -nre 's/^.*(version).*"([0-9]+)(\.).*/\2/p')/gi;
            s/\${{artifactId}}/${artifactId,,}/gi;
            s/\${{groupId}}/$(echo "${groupId,,}" | sed "s/\//\./g")/gi;
            s/\${{package}}/$(echo "${package,,}" | sed "s/\//\./g")/gi;
            s/\${{yyyy}}/$(date +%Y)/gi;
            }" "${target}"
}

function model-file-parsing(){
    local source="$1" target="$2" modelName="$3" modelSusPackage="$4" modelParent="$5"
    cat "${source}" > "${target}"
    sed -i "{s/\${{modelName}}/${modelName}/gi;
            s/\${{modelName^}}/${modelName^}/gi;
            s/\${{modelName,,}}/${modelName,,}/gi;
            s/\${{modelName,}}/${modelName,}/gi;
            s/\${{modelSusPackage}}/$(echo "${modelSusPackage}" | sed "s/\//\./g")/gi;
            s/\${{package}}/$(echo "${package,,}" | sed "s/\//\./g")/gi;
            s/\${{modelParent}}/${modelParent^}/gi;
            }" "${target}"
}