slides: fosdem bisonex

fosdem:
    cd slides &&  npx slidev build fosdem2024.md --base /slides/fosdem2024 &&  cp -r dist ../site/static/slides/fosdem2024

bisonex:
    cd slides &&  npx slidev build bisonex.md --base /slides/bisonex &&  cp -r dist ../site/static/slides/bisonex
