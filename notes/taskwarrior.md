Tâches finies par projet`task completed project:test`

Modifier la date d'une tâche finie (il faut l'UUID)`task 868aef60 modify completed 2023-12-24T23:00:00`

Supprimer le temps passé sur une tâche (timewarrior)

~
❯ timew summary :day :id

Wk Date       Day ID Tags                                                                           Start      End     Time    Total
W3 2024-01-19 Fri @2 Télécharger autres données GRCh38 avec DataToolkit, bisonex.test.giab.hg001  0:00:00 21:28:27 21:28:27
                  @1 Réesayer de configure Xorg avec nvidia optimus, gentoo                      21:28:51        -  1:15:21 22:43:48

                                                                                                                            22:43:48
❯ timew delete @2
Deleted @2
