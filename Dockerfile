##### 01- Build app
FROM node:lts-alpine as node
LABEL author="Waqas Dilawar"
WORKDIR /app
COPY package.json yarn.lock ./
RUN npm install
COPY . .
RUN npm run build

##### 02- Run NGINX using build from step 01
FROM nginx:alpine
VOLUME /var/cache/nginx
COPY --from=node /app/dist /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf

# docker build -t nginx-vue-test .
# docker run -p 8080:80 nginx-vue-test
