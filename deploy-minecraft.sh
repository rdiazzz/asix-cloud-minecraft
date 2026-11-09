#!/bin/bash

# Evita que aparezcan preguntas durante la instalacion
export DEBIAN_FRONTEND=noninteractive

# Actualizamos los repositorios y el sistema
apt update -y
apt upgrade -y

# Instalamos Docker
apt install -y docker.io

# Activamos Docker para que arranque automaticamente
systemctl enable docker
systemctl start docker

# Creamos la carpeta donde se guardaran los datos de Minecraft
mkdir -p /home/ubuntu/minecraft-data

# Eliminamos un contenedor anterior si existiera
docker rm -f minecraft-server 2>/dev/null || true

# Descargamos y arrancamos el servidor de Minecraft
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
