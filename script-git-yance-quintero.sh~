#!/bin/bash

defaultCommitMessage="LINUX_MACHINE_AUTOMATIC_COMMIT"
defaultPromptUrlMessage="Ingresa la URL del repositorio: \n"
invalidUrlMessage="Url invalida.\n"

validateUrl () {
if [[ $1 == *".git"* && ( $1 == *"http"* || $1 == *"git@"* ) ]]
then
	return 0
else
	return 1
fi
}

while true; do
	printf "Los comandos disponibles son (install, uninstall, delete, update, status, create, seturl, clone, createbranch, movetobranch, merge, deletebranch, commitaddall, push, pull, exit). \n"
	read comando

	if [ "$comando" == "install" ]; then
		sudo apt-get install git-all
	fi

	if [ "$comando" == "delete" ]; then
		printf "Estas seguro que deseas eliminar el repositorio local actual?: (y, n): \n"
		read input
		if [ "$input" == "y" ]; then
			sudo rm -rf .git
		fi
	fi

	if [ "$comando" == "uninstall" ]; then
		printf "Estas seguro que deseas desinstalar Github: (y, n): \n"
		read input
		if [ "$input" == "y" ]; then
			sudo apt-get remove git
		fi
	fi

	if [ "$comando" == "update" ]; then
		sudo add-apt-repository ppa:git-core/ppa -y
		sudo apt-get update
		sudo apt-get install git
		git --version
	fi

	if [ "$comando" == "create" ]; then
		printf "$defaultPromptUrlMessage"
		read url
		if validateUrl $url; then
			git -C "./"$d init
			git -C "./"$d remote add origin "$url"
		else
			printf "$invalidUrlMessage"
		fi
	fi

	if [ "$comando" == "seturl" ]; then
		printf "$defaultPromptUrlMessage"
		read url
		if validateUrl $url; then
			git -C "./"$d remote set-url origin "$url"
		else
			printf "$invalidUrlMessage"
		fi
	fi

	if [ "$comando" == "clone" ]; then
		printf "Ingresa la URL del repositorio que deseas clonar: \n"
		read url
		if validateUrl $url; then
			git -C "./"$d clone "$url"
		else
			printf "$invalidUrlMessage"
		fi
	fi

	if [ "$comando" == "status" ]; then
		git -C "./"$d status
	fi

	if [ "$comando" == "createbranch" ]; then
		printf "Que nombre desea para la rama: \n"
		read branchName
		git -C "./"$d checkout -b "$branchName"
	fi

	if [ "$comando" == "movetobranch" ]; then
		printf "A que rama se desea mover: \n"
		read branchName
		git -C "./"$d checkout "$branchName"
	fi

	if [ "$comando" == "merge" ]; then
		printf "¿Esta seguro que desea hacer merge en la rama actual? (y, n): \n"
		git -C "./"$d symbolic-ref --short HEAD
		read input
		if [ "$input" == "y" ]; then
			printf "Digite el nombre de la rama a hacer merge: \n"
			read branchName
			git -C "./"$d merge "$branchName"
		fi
	fi

	if [ "$comando" == "deletebranch" ]; then
		printf "Digite el nombre de la rama: \n"
		read branchName
		git -C "./" branch -d "$branchName"
	fi

	if [ "$comando" == "commitaddall" ]; then
	        git -C "./"$d add .
		git -C "./"$d commit -a -m "$defaultCommitMessage"
	fi

	if [ "$comando" == "push" ]; then
		git -C "./"$d push --set-upstream origin master
	fi

	if [ "$comando" == "pull" ]; then
		git -C "./"$d pull origin master
	fi

	if [ "$comando" == "exit" ]; then
		break;
	fi
done
