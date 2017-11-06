# Jongleur

This is an experimental implementation of an OIDC provider.

Some more specs will be implemented just for enjoyment and study.

## Deploy

- Configurations

  1. Change the exported port of **front** in the docker-compose.yml
  1. Change the API_URI in the Makefile

- Generate keys for jongleur_back (Both pem and der are needed for some reasons).

```
$ cd jongleur_back/res
$ openssl genrsa 4096 > jongleur_jwt_key_private.pem
$ openssl rsa -in jongleur_jwt_key_private.pem -pubout -out jongleur_jwt_key_public.pem
$ openssl rsa -in jongleur_jwt_key_private.pem -out jongleur_jwt_key_private.der -outform der
$ openssl rsa -pubin -in jongleur_jwt_key_public.pem -out jongleur_jwt_key_pub.der -outform der
```

- Build, Run and Terminate

```
$ make build
$ make run
$ make init # This task creates some indexes for MongoDB
$ make terminate
```
