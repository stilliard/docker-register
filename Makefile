
build:
	sudo docker build -t docker-register .

push:
	sudo docker tag -f docker-register stilliard/docker-register:latest
	sudo docker push stilliard/docker-register:latest

