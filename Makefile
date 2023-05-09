all:
	nix-build
# all: local dist

# # Rebuild must be done twice due to a limitation of Hakyll with org metadata (see code)
# local:
# 	nix run . rebuild
# 	nix run . rebuild

# watch:
# 	nix run . watch

# # z option is important to avoid re-uploading everything
# # it must be at the beginning
# # We need a wilcard to avoid an html folder
# dist:
# 	ncftpput -z -f login.cfg -R . _site/*
