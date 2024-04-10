slides: fosdem bisonex

fosdem:
    cd slides &&  npx slidev build fosdem2024.md --base /slides/fosdem2024 --out ../site/static/slides/fosdem2024
bisonex:
    cd slides &&  npx slidev build bisonex.md --base /slides/bisonex --out ../site/static/slides/bisonex
