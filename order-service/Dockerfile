# ==============================================================================
# Dockerfile: order-service
# Mengemas aplikasi Node.js Express Order Service ke dalam OCI container image
# ==============================================================================

# 1. Menggunakan base image resmi Node.js versi 14 LTS berbasis Alpine Linux yang ringan
FROM node:14-alpine

# 2. Menentukan direktori kerja utama di dalam container
WORKDIR /app

# 3. Menyalin berkas manifest dependensi package.json dan package-lock.json terlebih dahulu
# Langkah ini memaksimalkan caching layer Docker saat tidak ada perubahan dependensi
COPY package*.json ./

# 4. Menginstal seluruh dependensi aplikasi secara bersih sesuai definisi lockfile
RUN npm install

# 5. Menyalin seluruh sisa kode sumber aplikasi dari direktori lokal ke dalam container
COPY . .

# 6. Mendefinisikan port jaringan yang dibuka oleh container (port 3000 untuk order-service)
EXPOSE 3000

# 7. Menjalankan aplikasi Node.js menggunakan perintah npm start saat container diinisialisasi
CMD ["npm", "start"]
