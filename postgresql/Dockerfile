FROM ubuntu:14.04
MAINTAINER Xabier Larrakoetxea <slok69@gmail.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && \
    apt-get -y -q install postgresql-9.4 \
                          postgresql-client-9.4 \
                          postgresql-contrib-9.4


COPY postgresql.conf /etc/postgresql/9.4/main/postgresql.conf
COPY pg_hba.conf /etc/postgresql/9.4/main/pg_hba.conf
RUN chown postgres:postgres /etc/postgresql/9.4/main/*.conf


COPY run.sh /usr/local/bin/run
COPY default_user.sh /etc/default_user.sh
RUN chmod +x /usr/local/bin/run
RUN chmod +x /etc/default_user.sh

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
EXPOSE 5432

CMD ["run"]
