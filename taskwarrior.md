## Divers

- Tâches finies par projet `task completed project:test`
-  Modifier la date d'une tâche finie (il faut l'UUID)`task 868aef60 modify completed 2023-12-24T23:00:00`
- Replacer du texte (les guillemets sont indispensables en cas d'espace !) `task 141 mod "/A test/No test"`
-  Supprimer le temps passé sur une tâche (timewarrior)
```bash
timew summary :day :id
timew delete @2
```

## Gérer une liste de livres
Faire un contexte 

    task context add book +context
    task context book
