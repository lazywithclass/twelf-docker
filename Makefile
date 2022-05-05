BUILD_NAME = twelf-build
CONTAINER_NAME = twelf-container

build:
	docker build -t ${BUILD_NAME} .

connect:
	docker run -v ~/.:/workspace --rm -it ${BUILD_NAME} /bin/bash
