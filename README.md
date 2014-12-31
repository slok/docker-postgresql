
Run your postgreSQL docker container!
=====================================

Step 1 (Build containers)
-------------------------

    $ docker build -t slok/postgresql-data:1.0 ./postgresql-data/

Step 2 (Data container)
-----------------------

Run the data container if isn't  already created/stopped-container:

    $ docker run --name postgresql-data slok/postgresql-data:1.0

Step 3 (postgresql)
-------------------




