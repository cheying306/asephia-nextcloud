# 透過 sed 替換成 Docker Hub 用戶名
FROM DOCKER_USERNAME/nextcloud:latest

# 設定環境變數，確保非互動模式
ENV DEBIAN_FRONTEND=noninteractive

# 更新 `apt` 並安裝 `smbclient` 相關依賴
RUN apt-get update && \
    apt-get install -y --no-install-recommends smbclient libsmbclient-dev libmagickwand-dev && \
    rm -rf /var/lib/apt/lists/*

# 安裝 `smbclient` 擴展，確保對應 PHP 版本
RUN pecl install smbclient && \
    echo "extension=smbclient.so" > /usr/local/etc/php/conf.d/docker-php-ext-smbclient.ini

# 確保容器啟動時不會因服務錯誤崩潰
CMD ["apache2-foreground"]
