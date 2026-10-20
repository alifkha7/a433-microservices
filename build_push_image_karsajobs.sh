#!/bin/bash
# ==============================================================================
# Script: build_push_image_karsajobs.sh
# Deskripsi: Skrip automasi untuk melakukan build image Docker karsajobs (Backend)
#            dan melakukan push ke GitHub Container Registry (ghcr.io).
# Penggunaan: ./build_push_image_karsajobs.sh
# ==============================================================================

# Menghentikan eksekusi skrip seketika jika ada perintah yang menghasilkan kode error (non-zero exit)
set -e

# Nama target image lengkap di GitHub Container Registry (GHCR)
# Format: ghcr.io/<username-github>/karsajobs:latest
IMAGE_NAME="ghcr.io/alifkha7/karsajobs:latest"

# Direktori konteks Dockerfile (lokasi saat ini di folder backend)
CONTEXT_DIR="."

echo "=========================================================="
echo "Memulai proses build container image untuk Karsa Jobs API..."
echo "Target Image: ${IMAGE_NAME}"
echo "=========================================================="

# 1. Melakukan build Docker image menggunakan Dockerfile yang tersedia di direktori lokal
docker build -t "${IMAGE_NAME}" "${CONTEXT_DIR}"

echo "=========================================================="
echo "Build image berhasil! Melakukan login ke GHCR..."
echo "=========================================================="

# 2. Login ke GitHub Container Registry menggunakan environment variable GITHUB_TOKEN atau PASSWORD_DOCKER_HUB
# Penggunaan --password-stdin mencegah tereksposnya token/password pada riwayat perintah shell
if [ -n "${GITHUB_TOKEN}" ]; then
  # Menggunakan token GitHub jika tersedia di environment
  echo "${GITHUB_TOKEN}" | docker login ghcr.io -u "alifkha7" --password-stdin
elif [ -n "${PASSWORD_DOCKER_HUB}" ]; then
  # Fallback menggunakan variabel PASSWORD_DOCKER_HUB sesuai konvensi modul
  echo "${PASSWORD_DOCKER_HUB}" | docker login ghcr.io -u "alifkha7" --password-stdin
else
  echo "[PERINGATAN] Environment variable GITHUB_TOKEN atau PASSWORD_DOCKER_HUB belum di-set."
  echo "Mencoba push menggunakan sesi autentikasi docker yang sedang aktif..."
fi

echo "=========================================================="
echo "Memulai proses push image ke GitHub Container Registry..."
echo "=========================================================="

# 3. Melakukan push image yang telah selesai di-build ke container registry tujuan
docker push "${IMAGE_NAME}"

echo "=========================================================="
echo "SUKSES: Image ${IMAGE_NAME} berhasil dipublikasikan ke GHCR!"
echo "=========================================================="
