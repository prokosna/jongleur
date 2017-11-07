.PHONY: keys build run init terminate

API_URI := http://127.0.0.1:8088/api/v1
FRONT_DIR := jongleur_front
BACK_DIR := jongleur_back

keys:
	cd $(BACK_DIR)/res && \
	openssl genrsa 4096 > jongleur_jwt_key_private.pem && \
	openssl rsa -in jongleur_jwt_key_private.pem -pubout -out jongleur_jwt_key_public.pem && \
	openssl rsa -in jongleur_jwt_key_private.pem -out jongleur_jwt_key_private.der -outform der && \
	openssl rsa -pubin -in jongleur_jwt_key_public.pem -out jongleur_jwt_key_public.der -outform der

build:
	export API_URI=$(API_URI) && \
	cd $(FRONT_DIR) && \
	npm i && \
	npm run build && \
	cd .. && \
	docker-compose build

run:
	docker-compose up -d

init:
	docker-compose exec db mongo --eval "db.getSiblingDB('jongleur').createUser({user:'jongleur',pwd:'password',roles:[{role:'readWrite',db:'jongleur'}]});"
	docker-compose exec db mongo --eval "db.getSiblingDB('jongleur').access_tokens.createIndex({token:1},{unique:true});"
	docker-compose exec db mongo --eval "db.getSiblingDB('jongleur').clients.createIndex({name:1},{unique:true});"
	docker-compose exec db mongo --eval "db.getSiblingDB('jongleur').end_users.createIndex({name:1},{unique:true});"
	docker-compose exec db mongo --eval "db.getSiblingDB('jongleur').end_users.createIndex({email:1},{unique:true});"
	docker-compose exec db mongo --eval "db.getSiblingDB('jongleur').grants.createIndex({code:1},{unique:true});"
	docker-compose exec db mongo --eval "db.getSiblingDB('jongleur').id_tokens.createIndex({token:1},{unique:true});"
	docker-compose exec db mongo --eval "db.getSiblingDB('jongleur').resources.createIndex({name:1},{unique:true});"

terminate:
	docker-compose down

