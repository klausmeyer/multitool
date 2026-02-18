.DEFAULT_GOAL := run

build:
	docker build -t klausmeyer/multitool:latest \
		--build-arg SOURCE_VERSION=dev \
		--build-arg SOURCE_COMMIT="$$(git rev-parse HEAD)" \
		.

run: build
	docker run -it --rm klausmeyer/multitool:latest

shell: build
	docker run -it --rm klausmeyer/multitool:latest bash
