# 透過 sed 替換成 Docker Hub 用戶名
FROM DOCKER_USERNAME/nextcloud:latest

# 安裝 smbclient
RUN apt-get update && \
    apt-get install -y smbclient libsmbclient-dev && \
    pecl install smbclient && \
    docker-php-ext-enable smbclient && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*  # 清理不再需要的 apt 緩存

# 複製自定義的 php.ini 配置文件
COPY php.ini /usr/local/etc/php/conf.d/20-smbclient.ini

# 如果需要，您可以重啟 PHP-FPM 服務，根據您的環境來決定是否需要這一步
# RUN service php8.1-fpm restart   # 在 Nextcloud 的容器中，這通常不需要手動執行
