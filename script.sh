#!/bin/bash

#Vérifie le nombre d'arguments
if [ $# -ne 2 ]
  then
          echo "Error : Le nombre d'argument est incorrect."
          exit 0
fi

#Vérifie les droits de l'utilisateur sur le fichier
if [ ! -w "$2" ]
  then
          echo "Vous ne pouvez pas éditer $2"
          exit 0
fi

if grep -q "<title>" $2
    #Met à jour la balise title
    then
        sed -i 's/<title>.*<\/title>/<title>'$1'<\/title>/g' $2
    #Crée la baslise title
    else
        sed -i "/<head>/a<title>"$1"</title>" $2
fi