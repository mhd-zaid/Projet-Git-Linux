#!/bin/bash

#Script de configuration d'un blog
#Création du fichier HTML

if [  -e FILENAME.html ]
  then
          echo 'Error : Le fichier FILENAME existe deja'
          exit 0
  else
          touch FILENAME.html
fi