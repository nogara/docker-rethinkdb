NAME=rethinkdb
REPO=edgard/$(NAME)

.PHONY: build start test test-stop run push

all: build

build:
	docker build -t $(REPO) .

start:
	docker run -d --name $(NAME) -p 8080:8080 -p 28015:28015 -p 29015:29015 /srv/$(NAME):/data $(REPO)

test:
	mkdir -p data
	docker run -d --name $(NAME)-test -p 8080:8080 -p 28015:28015 -p 29015:29015 -v /tmp/$(NAME)-test:/data $(REPO)

test-stop:
	docker stop $(NAME)-test
	docker rm $(NAME)-test

run:
	docker run -t -i -v /tmp/$(NAME)-run/data:/data -p 8080:8080 -p 28015:28015 -p 29015:29015 --rm $(REPO) /bin/bash

push:
	docker push $(REPO)
