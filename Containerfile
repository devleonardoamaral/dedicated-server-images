FROM eclipse-temurin:25

# Create game dir
RUN mkdir -p /srv/hytale /srv/host

# Install tools
RUN apt-get update \
    && apt-get install -y curl unzip \
    && rm -rf /var/lib/apt/lists/*

# Download installer
RUN curl https://downloader.hytale.com/hytale-downloader.zip -o /tmp/hytale-downloader.zip \
    && unzip /tmp/hytale-downloader.zip -d /tmp/hytale/ \
    && rm /tmp/hytale-downloader.zip \
    && /tmp/hytale/hytale-downloader-linux-amd64 -download-path /tmp/game.zip \
    && rm -rf /tmp/hytale \
    && unzip /tmp/game.zip -d /srv/hytale/ \
    && rm /tmp/game.zip

COPY ./scripts/bootstrap.sh /root/bootstrap.sh
RUN chmod +x /root/bootstrap.sh

WORKDIR /srv/data

ENTRYPOINT [ "/root/bootstrap.sh" ]
CMD ["java", "-jar", "./HytaleServer.jar", "--assets", "/srv/hytale/Assets.zip"]
