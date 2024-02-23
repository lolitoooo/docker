FROM nginx:alpine

RUN apk add --no-cache php php-fpm php-pdo_mysql php-mbstring php-exif php-pcntl php-bcmath php-gd php-fileinfo php-tokenizer php-dom php-xml php-xmlwriter php-session

RUN apk update && apk upgrade

RUN apk add composer nodejs npm

EXPOSE 9000

WORKDIR /app/

COPY laravel /app

COPY nginx.conf /etc/nginx/nginx.conf

COPY .env /app

RUN composer install

RUN npm install

RUN php artisan key:generate

RUN apk add dos2unix

COPY script.sh /script.sh

RUN chmod +x /script.sh

RUN dos2unix /script.sh

CMD ["/script.sh"]