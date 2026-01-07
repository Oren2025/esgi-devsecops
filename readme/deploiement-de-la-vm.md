---
description: Comment déployer l'instance EC2 utilisé pour le TP
---

# Déploiement de la VM

## Installation de terraform&#x20;

Installer Terraform si celui-ci n'est pas présent sur votre poste de travail.

Informations disponibles sur le site Hashicorp :point\_down:

{% embed url="https://developer.hashicorp.com/terraform/install" %}

## Fork du repository

Faire un fork du repository ci-dessous afin d'avoir votre repository sous votre identifiant GitHub

{% embed url="https://github.com/smontri/esgi-devsecops.git" %}

<figure><img src="../.gitbook/assets/image (4) (1) (1).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Bouton fork depuis la page GitHub du repository
{% endhint %}

## Clone du repository

Faire un clone de votre repository sur votre poste de travail en utilisant la commande `git clone`

{% hint style="danger" %}
Attention de bien cloner localement <mark style="color:red;">**VOTRE**</mark> repository
{% endhint %}

## Templates terraform

Le répertoire terraform contient les templates AWS et Azure pour le déploiement de l'infrastructure.

Dans le cadre de ce TP, nous allons utiliser AWS avec le lab mis à disposition par votre intervenant.

<figure><img src="../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/image (3) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

## Déploiement avec Terraform

{% hint style="warning" %}
Se placer dans le dossier `terraform/aws`
{% endhint %}

### Installation et configuration de la CLI AWS

{% hint style="info" %}
S'assurer que la CLI AWS est bien installée sur son poste de travail
{% endhint %}

{% embed url="https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html" %}

Pour configurer la CLI, utiliser la commande `aws configure` en renseignant les credentials fournis par le lab AWS

{% hint style="warning" %}
Il faut également ajouter la token dans le fichier `credentials` de la configuration AWS
{% endhint %}

### Initialisation de Terraform

Il s'agit d'initialiser l'environnement Terraform pour charger les providers nécessaires

Pour cela nous allons utiliser la commande `terraform init`

```bash
terraform init
```

<figure><img src="../.gitbook/assets/image (4) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Planification du déploiement

La planification permet de valider le code terraform et d'identifier les objets qui vont être crées par le déploiement.

Pour cela, nous allons utiliser la commande `terraform plan`

```hcl
terraform plan
```

<figure><img src="../.gitbook/assets/image (5) (1).png" alt=""><figcaption></figcaption></figure>

Le résultat de la commande `terraform plan` indique le nombre de ressources qui vont être crées, mises à jour ou supprimées ainsi que les informations d'output telles que décrit dans les templates Terraform.

<figure><img src="../.gitbook/assets/image (6) (1).png" alt=""><figcaption></figcaption></figure>

### Déploiement de la VM

Le déploiement se fait via la commande `terraform apply` qui exécute le plan de déploiement généré préalablement.

```hcl
terraform apply
```

<figure><img src="../.gitbook/assets/image (8) (1).png" alt=""><figcaption></figcaption></figure>

Le résultat de la commande `terraform apply` indique le résultat du déploiement.

<figure><img src="../.gitbook/assets/image (10) (1).png" alt=""><figcaption></figcaption></figure>



