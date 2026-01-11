#!/bin/bash
set -euo pipefail

echo "[1/6] Pré-requis"
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release wget apt-transport-https

echo "[2/6] Keyrings (obligatoire pour éviter les erreurs de permission)"
sudo install -m 0755 -d /etc/apt/keyrings

echo "[3/6] (Optionnel) Trivy - repo officiel si disponible, sinon fallback binaire"
# Repo Trivy (peut échouer sur Debian trixie -> 404)
if curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key >/dev/null 2>&1; then
  curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

  echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/trivy.list > /dev/null

  if sudo apt-get update -y && sudo apt-get install -y trivy; then
    echo "Trivy installé via APT."
  else
    echo "Repo Trivy non compatible (ex: Debian trixie). Fallback binaire..."
    TRIVY_VERSION="0.59.1"
    wget -qO /tmp/trivy.deb "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.deb"
    sudo dpkg -i /tmp/trivy.deb || sudo apt-get -f install -y
  fi
else
  echo "Impossible de récupérer la clé Trivy. Skip Trivy (à installer plus tard si besoin)."
fi

echo "[4/6] Java 17 (Temurin si disponible, sinon OpenJDK)"
# Adoptium (Temurin) - OK si le paquet existe déjà dans ta config, sinon OpenJDK
if apt-cache policy temurin-17-jdk | grep -q Candidate; then
  sudo apt-get install -y temurin-17-jdk
else
  sudo apt-get install -y openjdk-17-jdk
fi
java -version

echo "[5/6] Jenkins (repo officiel Jenkins)"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y jenkins

echo "[6/6] Démarrage Jenkins"
sudo systemctl daemon-reload
sudo systemctl reset-failed jenkins || true
sudo systemctl enable --now jenkins
sudo systemctl status jenkins --no-pager

echo "Mot de passe admin initial :"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword || true
