FROM nginx:1.13.5-alpine

ADD nginx.conf /etc/nginx/nginx.conf
ADD conf.d /etc/nginx/conf.d/
ADD sites-enabled /etc/nginx/sites-enabled/

ADD jongleur_front/index.html /app/index.html
ADD jongleur_front/dist /app/dist
