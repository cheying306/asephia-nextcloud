# 使用 Nextcloud 官方映像作為基礎
FROM nextcloud:latest

# 設定環境變數，確保非互動模式
ENV DEBIAN_FRONTEND=noninteractive

# 更新 `apt` 並安裝 `smbclient` 相關依賴
RUN apt-get update && \
    apt-get install -y --no-install-recommends smbclient libsmbclient-dev libmagickwand-dev && \
    rm -rf /var/lib/apt/lists/*

# 安裝 `smbclient` 擴展，確保對應 PHP 版本
RUN if ! php -m | grep -q smbclient; then \
        pecl install smbclient && \
        echo "extension=smbclient.so" > /usr/local/etc/php/conf.d/docker-php-ext-smbclient.ini; \
    else \
        echo "smbclient already installed"; \
    fi

# 確保容器啟動時不會因服務錯誤崩潰
CMD ["apache2-foreground"]
