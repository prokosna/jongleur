# Jongleur

This is an experimental implementation of an OIDC provider.

Some more specs will be implemented just for enjoyment and study.

## Deploy

- Configurations

  1. Change the exported port of **front** in the docker-compose.yml
  1. Change the API_URI in the Makefile

- Generate keys for jongleur_back (Both pem and der are needed for some reasons).

```
$ make keys
```

- Build, Run and Terminate

```
$ make build
$ make run
$ make init # This task creates some indexes for MongoDB
$ make terminate
```
