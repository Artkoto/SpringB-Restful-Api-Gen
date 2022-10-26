#!/bin/bash

function file-parsing(){
    local source="$1" target="$2"
    cat "${source}" > "${target}"
    #\//. package and groupid 
    sed -i "{s/\${{appName}}/${appName}/gi;
            s/\${{appName^}}/${appName^}/gi}
            s/\${{appName,,}}/${appName,,}/gi
            s/\${{appType}}/${appType}/gi
            s/\${{artifactId}}/${artifactId,,}/gi
            s/\${{groupId}}/$(echo "${groupId,,}" | sed "s/\//./g")/gi
            s/\${{package}}/$(echo "${package,,}" | sed "s/\//./g")/gi
            " "${target}"
}

function model-file-parsing(){
    local source="$1" target="$2" modelPackage="$3" modelParent="$4"
    cat "${source}" > "${target}"
    #\//. package and groupid  and modelPackage
    sed -i "{s/\${{appName}}/${appName}/gi;
            s/\${{appName^}}/${appName^}/gi}
            s/\${{appName,,}}/${appName,,}/gi
            s/\${{artifactId}}/${artifactId,,}/gi
            s/\${{groupId}}/$(echo "${groupId,,}" | sed "s/\//./g")/gi
            s/\${{package}}/$(echo "${package,,}" | sed "s/\//./g")/gi
            s/\${{package}}/$(echo "${modelPackage}" | sed "s/\//./g")/gi
            s/\${{modelParent}}/${modelParent^}/gi
            " "${target}"
}