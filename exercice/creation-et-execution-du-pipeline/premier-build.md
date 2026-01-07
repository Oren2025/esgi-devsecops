# Premier build

## Création du projet

Créer un item dans Jenkins de type `Pipeline` que vous nommez `petstore`

<figure><img src="../../.gitbook/assets/image (36).png" alt=""><figcaption></figcaption></figure>

Et utliser le code ci-dessous pour définir le workflow du pipeline dans le bloc `Pipeline`

<pre class="language-javascript"><code class="lang-javascript"><strong>pipeline{
</strong>    agent any
    tools {
        jdk 'jdk17'
        maven 'maven3'
    }
    stages{
        stage ('clean Workspace'){
            steps{
                cleanWs()
            }
        }
        stage ('checkout scm') {
            steps {
                git 'https://github.com/smontri/jpetstore-6.git'
            }
        }
        stage ('maven compile') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage ('maven Test') {
            steps {
                sh 'mvn test'
            }
        }
   }
}
</code></pre>

{% hint style="danger" %}
<mark style="color:orange;">**Utiliser votre fork du repository dans le stage**</mark><mark style="color:orange;">**&#x20;**</mark><mark style="color:orange;">**`checkout scm`**</mark>
{% endhint %}

<figure><img src="../../.gitbook/assets/image (3) (1) (1).png" alt=""><figcaption></figcaption></figure>

## Lancer le build du pipeline

Pour lancer le premier build, cliquer sur `Build Now`

<figure><img src="../../.gitbook/assets/image (37).png" alt="" width="348"><figcaption></figcaption></figure>

{% hint style="info" %}
Lors du premier lancement, cette étape peut prendre un peu de temps...
{% endhint %}

Le résultat doit ressembler à cela

<figure><img src="../../.gitbook/assets/image (2) (1) (1).png" alt=""><figcaption></figcaption></figure>
