# SonarQube

SonarQube est un outil SAST qui permet l'analyse de sécurité du code. Dans le cadre de ce TP, SonarQube est exécuté sous forme de conteneur.

## Installation de SonarQube

```shell
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
```

Une fois le conteneur déployé, vérifiez qu'il est bien démarré et en état [`running`](#user-content-fn-1)[^1].

![Liste des conteneurs](../../.gitbook/assets/docker-sonarqube.jpg)

## Connnexion à SonarQube

`http://`_<mark style="color:red;">`<IP publique de la VM>`</mark>_`:9000`

Les credentials à utiliser pour la première connexion sont `admin/admin`.

{% hint style="info" %}
SonarQube vous demande de modifier le mot de passe admin à la première connexion
{% endhint %}

Voici la console de SonarQube :

![](../../.gitbook/assets/sonarqube1.jpg)

###

[^1]: 
