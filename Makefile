ubuntu1804:
	docker build -t kilip/molecule-ubuntu1804:latest . -f ubuntu1804.Dockerfile
	docker push kilip/molecule-ubuntu1804:latest
ubuntu16.04:
	docker build -t kilip/molecule-ubuntu1804:latest . -f ubuntu1804.Dockerfile
	docker push kilip/molecule-ubuntu1804:latest