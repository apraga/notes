slides: fosdem bisonex

fosdem: fosdem-build
    cp -r slides/dist/* site/static/slides/fosdem2024/
    mkdir -p site/static/slides/fosdem2024/img
    cp -r slides/img/ngs.svg site/static/slides/fosdem2024/img/

fosdem-build:
    cd slides &&  npx slidev build fosdem2024.md --base /slides/fosdem2024/ 

bisonex: bisonex-build
    cp -r slides/dist/* site/static/slides/bisonex/
    mkdir -p site/static/slides/bisonex/img
    cp -r slides/img/* site/static/slides/bisonex/img/

bisonex-build:
    cd slides &&  npx slidev build bisonex.md --base /slides/bisonex/ 
