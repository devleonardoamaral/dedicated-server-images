FROM steamcmd/steamcmd:latest

RUN dpkg --add-architecture i386 && apt-get update
RUN apt-get install -y libstdc++6:i386 libgcc1:i386 libcurl4-gnutls-dev
RUN steamcmd +login anonymous +app_update 343050 +quit

COPY ./data/start_server.sh /root/

ENTRYPOINT ["/root/start_server.sh"]
CMD [""]
