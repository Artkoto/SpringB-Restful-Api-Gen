#!/bin/bash

function file-parsing(){
    local source="$1" target="$2"
    cat "${source}" > "${target}"
    sed -i "{s/\${{appName}}/${appName}/gi;
            s/\${{appName^}}/${appName^}/gi}
            s/\${{appName,,}}/${appName,,}/gi
            s/\${{appType}}/${appType}/gi
            s/\${{artifactId}}/${artifactId,,}/gi
            s/\${{groupId}}/$(echo "${groupId,,}" | sed "s/\//./g")/gi
            s/\${{package}}/$(echo "${package,,}" | sed "s/\//./g")/gi
            s/\${{currentYear}}/$(date +%Y)/gi
            " "${target}"
}

function model-file-parsing(){
    local source="$1" target="$2" modelName="$3" modelPackage="$4" modelParent="$5"
    cat "${source}" > "${target}"
    sed -i "{s/\${{modelName}}/${modelName}/gi;
            s/\${{modelName^}}/${modelName^}/gi}
            s/\${{modelName,,}}/${modelName,,}/gi
            s/\${{modelPackage}}/$(echo "${modelPackage}" | sed "s/\//./g")/gi
            s/\${{modelParent}}/${modelParent^}/gi
            " "${target}"
}