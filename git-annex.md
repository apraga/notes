Utile surtout pour archiver !

/media est notre stockage:
cd /media/
git init
git annex init
git add books
git commit
git annex sync

On veut récupérer les donnée localement 
git clone /media/annex 
git annex sync
git annex get books

Comment synchroniser les stockage entre eux ?
git annex copy --to est trop long..
git annex webapp !
