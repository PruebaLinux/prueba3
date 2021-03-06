#!/bin/bash
if [[ $(dpkg --get-selections | grep git) ]]; then
	echo "git is installed with version $(git --version | cut -d n -f2)";
else
	if zenity --question --title "Git install" --text "Git no esta instalado, desea instalarlo?"; then
		sudo apt-get install git;
	else
		exit 0;
	fi
fi
if [[ $(git config user.name) ]]; then
	echo "user is ok..";
else
	if zenity --question --title "Git config" --text "No hay usuario asociado, esta aplicacion usa esta configuracion.. desea asociar un usuario?"; then
		global=$(zenity --entry --title="Git global info" --text="Introduzca Username" );
		$(git config --global user.name "$global");
		global=$(zenity --entry --title="Git global info" --text="Introduzca correo" );
		$(git config --global user.email $global);
	fi
fi
user=$(git config user.name);
folder=""
while [[ true ]]; do
	opt=$(zenity --title "Menu principal" --list --column="Opciones" "Crear repositorio" "Modificar repositorio" "Eliminar repositorio" "Clonar repositorio"  "Abrir repositorio local"  "Configuraciones de git");
	if  [[ "$opt" = "Crear repositorio" ]]; then
		oh=$(zenity --title "Seleccione donde desea ubicar el repositorio" --file-selection --directory);
		$(cd $oh);
		$(git init);
		ah=$(zenity --entry --text "Ingrese la direccion HTTP del repositorio");
		$(git remote add origin $ah);
	elif [[ "$opt" = "Modificar repositorio" ]]; then
		mod=$(zenity --title "Modificar repositorio" --list --column="Opciones" "Pull" "Push");
		if [[ "$mod" = "Pull" ]]; then
			$(git pull origin master)
		elif [[ "$mod" = "Push" ]]; then
			git add .
                        git commit -m "commit de prueba..."
			$(git push origin master)
		fi
	elif [[ "$opt" = "Eliminar repositorio" ]]; then
		el=$(zenity --title "Seleccione el directorio del repositorio" --file-selection --directory)
		$(cd $el)
		$(rm -R $el)
	elif [[ "$opt" = "Clonar repositorio" ]]; then
		repo=$(zenity --title "Clonar repositorio" --text "Introduzca la direccion del repositorio, se usara el usuario en el global para clonar" --entry);	
		$(git clone $repo);		
		if [[  $(ls | grep ${repo}) ]]; then
			$(zenity --info --text "Repositorio clonado!");
		else
			$(zenity --error --title "Error" --text "Error al clonar, ya existe localmente o no existe el repositorio")
		fi		
	elif [[ "$opt" = "Abrir repositorio local" ]]; then
		fol=$(zenity --title "Abrir repositorio" --file-selection --directory);
		if [[ $(ls ${fol} | grep init) ]]; then
			$(zenity --title "Abrir repositorio" --text "Repositorio local valido!" --info);
		fi
	elif [[ "$opt" = "Configuraciones de git" ]]; then
		echo "encontstruccion";
	else
		exit 0
	fi
done

