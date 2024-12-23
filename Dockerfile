# Menggunakan base image Node.js versi 14
FROM node:14

# Menentukan working directory di container
WORKDIR /app

# Menyalin seluruh source code ke working directory di container
COPY . .

# Menentukan environment variables
ENV NODE_ENV=production
ENV DB_HOST=item-db

# Menginstal dependencies dan build aplikasi
RUN npm install --production --unsafe-perm && npm run build

# Mengekspos port yang digunakan oleh aplikasi
EXPOSE 8080

# Menjalankan server saat container diluncurkan
CMD ["npm", "start"]
