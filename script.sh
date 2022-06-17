#!/bin/bash

#Vérifie le nombre d'arguments
if [ $# -ne 2 ]
  then
          echo "Error : Le nombre d'argument est incorrect."
          exit 0
fi

#Vérifier les droits de l'utilisateur

if [ ! -w "$2" ]
  then
          echo "Vous ne pouvez pas éditer $2"
          exit 0
fi

if grep -q "<title>" $2
    #Mettre à jour la balise title
    then
        echo "Nous allons remplacer le titre par $1"
    #    sed -i "s/.*<title>*<title>0*/<title>"$1"</title>" $2
    #    sed "s/<title>Document<\/title>/toto/g" $2
        sed "/<title>/d" $2 >> $2
        sed -i "/<head>/a <title>"$1"</title>" $2
    #Créer la baslise title
    else
        echo "Nous allons ajouter un titre $1"
        sed "/<title>/d" $2 >> $2
        sed -i "/<head>/a <title>"$1"</title>" $2
fi