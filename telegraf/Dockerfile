FROM telegraf:1.17

RUN apt-get update
RUN apt-get install -y cron

COPY entrypoint.sh get_aggregates.sh get_soe.sh /
