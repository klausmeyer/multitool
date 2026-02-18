.DEFAULT_GOAL := run

build:
	docker build -t klausmeyer/multitool:latest .

run: build
	docker run -it --rm klausmeyer/multitool:latest

shell: build
	docker run -it --rm klausmeyer/multitool:latest bash
