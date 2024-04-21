slides: fosdem bisonex

fosdem:
    rm -r site/static/slides/fosdem2024/*
    cd slides &&  npx slidev build fosdem2024.md --base /slides/fosdem2024/ --out ../site/static/slides/fosdem2024
bisonex:
    rm -r site/static/slides/bisonex/*
    cd slides &&  npx slidev build bisonex.md --base /slides/bisonex/ --out ../site/static/slides/bisonex
