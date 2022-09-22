all: local purge dist

local: publish.el
	emacs -Q --script publish.el

purge:
	find html -name "*~" -exec rm {} \;

# z option is important to avoid re-uploading everything
# it must be at the beginning
dist:
	ncftpput -z -f login.cfg -R . html/
