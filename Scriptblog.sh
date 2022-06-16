#!/bin/bash

#Script de configuration d'un blog
#Création du fichier HTML

if [  -e FILENAME.html ]
  then
          echo 'Error : Une erreur est survenu'
          exit 0
  else
          touch FILENAME.html  2>> errors.txt
          cat PageHtml5.txt >> FILENAME.html
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