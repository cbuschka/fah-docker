run:	build
	@echo "Connect to localhost:7396 in some moments..."; \
	docker run -p 7396:7396 fah

build:
	docker build -t fah .

