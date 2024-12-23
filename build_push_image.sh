#!/bin/bash

# Menghentikan eksekusi jika terjadi error
set -e

# Variabel nama dan tag image
IMAGE_NAME="item-app"
IMAGE_TAG="v1"
GITHUB_USER="alifkha7"
GITHUB_REPO="a433-microservices"
GITHUB_REGISTRY="ghcr.io/${GITHUB_USER}/${IMAGE_NAME}"

# Membuat Docker image dengan nama item-app dan tag v1
echo "Building Docker image..."
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

# Menampilkan daftar image di lokal
echo "Listing Docker images..."
docker images

# Menandai ulang image agar sesuai dengan format GitHub Packages
echo "Tagging Docker image for GitHub Packages..."
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${GITHUB_REGISTRY}:${IMAGE_TAG}

# Login ke GitHub Container Registry
echo "Logging in to GitHub Container Registry..."
echo "${GITHUB_PAT}" | docker login ghcr.io -u ${GITHUB_USER} --password-stdin

# Push image ke GitHub Packages
echo "Pushing Docker image to GitHub Packages..."
docker push ${GITHUB_REGISTRY}:${IMAGE_TAG}

echo "Docker image has been successfully pushed to GitHub Packages as ${GITHUB_REGISTRY}:${IMAGE_TAG}"
