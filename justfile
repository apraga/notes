slides: slides-build
    cp -r slides/dist/* site/static/slides/

slides-build:
    rm -rf slides/dist
    cd slides &&  npx slidev build fosdem2024.md bisonex.md --base /slides/ 
