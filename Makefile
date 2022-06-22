# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

tao-docker-run: ## TAO用コンテナを建てる
	docker-compose -f docker-compose.yaml up -d

tao-docker-build: ## TAO用コンテナをビルド
	docker-compose -f docker-compose.yaml build


# Set dimensions of desired output model for inference/deployment
INPUT_SHAPE := 288x384x3
OPT_SHAPE := 240x340x3
MAX_SHAPE := 288x400x3
# Set input name
INPUT_NAME := input_1:0
# Set opt profile shapes
MAX_BATCH_SIZE := 32
OPT_BATCH_SIZE := 32
tao-convert:
	docker exec -it bodyposenet-tao-tool-kit tao-converter -k nvidia_tlt \
	-p $(INPUT_NAME),1x$(INPUT_SHAPE),$(OPT_BATCH_SIZE)x$(INPUT_SHAPE),$(MAX_BATCH_SIZE)x$(INPUT_SHAPE) \
	 -o heatmap_out/BiasAdd:0,conv2d_transpose_1/BiasAdd:0  -e /app/src/bodyposenet.engine -u 1  -m 8 -t fp16  /app/src/bodyposenet.etlt 
#	cp bodyposenet.engine ../bodyposenet-on-deepstream/
tao-docker-login: ## TAO用コンテナにログイン
	docker exec -it bodyposenet-tao-tool-kit bash


