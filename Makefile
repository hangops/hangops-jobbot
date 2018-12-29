interactive:
	docker-compose run --rm app hubot --name hangbot

run: build
	docker-compose run app

build:
	docker-compose build
