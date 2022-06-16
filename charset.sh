#!/bin/sh

charset='charset='
encoding=$1
fileName=$2
 
echo $encoding
if [ -z $encoding ]
then
	echo "La valeur d'encoding est vide"
fi

if [ -z $fileName ] 
then 
	echo "Vous n'avez pas renseigné de nom fichier"
fi 
 
if grep -q $charset $fileName
then
	sed -i 's/.*<meta charset=.*/\t\t<meta charset="'$encoding'">/g' $fileName
else
	sed -i '/<head>/a\\t\t<meta charset="'$encoding'">' $fileName
fi


