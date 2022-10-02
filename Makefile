all: local dist

local:
	nix run . build

watch:
	nix run . watch

# z option is important to avoid re-uploading everything
# it must be at the beginning
# We need a wilcard to avoid an html folder
dist:
	ncftpput -z -f login.cfg -R . _site/*
