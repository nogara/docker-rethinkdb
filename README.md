docker-rethinkdb
----------------
This container runs rethinkdb.

Running manually
----------------
    docker build -t edgard/rethinkdb .
    docker run -d --name rethinkdb -p 8080:8080 -p 28015:28015 -p 29015:29015 -v /srv/rethinkdb:/data edgard/rethinkdb

Running with make tasks
-----------------------
* **build**: build image
* **start**: start container in background
* **test**: start temporary test container *rethinkdb-test*
* **test-stop**: stop and remove temporary test container
* **run**: start interactive container
* **push**: push image to docker hub

Check *Makefile* for additional information.
