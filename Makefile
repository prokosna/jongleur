.PHONY: build run init terminate

API_URI := http://127.0.0.1:8088/api/v1
FRONT_DIR := jongleur_front

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

