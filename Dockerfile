# 使用官方 Nextcloud 映像檔作為基礎映像檔
FROM nextcloud:latest

# 安裝 smbclient
RUN apt-get update && \
    apt-get install -y smbclient && \
    apt-get clean

# 安裝 PHP smbclient 擴展
RUN apt-get install -y libsmblib0 libsmblib-dev \
    && pecl install smbclient \
    && docker-php-ext-enable smbclient

# 複製配置文件
COPY php.ini /usr/local/etc/php/conf.d/20-smbclient.ini

# 重啟 PHP-FPM 服務 (如果需要)
# RUN service php8.1-fpm restart