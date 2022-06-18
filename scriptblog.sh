#!/bin/bash

#Récupère tous les arguments
arguments=("$@")

#Récupère le nombre d'arguments
lenght=$#

#Parcours tout les aguments dans le tableau et regarde si ça correspond au case et effectue les instructions
for (( i=0; i<$lenght;i++ ))
do
    case ${arguments[$i]} in
        --add-stylesheet)
            cssFile=${arguments[$i+1]};
            htmlFile=${arguments[$i+2]};
            if [ "$cssFile" = "$null" ]; then
                echo "Le path du css est vide"
                exit 1
            else
                if [ ! -f "$cssFile" ];then
                    echo "Le fichier css n'existe pas"
                    exit 1
                fi
            fi
            if [ "$htmlFile" = "$null" ];then
                echo "Le nom du fichier est vide"
                exit 1
            else
                if [ ! -f "$htmlFile" ];then
                    echo "Le fichier n'existe pas";
                    exit 1
                fi
                if [ ! -w "$htmlFile" ]; then 
                    echo "Permission denied"; 
                    exit 1
                else
                    insert='<link rel="stylesheet" href="'$cssFile'">'
                    if grep -q "$cssFile" "$htmlFile";
                    then
                    exit 0
                    else 
                        sed -i '/<\/head>/i\\t\t<link rel="stylesheet" href="'$cssFile'">' $htmlFile
                    fi
                fi  
            fi
            ;;
            --create-HTML)
            if [  -e FILENAME.html ]
            then
                    echo 'Error : Une erreur est survenu'
                    exit 0
            else
                    touch FILENAME.html  2>> errors.txt
                    cat index.html >> FILENAME.html
            fi
            if [ -s errors.txt ]
            then
                    echo "Une erreur s'est produite"
                    exit 0
            fi
            if [ ! -s FILENAME.html  ]
            then
                    echo 'Error : Le ficher FILENAME est vide'
                    exit 0
            fi
    esac 
done

