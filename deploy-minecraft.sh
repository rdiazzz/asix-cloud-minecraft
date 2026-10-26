#!/bin/bash

# Evitar preguntes durant la instal·lació
export DEBIAN_FRONTEND=noninteractive

# Aturar l'execució si alguna ordre falla
set -e

# Actualitzar els paquets del sistema
apt-get update -y
apt-get upgrade -y

# Instal·lar Docker
apt-get install -y docker.io curl

# Activar Docker perquè s'iniciï automàticament
systemctl enable --now docker

# Crear la carpeta on es guardaran les dades de Minecraft
mkdir -p /home/ubuntu/minecraft-data

# Assignar la carpeta a l'usuari ubuntu
chown -R ubuntu:ubuntu /home/ubuntu/minecraft-data

# Eliminar un contenidor anterior amb el mateix nom, si existeix
if docker container inspect minecraft-server >/dev/null 2>&1; then
    docker rm -f minecraft-server
fi

# Descarregar i iniciar el servidor de Minecraft
docker run -d \
    --name minecraft-server \
    --restart unless-stopped \
    -p 25565:25565 \
    -v /home/ubuntu/minecraft-data:/data \
    -e EULA=TRUE \
    -e ENABLE_AUTOPAUSE=FALSE \
    -e ONLINE_MODE=FALSE \
    -e MOTD="Server Ricardo Alejandro Diaz Castillo" \
    itzg/minecraft-server

# Mostrar informació del contenidor
docker ps
