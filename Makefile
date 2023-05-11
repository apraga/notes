all: build dist

build:
	cabal run hakyll-site build

watch:
	cabal run hakyll-site watch

rebuild:
	cabal build

# z option is important to avoid re-uploading everything
# it must be at the beginning
# We need a wilcard to avoid an html folder
dist: hut #free

hut:
	cd _site ; tar cvzf site.tar.gz * ; hut pages publish site.tar.gz -d scut.srht.site

free:
	ncftpput -z -f login.cfg -R . _site/*
	ncftpput -z -f login.cfg -R . files/*
