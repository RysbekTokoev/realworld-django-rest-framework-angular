FROM node:20-slim AS base 
# Совет: Node 25 очень свежая, для прода лучше 20-LTS или 22
WORKDIR /build
COPY package*.json ./
RUN npm install
COPY . .

FROM base AS dev
EXPOSE 4200
CMD ["npm", "start", "--", "--host", "0.0.0.0"]

FROM base AS build
RUN npm run build -- --configuration=production
# Диагностика: Docker покажет в логах, где именно лежат файлы
RUN ls -R dist/

FROM nginx:alpine AS prod
# Используем /. чтобы скопировать именно файлы ИЗ папки browser в корень html
COPY --from=build /build/dist/frontend/browser/. /usr/share/nginx/html/

# Удаляем дефолтный конфиг, чтобы наш точно стал главным
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
