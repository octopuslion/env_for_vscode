FROM mysql:8.0.33-debian

# change resources of apt.
RUN apt-get -v
COPY ./debian.sources.list.http /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get install -y ca-certificates
COPY ./debian.sources.list /etc/apt/sources.list
RUN apt-get update

# install apps.
RUN apt-get install -y vim

CMD ["mysqld"]