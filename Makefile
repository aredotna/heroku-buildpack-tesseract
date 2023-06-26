build:
	@echo "Building Tesseract in docker for heroku-22"
	docker run --platform linux/amd64 -v $(shell pwd):/src --rm -it heroku/heroku:22 bash /src/build.sh heroku-22
	@echo ""
