---
description: >-
  Cette page décrit les étapes à suivre pour installer Jenkins sur l'instance
  EC2.
---

# Jenkins

## Préparation de l'installation

Créer un fichier `jenkins.sh` et y insérer le code ci-dessous

```shell
#!/bin/bash
sudo apt update -y
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
sudo apt update -y
# sudo apt install temurin-17-jdk -y
sudo apt install openjdk-17-jdk -y
/usr/bin/java --version
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
                  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                              /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins
```

## Installation

```shell
sudo chmod 744 jenkins.sh 
./jenkins.sh
```

### Ajout du user jenkins au groupe Docker

Il est nécessaire d'ajouter le user jenkins au groupe docker pour que Jenkins puisse exécuter les tâches Docker et redémarrer Jenkins (qui sera fait à l'étape suivante).

```sh
sudo usermod -aG docker jenkins
```

## Modification du port Jenkins

> Le port utilisé par défaut par Jenkins est  8080, dans le cadre de cet exercice, nous allons le modifier pour le port 8090 afin d'éviter des conflits de ports

Pour modifier le port de Jenkins, il s'agit de modifier les fichiers de configuration suivants :

* `/etc/default/jenkins`&#x20;
* `/lib/systemd/system/jenkins.service`

Pour cela, réaliser les étapes suivantes :

1. Arrêter le service Jenkins : `sudo systemctl stop jenkins`
2. Vérifier que Jenkins est bien arrêté : `sudo systemctl status jenkins`
3. Dans le fichier `/etc/default/jenkins`Modifier la valeur de la ligne `HTTP_PORT=` à <mark style="color:red;">8090</mark>&#x20;
4. Dans le fichier `/lib/systemd/system/jenkins.service` modifier la valeur du port `Environments="Jenkins_port=` à <mark style="color:red;">8090</mark> &#x20;
5. Redémarrer le daemon systemctl : `sudo systemctl daemon-reload`
6. Redémarrer le service Jenkins : `sudo systemctl restart jenkins`
7. Vérifier que le service Jenkins est bien démarré : `sudo systemctl status jenkins`

## Première connexion à Jenkins

L'accès à la console Jenkins se fait via l'URL ci-dessous :

`http://`_<mark style="color:red;">`<IP publique de la VM>`</mark>_`:8090`

Lors de la prmière connexion à Jenkins, utiliser le mot de passe Admin initial qui est stocké dans le fichier : `/var/lib/jenkins/secrets/initialAdminPassword`

### Plugins suggérés

Sélectionner l'installation des plugins suggérés (plugins par défaut de Jenkins)

![](../../.gitbook/assets/jenkins1.png)

### Création d'un utilisateur admin

Afin de personnaliser l'installation de Jenkins, créer un utilisateur administrateur avec le nom de votre groupe.&#x20;

Exemple pour le groupe 1 ⇒ `groupe1`

<figure><img src="../../.gitbook/assets/image (26).png" alt=""><figcaption></figcaption></figure>

### Validation de la configuration de l'instance

Vérifier que l'URL Jenkins correspond bien à la configuration demandée

`http://`_<mark style="color:red;">`<IP publique de la VM>`</mark>_`:8090`

<figure><img src="../../.gitbook/assets/image (27).png" alt=""><figcaption></figcaption></figure>

### Jenkins est installé

Puis cliquer sur `Start using Jenkins`

<figure><img src="../../.gitbook/assets/image (29).png" alt=""><figcaption></figcaption></figure>

<mark style="color:red;">**Bravo ! Vous êtes connectés à votre instance Jenkins**</mark> :thumbsup:

<figure><img src="../../.gitbook/assets/image (23).png" alt=""><figcaption></figcaption></figure>
