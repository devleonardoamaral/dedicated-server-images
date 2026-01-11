FROM steamcmd/steamcmd:latest

ARG APP_CODE

RUN steamcmd +login anonymous +app_update ${APP_CODE} +quit

ENTRYPOINT []
CMD ["/bin/sh"]
