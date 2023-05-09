all: build dist

build:
	./result/bin/hakyll-site build

watch:
	./result/bin/hakyll-site watch

rebuild:
	nix-build
# z option is important to avoid re-uploading everything
# it must be at the beginning
# We need a wilcard to avoid an html folder
dist:
	ncftpput -z -f login.cfg -R . _site/*
	ncftpput -z -f login.cfg -R . files/*
