
Run your postgreSQL docker container!
=====================================

Step 0 (Configure)
------

First place your configuration files `ph_hba.conf` and `postgresql.conf` for postgresql

The default changes are:

In  `postresql.conf`:

    data_directory = '/data'
    listen_addresses = '*'

In `pg_hba.conf`:

    host    all             all             0.0.0.0/0               md5

Then set the first user, password and DB for Postgres in `default_user.sh`:

    USER="docker"
    PASS="docker"
    DB="docker"


Step 1 (Build containers)
-------------------------

    $ docker build -t slok/postgresql-data:1.0 ./postgresql-data/
    $ docker build -t slok/postgresql:1.0 ./postgresql

Step 2 (Data container)
-----------------------

Run the data container if isn't  already created/stopped-container:

    $ docker run --name postgresql-data slok/postgresql-data:1.0

Step 3 (postgresql)
-------------------

    $ docker run -d --volumes-from="postgresql-data" --name=postgres slok/postgresql:1.0

Extra
-----

If you want to connect to the database you could use the psql client from the same container
running a new one like this:

    $ docker run --rm -it --link postgres:db slok/postgresql:1.0 /bin/bash

And then inside the container (docker is the default user, change it if you want):

    $ psql -h $DB_PORT_5432_TCP_ADDR -U docker






