#!/bin/bash
# ==============================================================================
# Script: build_push_image.sh (order-service)
# Deskripsi: Skrip automasi untuk build image Docker order-service dan melakukan
#            push ke GitHub Container Registry (ghcr.io).
# Penggunaan: ./build_push_image.sh
# ==============================================================================

# Menghentikan eksekusi skrip seketika jika ada perintah yang gagal (non-zero exit)
set -e

# Menentukan tag nama image lengkap di GitHub Container Registry
IMAGE_NAME="ghcr.io/alifkha7/order-service:latest"

# Direktori konteks Dockerfile (folder saat ini)
CONTEXT_DIR="."

echo "=========================================================="
echo "Memulai proses build container image untuk Order Service..."
echo "Target Image: ${IMAGE_NAME}"
echo "=========================================================="

# 1. Melakukan build Docker image menggunakan Dockerfile lokal
docker build -t "${IMAGE_NAME}" "${CONTEXT_DIR}"

echo "=========================================================="
echo "Build image berhasil! Melakukan login ke GHCR..."
echo "=========================================================="

# 2. Login ke GitHub Container Registry menggunakan environment variable GITHUB_TOKEN atau PASSWORD_DOCKER_HUB
if [ -n "${GITHUB_TOKEN}" ]; then
  echo "${GITHUB_TOKEN}" | docker login ghcr.io -u "alifkha7" --password-stdin
elif [ -n "${PASSWORD_DOCKER_HUB}" ]; then
  echo "${PASSWORD_DOCKER_HUB}" | docker login ghcr.io -u "alifkha7" --password-stdin
else
  echo "[PERINGATAN] Environment variable GITHUB_TOKEN atau PASSWORD_DOCKER_HUB belum di-set."
  echo "Mencoba push menggunakan sesi autentikasi docker yang sedang aktif..."
fi

echo "=========================================================="
echo "Memulai proses push image ke GitHub Container Registry..."
echo "=========================================================="

# 3. Melakukan push image ke GitHub Container Registry
docker push "${IMAGE_NAME}"

echo "=========================================================="
echo "SUKSES: Image ${IMAGE_NAME} berhasil dipublikasikan ke GHCR!"
echo "=========================================================="
