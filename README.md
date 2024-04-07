# Présentations

Tester localement une seule preséntation (ex, fosdem2024)

    cd slides
    npx slidev fosdem2024.md

Le site est généré avec .build.yaml. Pour éviter de tout recompiler à chaque fois, on stocke dans git les différentes présentation dans /static/slides. 
On utilise `justfile` (alternative Rust à Make) :

    just slides

À noter l'option --base importante pour que le chemin final soit correct 
