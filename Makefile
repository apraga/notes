all: genetique

.PHONY: genetique

# -z option is important to avoid re-uploading everything
# it must be at the beginning
genetique:
	emacs -Q --script build.el
	ncftpput -z -f login.cfg -R . html/genetique
