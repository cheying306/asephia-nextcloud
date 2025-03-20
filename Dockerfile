# 透過 sed 替換成 Docker Hub 用戶名
FROM DOCKER_USERNAME/nextcloud:latest

# 安裝 smbclient
RUN apt-get update && \
    apt-get install -y smbclient && \
    apt-get clean

# 安裝 PHP smbclient 擴展
RUN apt-get install -y libsmblib0 libsmblib-dev \
    && pecl install smbclient \
    && docker-php-ext-enable smbclient

# 複製自定義的 php.ini 配置文件
COPY php.ini /usr/local/etc/php/conf.d/20-smbclient.ini

# 如果需要，您可以重啟 PHP-FPM 服務，根據您的環境來決定是否需要這一步
# RUN service php8.1-fpm restart   # 在 Nextcloud 的容器中，這通常不需要手動執行
