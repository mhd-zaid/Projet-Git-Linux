#!/bin/sh
case ${arguments[$1]} in 
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


