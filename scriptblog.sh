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
            ;;
        --update-charset)
            charset='charset=';
            encoding=${arguments[$i+1]};
            fileName=${arguments[$i+2]};
            
            #On vérifie si encoding est vide ou non
            if [ -z $encoding ]
            then
                echo "La valeur d'encoding est vide"
                exit 1
            fi

            #On vérifie si filename n'est pas vide
            if [ ! -z $fileName ] 
            then
                #On vérifie si filename existe ou non
                if [ ! -f $fileName ] 
                then
                    echo "Le nom du fichier que vous avez écrit n'existe pas."
                    exit 1
                fi
            else 
                echo "Vous n'avez pas renseigné de nom fichier"
                exit 1
            fi 
            
            #On vérifie si l'utilisateur a la permission pour modifier le fichier
            if [! -w $fileName ]
            then 
                echo "Vous n'avez pas la permission de modifier le fichier"
            else
                #On vérifie si la balise charset existe 
                if grep -q $charset $fileName
                then
                    #On modifie le charset existant avec l'encoding renseigné 
                    sed -i 's/.*<meta charset=.*/\t\t<meta charset="'$encoding'">/g' $fileName
                else
                    #On crée la balise charset juste apres la balise head
                    sed -i '/<head>/a\\t\t<meta charset="'$encoding'">' $fileName
                fi
            fi
		;;
    esac 
done

