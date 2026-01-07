# Déploiement Kubernetes

## Adaptation du déploiement Kubernetes

Il s'agit de remplacer l'image définie dans l'objet `deployment` par celle qui point vers votre compte Docker Hub.

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
Attention cette modification doit être faite dans votre fork du repository `jpestore-6`
{% endhint %}

## Adaptation des variables d'environnement

{% hint style="info" %}
A ajouter dans la section `environment` de la définition du pipeline
{% endhint %}

```javascript
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_SESSION_TOKEN = credentials('AWS_SESSION_TOKEN')
        AWS_DEFAULT_REGION = "us-east-1"
    }
```

## Ajout du step K8s

{% hint style="info" %}
A ajouter à la fin de la liste des steps du workflow
{% endhint %}

```javascript
stage('K8s'){
            steps{
                script {
                    dir('.') {
                        sh "aws eks update-kubeconfig --name esgi-devsecops"
                        sh "kubectl apply -f deployment.yaml"            
                    }
                }
            }
        }
```

Puis lancer un nouveau build, vous pouvez suivre l'exécution du build dans la vue `Pipeline Console`

<figure><img src="../../.gitbook/assets/image (8).png" alt=""><figcaption></figcaption></figure>

Le pipeline doit, à présent, ressembler à ceci :

<figure><img src="../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

## Vérifiez que l'application est bien déployée

Pour vérifier que l'application s'est bien déployée dans le cluster EKS, affichez la liste des pods et deployment du namespace `default`.
