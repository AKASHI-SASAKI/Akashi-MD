FROM node:lts-buster

# Mise à jour du système et installation des dépendances nécessaires
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

# Copier le fichier package.json pour installer les dépendances
COPY package.json .

# Installation des packages Node.js et installation globale de pm2
RUN npm install && npm install -g qrcode-terminal pm2

# Copier tout le contenu du répertoire courant dans le conteneur
COPY . .

# Exposer le port 3000 pour le service
EXPOSE 3000

# Démarrage de l'application avec pm2
CMD ["pm2-runtime", "start", "index.js", "--name", "Akashi-MD"]
