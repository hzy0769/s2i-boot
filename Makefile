IMAGE_NAME = hzy0769/s2i-springboot
CURRENT_DATE = $(shell date +'%Y%m%d')
# CURRENT_DATE=`date +'%y.%m.%d %H:%M:%S'`

build:
	docker build -t $(IMAGE_NAME) --build-arg BUILD_DATE="${CURRENT_DATE}" .

.PHONY: test
test:
	docker build -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate BUILDER=maven test/run