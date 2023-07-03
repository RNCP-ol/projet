# RECUPERATION DES ARGUMENTS
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -si) skip_installs=1;;
        -sa) skip_address=1;;
        *) echo "Unknown parameter passed: $1"; exit 1;;
    esac
    shift
done

# DEPENDANCES
if [[ "$skip_installs" == 1 ]]; then
  echo "L'argument -si a été passé, les dépendances ne seront pas installées ni mises à jour."
else
    # Nous devons d'abord mettre à jour pip et installer toutes les dépendances.
    echo "#Installation et mise à jour des dépendances Python"
    pip install --upgrade pip
    pip3 install -r requirements.txt

    # Il est aussi nécessaire d'installer le client Azure pour s'authentifier et accéder au service de stockage de fichiers
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi

# RECUPERATION DE L'IP
if [[ "$skip_address" == 1 ]]; then
  echo "L'argument -sa a été passé, l'adresse IP publique ne sera pas recherchée'."
else
    # Nous devons ensuite récupérer l'adresse IP de la machine où nous exécutons le script afin de l'ajouter aux adresses autorisées du serveur de base de données Azure/Postgres.
    echo -e "\n#Récupération de l'adresse IP publique"
    python helpers/retrieve_ip.py
    echo "Vous devriez autoriser l'adresse IP publique sur le serveur de base de données avant de continuer.
    Quand vous aurez terminé, veuillez presser la touche 'Entrer'."
    read input_check
fi

# AUTHENTIFICATION AZURE
# Nous devons aussi nous authentifier sur le serveur Azure pour accéder à la manipulation de données sur l'espace de stockage.
echo -e "\n#Authentification à Azure"
#az login

# LANCEMENT DE L'APPLICATION
echo -e "\nLa configuration s'est bien déroulée. Lancement de l'application..."
python etl.py