all: _site/slides/fosdem2024
	./site build
	./site deploy

	
../slides/fosdem2024/dist:
	cd ../slides/fosdem2024 && npm run build -- --base /slides/fosdem2024

_site/slides/fosdem2024:  ../slides/fosdem2024/dist
	mkdir $@ 
	cp -r $^ _site/slides/fosdem2024
