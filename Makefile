.PHONY: build

FRONT_DIR := jongleur_front

build:
	@NODE_ENV=production \
	cd $(FRONT_DIR) && \
	npm i && \
	npm run build && \
	cd .. && \
	docker-compose build
