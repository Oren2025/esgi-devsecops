# 3. TP DevSecOps

Le pipeline DevSecOps est décrit via le schéma ci-dessous.

En utilisant Jenkins, vous allez définir les différentes étapes du workflow&#x20;

* Check-out du repo
* Compilation Maven / Test Maven
* Analyse Sonarqube / Quality gate
* Build du fichier war avec Maven
* Vérification OWASP des dépendances
* Build et upload de l'image Docker
* Analyse de vulnérabilité de l'image Docker avec Trivy
* Déploiement en Docker
* Déploiement vers un cluster K8s

![](../.gitbook/assets/architecture.jpg)
