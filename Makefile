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
dist: hut #free

hut:
	cd _site ; tar cvzf site.tar.gz * ; hut pages publish site.tar.gz -d scut.srht.site

free:
	ncftpput -z -f login.cfg -R . _site/*
	ncftpput -z -f login.cfg -R . files/*
