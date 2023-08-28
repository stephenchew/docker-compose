# Motorhead

Motorhead requires Redis as the persisted storage.

There are 2 docker-compose files to deploye motorhead: -

### `docker-compose-ext.yml`
This deployement presumes that there an instance of Redis running in a Docker container in the network `redis-stack_lan`.

### `docker-compose-bundled.yml`
This deployment first deploys redis-stack, followed by motorhead. Everything is bundled so no external deployment is required.
