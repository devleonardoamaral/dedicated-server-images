FROM eclipse-temurin:25

# Install tools
RUN apt-get update \
    && apt-get install -y curl unzip \
    && rm -rf /var/lib/apt/lists/*

# Installer bootstrap
COPY ./scripts/bootstrap.sh /root/bootstrap.sh
RUN chmod +x /root/bootstrap.sh

# Create game dir
RUN mkdir -p /srv/hytale
WORKDIR /srv/data

ENTRYPOINT [ "/root/bootstrap.sh" ]
CMD ["java", "-jar", "./HytaleServer.jar", "--assets", "/srv/hytale/Assets.zip"]
