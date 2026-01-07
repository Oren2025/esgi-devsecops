# Analyse de code

## **Modification du pipeline**

Nous allons ajouter 2 étapes au pipeline ainsi que des informations d'environnement pour l'utilisation du scanner SonarQube.

### Environnement du scanner

{% hint style="info" %}
A ajouter sous la section `tools` de la définition du pipeline
{% endhint %}

```javascript
environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }
```

### Ajout des étapes dans le pipeline

Ajout ces étapes dans le pipeline, à ajouter en fin de liste des `stages`

```java
stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Petshop \
                    -Dsonar.java.binaries=. \
                    -Dsonar.projectKey=Petshop '''
                }
            }
        }
stage("quality gate"){
           steps {
                script {
                  waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token' 
                }
           }
        }
```

Puis lancer un nouveau build, vous pouvez suivre l'exécution du build dans la vue `Pipeline Console`

<figure><img src="../../.gitbook/assets/image (3) (1).png" alt=""><figcaption></figcaption></figure>

Le pipeline doit, à présent, ressembler à ceci :

<figure><img src="../../.gitbook/assets/image (4) (1).png" alt=""><figcaption></figcaption></figure>

## Résultats dans SonarQube

Vous pouvez consulter le résultat de l'analyse SonarQube dans la vue `Projects` de la console SonarQube :

<figure><img src="../../.gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

Ainsi que le détail des problèmes trouvés dans la vue `Issues` de la console SonarQube :

<figure><img src="../../.gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>
