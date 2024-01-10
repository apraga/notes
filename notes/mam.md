```{=org}
#+filetags: books
```
# [TODO]{.todo .TODO} Script

## [TODO]{.todo .TODO} Classiques jaunes

### [TODO]{.todo .TODO} Haskell

1.  DONE V1 : fusion des pdf dans l\'ordre

2.  DONE V2 : télécharger automatique les pdf Impossible de réutiliser
    la connection malgré la doc. IRC: suggestion d\'utiliser des cookies
    mais ne fonctionne pas Mail envoyéau adev

3.  DONE Renommer pdf + creer torrent

4.  DONE Fast fillout in JSON

5.  TODO Scripter rtorrent

    1.  Shell <https://elektito.com/2016/02/10/rtorrent-xmlrpc/>
        <https://github.com/rakshasa/rtorrent/wiki/RPC-Setup-XMLRPC>
        XMLrpc est dans tools/ si on compile xmlrpc-c

    2.  WAIT Python <https://pyrocore.readthedocs.io/en/latest/> Pas
        besoin de serveur web

        1.  TODO Script d\'install ne fonction pas sous freebsd
            Installer coreutils Installer python2 TODO: remplacer md5sum
            par gmd5sum Changer appels à test Utiliser avec bash ...sh
            python2

    3.  Haskell

6.  TODO Passer tout en Text

## [DONE]{.done .DONE} Nouveau Monde (Zola)

Récupérer liste url + titre

## [TODO]{.todo .TODO} Cairn

### [DONE]{.done .DONE} Algorithme

1.  Type de page 1 Lien direct vers le pdf url +
    load~pdf~.php?ID~ARTICLE~=XXX&download=1 Par exemple url +
    load~pdf~.php?ID~ARTICLE~=ARCO~DAMET2019010001~&download=1

2.  Type de page 2 L\'ID est le même mais il y a un token en plus:
    ./index.php?controleur=Pages&action=loadPdfOuvrage&ID~ARTICLE~=XXXX&pdfToken=609d09811c609c354b5aaa35

    Par exemple
    ./index.php?controleur=Pages&action=loadPdfOuvrage&ID~ARTICLE~=ARCO~VINCE2009010001~&pdfToken=609d09811c609c354b5aaa35

    Le token est en dur dans feuilleter.php?ID~ARTICLE~=XXXX Et
    récupérer dans le javascript caché, la variable parametersViewer qui
    contient l\'url complet

    Tous les chapitres sont listés sur les pagges \"feuiller.php\" à
    chaque fois ! Cf \<ul class=\"chapter-list\"\>

    Ne pas oublier la présentation !

3.  DONE Nouvel algorithme pour gérer les 2 versions Récupérer la liste
    des noms de fichiers dans data-id-article \<a class=\"btn
    btn-default\" data-id~article~=\"ARCO~VINCE2009010003~\" \>

    Tester téléchargement direct sur r \^. responseHeader
    \"Content-Type\"

    -   Si \"text/html; charset=UTF-8\", stratégie 2
    -   Si \"application/pdf\", on sauvegarde

### [TODO]{.todo .TODO} Canada

1.  DONE Partager v0

2.  DONE Corriger layout biblio 2 problèmes

    -   on ne peut pas supprimer en pre-processin les listes
        \"inutiles\" (celles supprimées par le CSS après) car:

        1.  Pandoc perd les attributs de listes
        2.  Certains ul/li sont non spécifiques

    -   les header ne sont ne sont pas au bon niveau.

    Donc il faut

    -   corriger les headers à la main
    -   supprimer les item wrapper-children-divbiblio

    ex: canada et états-unis ch007.xml / 4.html

### KILL Uploader sur le pi automatiquement

## [TODO]{.todo .TODO} Automatiser upload

### [DONE]{.done .DONE} Fast fillout

### [DONE]{.done .DONE} Login

``` haskell
optsPost = defaults
        & header "User-Agent" .~ ["Mozilla/5.0 (X11; FreeBSD amd64; rv:87.0)"]

input' t a = ["t" := T.toStrict t,
              "a" := T.toStrict a,
              "email" := T.toStrict "XXX",
              "password" := T.toStrict "YYY"]

parseValueT = head . dropWhile (~/= ("<input type=hidden name=t>" :: String))
parseValueA = head . dropWhile (~/= ("<input type=hidden name=a>" :: String))

testUpload = do
   let url = "https://MMM/login.php" :: T.Text
   sess <- S.newSession
   r <- S.get sess url
   let raw =  r ^. responseBody
   let attrT = TE.decodeUtf8 . fromAttrib "value" . parseValueT $ parseTags raw
   let attrA = TE.decodeUtf8 . fromAttrib "value" . parseValueA $ parseTags raw

   let url' = "https://MMM/takelogin.php" :: T.Text
   r <- S.postWith optsPost sess (url' :: T.Text) (input' attrT attrA)
   print $ r ^. responseStatus
   mapM print $ r ^. responseHeaders
   B.writeFile "test.html" (r ^. responseBody)
```

### [TODO]{.todo .TODO} Upload automatique ??

1.  DONE Soumettre torrent HTML as response

    ``` haskell
    optsPost = defaults
            & header "User-Agent" .~ ["Mozilla/5.0 (X11; FreeBSD amd64; rv:87.0)"]

    input' t a = ["t" := T.toStrict t,
                  "a" := T.toStrict a,
                  "email" := T.toStrict "EMAIL",
                  "password" := T.toStrict "PASS"]

    parseValueT = head . dropWhile (~/= ("<input type=hidden name=t>" :: String))
    parseValueA = head . dropWhile (~/= ("<input type=hidden name=a>" :: String))

    loginMAM = do
       let url = "https://www.myanonamouse.net/login.php" :: T.Text
       sess <- S.newSession
       r <- S.get sess url
       let raw =  r ^. responseBody
       let attrT = TE.decodeUtf8 . fromAttrib "value" . parseValueT $ parseTags raw
       let attrA = TE.decodeUtf8 . fromAttrib "value" . parseValueA $ parseTags raw

       let url' = "takelogin.php" :: T.Text
       r <- S.postWith optsPost sess (url' :: T.Text) (input' attrT attrA)
       print $ r ^. responseStatus
       return sess

    input = [partText "MAX_FILE_SIZE" "10000000",
             partFileSource  "torrent" "TODO",
             partText "submit" "Submit"]

    testUpload = do
      sess <- loginMAM
      let url' = "tor/upload.php" :: T.Text
      r <- S.postWith optsPost sess (url' :: T.Text) input
      B.writeFile "test.html" $ r ^. responseBody
    ```

    1.  Payload Content-Disposition: form-data; name=\"MAX~FILESIZE~\"
        -\> 10000000 Content-Disposition: form-data; name=\"torrent\";
        filename=\"TORRENTFILE\" Content-Type: application/octet-stream
        -\> d8:announce80:TRACKERHERE/announce10 etc
        Content-Disposition: form-data; name=\"submit\" -\> Submit

2.  TODO Soumission finale

    1.  Payload Content-Disposition: form-data; name=\"MAX~FILESIZE~\"
        -\> 10000000 Content-Disposition: form-data;
        name=\"tor\[ext\]\[\]\" -\> yesIexist Content-Disposition:
        form-data; name=\"tor\[ext\]\[\]\" -\> pdf Content-Disposition:
        form-data; name=\"tor\[torrentFileData\]\" -\> ZDg6YW5ub3VuY....
        Content-Disposition: form-data; name=\"tor\[torrentName\]\" -\>
        Famille~etsociétédanslemondegrecetenItalie-V~-IIe~av~.~J~.-C-~AurélieDamet~.torrent
        Content-Disposition: form-data; name=\"tor\[isbn\]\" -\>
        Content-Disposition: form-data; name=\"tor\[title\]\"-\> Famille
        et société dans le monde grec et en Italie. V-IIe av. J.-C
        Content-Disposition: form-data; name=\"tor\[category\]\" -\> 76
        Content-Disposition: form-data; name=\"tor\[author\]\[\]\" -\>
        Aurélie Damet Content-Disposition: form-data;
        name=\"tor\[author\]\[\] -\>\" Content-Disposition: form-data;
        name=\"tor\[series\]\[0\]\[name\]\" -\> Collection U
        Content-Disposition: form-data;
        name=\"tor\[series\]\[0\]\[extra\] -\>\" Content-Disposition:
        form-data; name=\"tor\[series\]\[2\]\[name\] -\>\"
        Content-Disposition: form-data;
        name=\"tor\[series\]\[2\]\[extra\] -\>\" Content-Disposition:
        form-data; name=\"tor\[narrator\]\[\] -\>\" Content-Disposition:
        form-data; name=\"tor\[tags\]\" -\> history, ancient world,
        greece, rome Content-Disposition: form-data; name=\"poster\";
        filename=\"\" Content-Type: application/octet-stream
        Content-Disposition: form-data; name=\"tor\[posterURL\]\" -\>
        ![](https://…L204.jpg) Content-Disposition: form-data;
        name=\"tor\[language\]\" -\> 36 Content-Disposition: form-data;
        name=\"tor\[description\]\" -\> La question du rapport entre
        famille et société,... Content-Disposition: form-data;
        name=\"tor\[flags\]\[exist\]\" -\> true Content-Disposition:
        form-data; name=\"tor\[uploadVIPdays\]\" -\> 0
        Content-Disposition: form-data; name=\"tor\[nfo\]\";
        filename=\"\" Content-Type: application/octet-stream
        Content-Disposition: form-data; name=\"submit\" -\> Submit

    2.  Récupérer données manquantes dans le HTML : torrentFileData:
        \<input type=\"hidden\" name=\"tor\[torrentFileData\]\"
        value=\"ZDg6Y...\"\> Et torrentName: \<input type=\"hidden\"
        name=\"tor\[torrentName\]\" value=\"test.torrent\"\>

### [TODO]{.todo .TODO} Translation par batch

API payante donc on fait un fichier texte contenant toutes les
descriptions.

`et d̊eviennent \ n et \ r donc il faut les remplacer. Format:`{.verbatim}

``` example
--- test1.json: $description
--- test2.json: $description
```

Haskel

### Pour info: editer

GET sur edit.php?id=XXX Puis POST sur takeedit.php

# [TODO]{.todo .TODO} Upload

# [TODO]{.todo .TODO} Classiques Jaunes (638)

Attention, limite de téléchargement de PDF par heure

## [TODO]{.todo .TODO} No author

### [TODO]{.todo .TODO} Dictionnaire des philosophes français du xviie siècle. Volume {#dictionnaire-des-philosophes-français-du-xviie-siècle.-volume}

I - II

<https://classiques-garnier.com/dictionnaire-des-philosophes-francais-du-xviie-siecle-volume-i-ii-acteurs-et-reseaux-du-savoir.html>

### [TODO]{.todo .TODO} Tristan et Yseut

<https://classiques-garnier.com/tristan-et-yseut-les-tristan-en-vers-1.html>

### [TODO]{.todo .TODO} Dictionnaire Montaigne

<https://classiques-garnier.com/dictionnaire-montaigne.html>

### [TODO]{.todo .TODO} La Nef des folles

<https://classiques-garnier.com/la-nef-des-folles-1.html>

### [TODO]{.todo .TODO} Dictionnaire économique de l\'entrepreneur

<https://classiques-garnier.com/dictionnaire-economique-de-l-entrepreneur-1.html>

### [TODO]{.todo .TODO} Le Chevalier aux deux épées

<https://classiques-garnier.com/le-chevalier-aux-deux-epees-roman-arthurien-anonyme-du-xiiie-siecle-1.html>

### [TODO]{.todo .TODO} Le Cheval volant en bois

<https://classiques-garnier.com/le-cheval-volant-en-bois.html>

### [TODO]{.todo .TODO} Le Coran

<https://classiques-garnier.com/le-coran.html>

### [TODO]{.todo .TODO} Les Cent Nouvelles nouvelles

<https://classiques-garnier.com/les-cent-nouvelles-nouvelles.html>

### [TODO]{.todo .TODO} L\'Art de la conversation

<https://classiques-garnier.com/l-art-de-la-conversation-anthologie.html>

### [TODO]{.todo .TODO} Les Évangiles

<https://classiques-garnier.com/les-evangiles.html>

### [TODO]{.todo .TODO} La Fleur de la prose française depuis les origines jusqu\'à la {#la-fleur-de-la-prose-française-depuis-les-origines-jusquà-la}

fin du XVIe siècle

<https://classiques-garnier.com/la-fleur-de-la-prose-francaise-depuis-les-origines-jusqu-a-la-fin-du-xvie-siecle-textes-choisis.html>

### [TODO]{.todo .TODO} La Fleur de la poésie française depuis les origines jusqu\'à la {#la-fleur-de-la-poésie-française-depuis-les-origines-jusquà-la}

fin du XVe siècle

<https://classiques-garnier.com/la-fleur-de-la-poesie-francaise-depuis-les-origines-jusqu-a-la-fin-du-xve-siecle-textes-choisis.html>

### [TODO]{.todo .TODO} Anthologie poétique française du XVIe siècle. Tome I

<https://classiques-garnier.com/anthologie-poetique-francaise-du-xvie-siecle-tome-i-poemes-choisis.html>

### [TODO]{.todo .TODO} Anthologie poétique française du XVIe siècle. Tome II

<https://classiques-garnier.com/anthologie-poetique-francaise-du-xvie-siecle-tome-ii-poemes-choisis.html>

### [TODO]{.todo .TODO} Chrestomathie du Moyen Âge

<https://classiques-garnier.com/chrestomathie-du-moyen-age-morceaux-choisis-d-auteurs-francais.html>

### [DONE]{.done .DONE} La Chanson de Roland

<https://classiques-garnier.com/la-chanson-de-roland.html>

### [TODO]{.todo .TODO} Les Satires françaises du XVIe siècle. Tome I

<https://classiques-garnier.com/les-satires-francaises-du-xvie-siecle-tome-i.html>

### [TODO]{.todo .TODO} Les Satires françaises du XVIe siècle. Tome II

<https://classiques-garnier.com/les-satires-francaises-du-xvie-siecle-tome-ii.html>

### [TODO]{.todo .TODO} Les Satires françaises du XVIIe siècle. Tome I

<https://classiques-garnier.com/les-satires-francaises-du-xviie-siecle-tome-i.html>

### [TODO]{.todo .TODO} Les Satires françaises du XVIIe siècle. Tome II

<https://classiques-garnier.com/les-satires-francaises-du-xviie-siecle-tome-ii.html>

### [TODO]{.todo .TODO} Satyre Ménippée de la vertu du catholicon d\'Espagne et de la {#satyre-ménippée-de-la-vertu-du-catholicon-despagne-et-de-la}

tenue des estatz de Paris MDXCIII

<https://classiques-garnier.com/satyre-menippee-de-la-vertu-du-catholicon-d-espagne-et-de-la-tenue-des-estatz-de-paris-mdxciii.html>

### [TODO]{.todo .TODO} Le Théâtre inédit du XIXe siècle. Tome I

<https://classiques-garnier.com/le-theatre-inedit-du-xixe-siecle-tome-i.html>

### [TODO]{.todo .TODO} Le Théâtre inédit du XIXe siècle. Tome II

<https://classiques-garnier.com/le-theatre-inedit-du-xixe-siecle-tome-ii.html>

### [TODO]{.todo .TODO} Théâtre de la foire

<https://classiques-garnier.com/theatre-de-la-foire-recueil-de-pieces-representees-aux-foires-saint-germain-et-saint-laurent.html>

### [TODO]{.todo .TODO} Théâtre de la Révolution

<https://classiques-garnier.com/theatre-de-la-revolution.html>

### [TODO]{.todo .TODO} Anthologie poétique française du xviie siècle. Tome I

<https://classiques-garnier.com/anthologie-poetique-francaise-du-xviie-siecle-tome-i-poemes-choisis.html>

### [TODO]{.todo .TODO} Anthologie poétique française du xviie siècle. Tome II

<https://classiques-garnier.com/anthologie-poetique-francaise-du-xviie-siecle-tome-ii-poemes-choisis.html>

### [TODO]{.todo .TODO} Anthologie poétique française du xviiie siècle

<https://classiques-garnier.com/anthologie-poetique-francaise-du-xviiie-siecle-poemes-choisis.html>

### [TODO]{.todo .TODO} L\'Imitation de Jésus-Christ

<https://classiques-garnier.com/l-imitation-de-jesus-christ.html>

### [TODO]{.todo .TODO} Les Chefs-d\'œuvre du théâtre espagnol ancien et moderne. Tome I

<https://classiques-garnier.com/les-chefs-d-oeuvre-du-theatre-espagnol-ancien-et-moderne-tome-i-lope-de-vega-tirso-de-molina-augustin-moreto.html>

### [TODO]{.todo .TODO} Les Chefs-d\'œuvre du théâtre espagnol ancien et moderne. Tome {#les-chefs-dœuvre-du-théâtre-espagnol-ancien-et-moderne.-tome}

II

<https://classiques-garnier.com/les-chefs-d-oeuvre-du-theatre-espagnol-ancien-et-moderne-tome-ii-calderon-alarcon.html>

### [TODO]{.todo .TODO} Les Mille et Un Jours

<https://classiques-garnier.com/les-mille-et-un-jours-contes-orientaux.html>

### [TODO]{.todo .TODO} Chansons de geste

<https://classiques-garnier.com/chansons-de-geste-roland-aimeri-de-narbonne-et-le-couronnement-de-louis-1.html>

### [TODO]{.todo .TODO} Recueil de farces, soties et moralités du XVe siècle

<https://classiques-garnier.com/recueil-de-farces-soties-et-moralites-du-xve-siecle-1.html>

### [TODO]{.todo .TODO} Tragédies et récits de martyres en France (fin xvie -- début {#tragédies-et-récits-de-martyres-en-france-fin-xvie-début}

xviie siècle)

<https://classiques-garnier.com/tragedies-et-recits-de-martyres-en-france-fin-xvie-debut-xviie-siecle-1.html>

## [TODO]{.todo .TODO} Abbé de Voisenon

### [TODO]{.todo .TODO} Contes suivis des Poésies fugitives

<https://classiques-garnier.com/contes-suivis-des-poesies-fugitives.html>

## [TODO]{.todo .TODO} Adam Mickiewicz

### [TODO]{.todo .TODO} Pan Tadeusz

<https://classiques-garnier.com/pan-tadeusz.html>

## [TODO]{.todo .TODO} Alain-Fournier

### [TODO]{.todo .TODO} Le Grand Meaulnes précédé de Miracles, Alain-Fournier par {#le-grand-meaulnes-précédé-de-miracles-alain-fournier-par}

Jacques Rivière

<https://classiques-garnier.com/le-grand-meaulnes-precede-de-miracles-alain-fournier-par-jacques-riviere.html>

## [TODO]{.todo .TODO} Alain-René Lesage

### [TODO]{.todo .TODO} Histoire de Gil Blas de Santillane. Tome I

<https://classiques-garnier.com/histoire-de-gil-blas-de-santillane-tome-i.html>

### [TODO]{.todo .TODO} Histoire de Gil Blas de Santillane. Tome II

<https://classiques-garnier.com/histoire-de-gil-blas-de-santillane-tome-ii.html>

### [TODO]{.todo .TODO} Histoire de Guzman d\'Alfarache

<https://classiques-garnier.com/histoire-de-guzman-d-alfarache.html>

### [TODO]{.todo .TODO} Le Diable boîteux

<https://classiques-garnier.com/le-diable-boiteux.html>

### [TODO]{.todo .TODO} Théâtre

<https://classiques-garnier.com/lesage-alain-rene-theatre-turcaret-crispin-rival-de-son-maitre-la-tontine.html>

## [TODO]{.todo .TODO} Alessandro Manzoni

### [TODO]{.todo .TODO} Les Fiancés. Tome I

<https://classiques-garnier.com/les-fiances-tome-i-chapitres-i-xix.html>

### [TODO]{.todo .TODO} Les Fiancés. Tome II

<https://classiques-garnier.com/les-fiances-tome-ii-chapitres-xx-xxxviii.html>

## [TODO]{.todo .TODO} Alexandre Pouchkine

### [TODO]{.todo .TODO} La Dame de Pique et autres nouvelles

<https://classiques-garnier.com/la-dame-de-pique-et-autres-nouvelles.html>

## [TODO]{.todo .TODO} Alexis Piron

### [TODO]{.todo .TODO} Œuvres choisies

<https://classiques-garnier.com/piron-alexis-oeuvres-choisies.html>

## [TODO]{.todo .TODO} Alfred de Musset

### [TODO]{.todo .TODO} Contes

<https://classiques-garnier.com/contes-5.html>

### [TODO]{.todo .TODO} Premières Poésies 1829-1835

<https://classiques-garnier.com/musset-alfred-de-premieres-poesies-1829-1835-oeuvres-completes-1.html>

### [TODO]{.todo .TODO} La Confession d\'un enfant du siècle

<https://classiques-garnier.com/musset-alfred-de-la-confession-d-un-enfant-du-siecle-oeuvres-completes-6.html>

### [TODO]{.todo .TODO} Comédies et proverbes. I

<https://classiques-garnier.com/musset-alfred-de-comedies-et-proverbes-i-oeuvres-completes-3.html>

### [TODO]{.todo .TODO} Comédies et proverbes. II

<https://classiques-garnier.com/musset-alfred-de-comedies-et-proverbes-ii-oeuvres-completes-3.html>

### [TODO]{.todo .TODO} Poésies nouvelles suivies des Poésies complémentaires et des {#poésies-nouvelles-suivies-des-poésies-complémentaires-et-des}

Poésies posthumes

<https://classiques-garnier.com/musset-alfred-de-poesies-nouvelles-suivies-des-poesies-complementaires-et-des-poesies-posthumes-oeuvres-completes-2.html>

### [TODO]{.todo .TODO} Mélanges de littérature et de critique. I

<https://classiques-garnier.com/musset-alfred-de-melanges-de-litterature-et-de-critique-i-oeuvres-completes-7.html>

### [TODO]{.todo .TODO} Mélanges de littérature et de critique. II

<https://classiques-garnier.com/musset-alfred-de-melanges-de-litterature-et-de-critique-ii-oeuvres-completes-7.html>

### [TODO]{.todo .TODO} Nouvelles

<https://classiques-garnier.com/musset-alfred-de-nouvelles-oeuvres-completes-4.html>

## [TODO]{.todo .TODO} Alfred de Vigny

### [TODO]{.todo .TODO} Servitude et grandeur militaires

<https://classiques-garnier.com/servitude-et-grandeur-militaires.html>

### [TODO]{.todo .TODO} Stello suivi de Daphné

<https://classiques-garnier.com/stello-suivi-de-daphne.html>

### [TODO]{.todo .TODO} Poésies complètes

<https://classiques-garnier.com/poesies-completes.html>

### [TODO]{.todo .TODO} Théâtre complet en vers (compositions d\'après Shakespeare). {#théâtre-complet-en-vers-compositions-daprès-shakespeare.}

Tome I

<https://classiques-garnier.com/vigny-alfred-de-theatre-complet-en-vers-compositions-d-apres-shakespeare-tome-i-le-more-de-venise-shylock-romeo-et-juliette.html>

### [TODO]{.todo .TODO} Théâtre complet en prose. Tome II

<https://classiques-garnier.com/vigny-alfred-de-theatre-complet-en-prose-tome-ii-la-marechale-d-ancre-quitte-pour-la-peur-chatterton.html>

### [TODO]{.todo .TODO} Cinq-Mars ou une Conjuration sous Louis XIII

<https://classiques-garnier.com/cinq-mars-ou-une-conjuration-sous-louis-xiii.html>

## [TODO]{.todo .TODO} Alphonse Daudet

### [TODO]{.todo .TODO} Tartarin de Tarascon

<https://classiques-garnier.com/tartarin-de-tarascon.html>

## [TODO]{.todo .TODO} Alphonse de Lamartine

### [TODO]{.todo .TODO} Méditations

<https://classiques-garnier.com/meditations.html>

### [TODO]{.todo .TODO} Recueillements poétiques

<https://classiques-garnier.com/recueillements-poetiques.html>

### [TODO]{.todo .TODO} Graziella suivie de Raphaël

<https://classiques-garnier.com/graziella-suivie-de-raphael.html>

### [TODO]{.todo .TODO} Jocelyn Épisode

<https://classiques-garnier.com/jocelyn-episode-journal-trouve-chez-un-cure-de-village.html>

### [TODO]{.todo .TODO} Harmonies poétiques et religieuses

<https://classiques-garnier.com/harmonies-poetiques-et-religieuses.html>

### [TODO]{.todo .TODO} Histoire de la Révolution de 1848. Tome II

<https://classiques-garnier.com/histoire-de-la-revolution-de-1848-tome-ii-livres-ix-xv.html>

### [TODO]{.todo .TODO} Cours familier de littérature. Tome I

<https://classiques-garnier.com/cours-familier-de-litterature-tome-i-extraits.html>

### [TODO]{.todo .TODO} Cours familier de littérature. Tome II

<https://classiques-garnier.com/cours-familier-de-litterature-tome-ii-extraits.html>

### [TODO]{.todo .TODO} Histoire de la Révolution de 1848. Tome I

<https://classiques-garnier.com/histoire-de-la-revolution-de-1848-tome-i-livres-i-viii.html>

## [TODO]{.todo .TODO} André Chénier

### [TODO]{.todo .TODO} Œuvres poétiques. Tome I

<https://classiques-garnier.com/chenier-andre-oeuvres-poetiques-tome-i-bucoliques-epigrammes-poesies-diverses-elegies.html>

### [TODO]{.todo .TODO} Œuvres poétiques. Tome II

<https://classiques-garnier.com/chenier-andre-oeuvres-poetiques-tome-ii-epitres-poemes-theatre-hymnes-odes-iambes-poesies-diverses.html>

### [TODO]{.todo .TODO} Œuvres en prose

<https://classiques-garnier.com/chenier-andre-oeuvres-en-prose-oeuvres-politiques-correspondance-et-pieces-justificatives.html>

## [TODO]{.todo .TODO} André Suarès

### [TODO]{.todo .TODO} Les Premiers Écrits : documents et manuscrits

<https://classiques-garnier.com/les-premiers-ecrits-documents-et-manuscrits-1.html>

## [TODO]{.todo .TODO} Ann Radcliffe

### [TODO]{.todo .TODO} Le Roman de la forêt

<https://classiques-garnier.com/le-roman-de-la-foret-1.html>

## [TODO]{.todo .TODO} Anne Cadin

### [TODO]{.todo .TODO} Le Moment américain du roman français (1945-1950)

<https://classiques-garnier.com/le-moment-americain-du-roman-francais-1945-1950-1.html>

## [TODO]{.todo .TODO} Antoine Furetière

### [TODO]{.todo .TODO} Le Roman bourgeois

<https://classiques-garnier.com/le-roman-bourgeois.html>

## [TODO]{.todo .TODO} Antoine Galland

### [TODO]{.todo .TODO} Les Mille et Une Nuits Contes arabes. Tome I

<https://classiques-garnier.com/les-mille-et-une-nuits-contes-arabes-tome-i.html>

### [TODO]{.todo .TODO} Les Mille et Une Nuits Contes arabes. Tome II

<https://classiques-garnier.com/les-mille-et-une-nuits-contes-arabes-tome-ii.html>

## [TODO]{.todo .TODO} Antoine Hamilton

### [TODO]{.todo .TODO} Mémoires du comte de Gramont

<https://classiques-garnier.com/memoires-du-comte-de-gramont.html>

## [TODO]{.todo .TODO} Antoine de La Sale

### [TODO]{.todo .TODO} Les Quinze Joyes de mariage

<https://classiques-garnier.com/les-quinze-joyes-de-mariage-1.html>

## [TODO]{.todo .TODO} Antonio Rocco

### [TODO]{.todo .TODO} Amour est un pur intérêt suivi de De la laideur

<https://classiques-garnier.com/amour-est-un-pur-interet-suivi-de-de-la-laideur-1.html>

## [TODO]{.todo .TODO} Antonio de Guevara

### [TODO]{.todo .TODO} Du mespris de la court & de la louange de la vie rustique

<https://classiques-garnier.com/du-mespris-de-la-court-de-la-louange-de-la-vie-rustique-1.html>

## [TODO]{.todo .TODO} Arthur de Gobineau

### [TODO]{.todo .TODO} Le Mouchoir rouge et autres nouvelles

<https://classiques-garnier.com/le-mouchoir-rouge-et-autres-nouvelles.html>

### [TODO]{.todo .TODO} Nouvelles asiatiques

<https://classiques-garnier.com/nouvelles-asiatiques.html>

## [TODO]{.todo .TODO} Astolphe de Custine

### [TODO]{.todo .TODO} La Russie en 1839

<https://classiques-garnier.com/la-russie-en-1839.html>

## [TODO]{.todo .TODO} Auguste Barthélemy

### [TODO]{.todo .TODO} Némésis

<https://classiques-garnier.com/nemesis.html>

## [TODO]{.todo .TODO} Auguste Brizeux

### [TODO]{.todo .TODO} Œuvres. Tome I

<https://classiques-garnier.com/brizeux-auguste-oeuvres-tome-i-marie-telen-arvor-furnez-breiz.html>

### [TODO]{.todo .TODO} Œuvres. Tome II

<https://classiques-garnier.com/brizeux-auguste-oeuvres-tome-ii-les-bretons.html>

### [TODO]{.todo .TODO} Œuvres. Tome III

<https://classiques-garnier.com/brizeux-auguste-oeuvres-tome-iii-la-fleur-d-or-histoires-poetiques-livres-i-ii.html>

### [TODO]{.todo .TODO} Œuvres. Tome IV

<https://classiques-garnier.com/brizeux-auguste-oeuvres-tome-iv-histoires-poetiques-livres-iii-vii-poetique-nouvelle-suivies-d-oeuvres-inedites.html>

## [TODO]{.todo .TODO} Auguste Comte

### [TODO]{.todo .TODO} Cours de philosophie positive. Tome I

<https://classiques-garnier.com/cours-de-philosophie-positive-tome-i-discours-sur-l-esprit-positif.html>

### [TODO]{.todo .TODO} Cours de philosophie positive. Tome II

<https://classiques-garnier.com/cours-de-philosophie-positive-tome-ii-discours-sur-l-esprit-positif.html>

### [TODO]{.todo .TODO} Catéchisme positiviste ou sommaire exposition de la religion {#catéchisme-positiviste-ou-sommaire-exposition-de-la-religion}

universelle

<https://classiques-garnier.com/catechisme-positiviste-ou-sommaire-exposition-de-la-religion-universelle.html>

## [TODO]{.todo .TODO} Auguste de Villiers de l\'Isle-Adam

### [TODO]{.todo .TODO} Contes cruels suivis des Nouveaux Contes cruels

<https://classiques-garnier.com/contes-cruels-suivis-des-nouveaux-contes-cruels.html>

## [TODO]{.todo .TODO} Augustin Thierry

### [TODO]{.todo .TODO} Récits des temps mérovingiens précédés des Considérations sur {#récits-des-temps-mérovingiens-précédés-des-considérations-sur}

l\'histoire de France. I

<https://classiques-garnier.com/thierry-augustin-recits-des-temps-merovingiens-precedes-des-considerations-sur-l-histoire-de-france-i-oeuvres-completes-5.html>

### [TODO]{.todo .TODO} Récits des temps mérovingiens précédés des Considérations sur {#récits-des-temps-mérovingiens-précédés-des-considérations-sur-1}

l\'histoire de France. II

<https://classiques-garnier.com/thierry-augustin-recits-des-temps-merovingiens-precedes-des-considerations-sur-l-histoire-de-france-ii-oeuvres-completes-5.html>

### [TODO]{.todo .TODO} Lettres sur l\'histoire de France

<https://classiques-garnier.com/thierry-augustin-lettres-sur-l-histoire-de-france-oeuvres-completes-1.html>

### [TODO]{.todo .TODO} Dix ans d\'études historiques

<https://classiques-garnier.com/thierry-augustin-dix-ans-d-etudes-historiques-oeuvres-completes-2.html>

### [TODO]{.todo .TODO} Histoire de la conquête de l\'Angleterre par les Normands. {#histoire-de-la-conquête-de-langleterre-par-les-normands.}

Livres I-III

<https://classiques-garnier.com/thierry-augustin-histoire-de-la-conquete-de-l-angleterre-par-les-normands-livres-i-iii-oeuvres-completes-3.html>

### [TODO]{.todo .TODO} Histoire de la conquête de l\'Angleterre par les Normands. {#histoire-de-la-conquête-de-langleterre-par-les-normands.-1}

Livres IV-VII

<https://classiques-garnier.com/thierry-augustin-histoire-de-la-conquete-de-l-angleterre-par-les-normands-livres-iv-vii-oeuvres-completes-3.html>

### [TODO]{.todo .TODO} Histoire de la conquête de l\'Angleterre par les Normands. {#histoire-de-la-conquête-de-langleterre-par-les-normands.-2}

Livres VIII-X

<https://classiques-garnier.com/thierry-augustin-histoire-de-la-conquete-de-l-angleterre-par-les-normands-livres-viii-x-oeuvres-completes-3.html>

### [TODO]{.todo .TODO} Histoire de la conquête de l\'Angleterre par les Normands. Livre {#histoire-de-la-conquête-de-langleterre-par-les-normands.-livre}

XI

<https://classiques-garnier.com/thierry-augustin-histoire-de-la-conquete-de-l-angleterre-par-les-normands-livre-xi-oeuvres-completes-3.html>

### [TODO]{.todo .TODO} Essai sur l\'histoire de la formation et des progrès du {#essai-sur-lhistoire-de-la-formation-et-des-progrès-du}

Tiers-État

<https://classiques-garnier.com/thierry-augustin-essai-sur-l-histoire-de-la-formation-et-des-progres-du-tiers-etat-oeuvres-completes-4.html>

## [TODO]{.todo .TODO} Barbey d\'Aurevilly

### [TODO]{.todo .TODO} L\'Ensorcelée

<https://classiques-garnier.com/l-ensorcelee-1.html>

## [TODO]{.todo .TODO} Baruch Spinoza

### [TODO]{.todo .TODO} Œuvres. Tome II

<https://classiques-garnier.com/spinoza-baruch-oeuvres-tome-ii-traite-theologico-politique.html>

### [TODO]{.todo .TODO} Œuvres. Tome III

<https://classiques-garnier.com/spinoza-baruch-oeuvres-tome-iii-traite-politique-et-lettres.html>

### [TODO]{.todo .TODO} Œuvres. Tome I

<https://classiques-garnier.com/spinoza-baruch-oeuvres-tome-i.html>

## [TODO]{.todo .TODO} Benjamin Constant

### [TODO]{.todo .TODO} Adolphe

<https://classiques-garnier.com/adolphe-anecdote-trouvee-dans-les-papiers-d-un-inconnu.html>

## [TODO]{.todo .TODO} Benoît Santiano

### [TODO]{.todo .TODO} La Monnaie, le Prince et le Marchand

<https://classiques-garnier.com/la-monnaie-le-prince-et-le-marchand-une-analyse-economique-des-phenomenes-monetaires-au-moyen-age-1.html>

## [TODO]{.todo .TODO} Benvenuto Cellini

### [TODO]{.todo .TODO} Œuvres complètes. Tome II

<https://classiques-garnier.com/cellini-benvenuto-oeuvres-completes-tome-ii-memoires-livres-vi-viii-traite-de-l-orfevrerie-et-de-la-sculpture-discours-sur-le-dessin-et-l-architecture.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome I

<https://classiques-garnier.com/cellini-benvenuto-oeuvres-completes-tome-i-memoires-livres-i-v.html>

## [TODO]{.todo .TODO} Bernard Pingaud

### [TODO]{.todo .TODO} L\'Occupation des oisifs

<https://classiques-garnier.com/l-occupation-des-oisifs-precis-de-litterature-et-textes-critiques-1.html>

## [TODO]{.todo .TODO} Bernardin de Saint-Pierre

### [TODO]{.todo .TODO} Paul et Virginie

<https://classiques-garnier.com/paul-et-virginie-1.html>

### [TODO]{.todo .TODO} Paul et Virginie

<https://classiques-garnier.com/paul-et-virginie.html>

## [TODO]{.todo .TODO} Blaise Pascal

### [TODO]{.todo .TODO} Les Provinciales

<https://classiques-garnier.com/les-provinciales-1.html>

### [TODO]{.todo .TODO} Pensées opuscules et lettres

<https://classiques-garnier.com/pensees-opuscules-et-lettres-1.html>

## [TODO]{.todo .TODO} Bonaventure des Périers

### [TODO]{.todo .TODO} Contes ou Nouvelles Récréations et joyeux devis suivis du {#contes-ou-nouvelles-récréations-et-joyeux-devis-suivis-du}

Cymbalum Mundi

<https://classiques-garnier.com/contes-ou-nouvelles-recreations-et-joyeux-devis-suivis-du-cymbalum-mundi.html>

## [TODO]{.todo .TODO} Bono Giamboni

### [TODO]{.todo .TODO} Le Livre des vices et des vertus

<https://classiques-garnier.com/le-livre-des-vices-et-des-vertus-2.html>

## [TODO]{.todo .TODO} Brantôme

### [TODO]{.todo .TODO} Les Dames galantes

<https://classiques-garnier.com/les-dames-galantes.html>

### [TODO]{.todo .TODO} Vies des dames illustres, françoises et étrangères

<https://classiques-garnier.com/vies-des-dames-illustres-francoises-et-etrangeres.html>

## [TODO]{.todo .TODO} Carolina Armenteros

### [TODO]{.todo .TODO} L\'Idée française de l\'histoire

<https://classiques-garnier.com/l-idee-francaise-de-l-histoire-joseph-de-maistre-et-sa-posterite-1794-1854-1.html>

## [TODO]{.todo .TODO} Casimir Delavigne

### [TODO]{.todo .TODO} Œuvres complètes. Tome III

<https://classiques-garnier.com/delavigne-casimir-oeuvres-completes-tome-iii-poesies.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome I

<https://classiques-garnier.com/delavigne-casimir-oeuvres-completes-tome-i-theatre.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome II

<https://classiques-garnier.com/delavigne-casimir-oeuvres-completes-tome-ii-theatre.html>

## [TODO]{.todo .TODO} Charles Coypeau d\' Assoucy

### [TODO]{.todo .TODO} Aventures burlesques

<https://classiques-garnier.com/aventures-burlesques.html>

## [TODO]{.todo .TODO} Charles Dickens

### [TODO]{.todo .TODO} Les Aventures d\'Olivier Twist

<https://classiques-garnier.com/les-aventures-d-olivier-twist.html>

## [TODO]{.todo .TODO} Charles Millevoye

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/millevoye-charles-oeuvres.html>

## [TODO]{.todo .TODO} Charles Nodier

### [TODO]{.todo .TODO} Contes

<https://classiques-garnier.com/contes-4.html>

## [TODO]{.todo .TODO} Charles Sorel

### [TODO]{.todo .TODO} Histoire comique de Francion

<https://classiques-garnier.com/histoire-comique-de-francion.html>

## [TODO]{.todo .TODO} Charles-Albert Demoustier

### [TODO]{.todo .TODO} Lettres à Émilie sur la mythologie

<https://classiques-garnier.com/lettres-a-emilie-sur-la-mythologie.html>

## [TODO]{.todo .TODO} Charles-Augustin Sainte-Beuve

### [DONE]{.done .DONE} Chateaubriand et son groupe littéraire sous l\'Empire. Tome I

<https://classiques-garnier.com/chateaubriand-et-son-groupe-litteraire-sous-l-empire-tome-i-cours-professe-a-liege-en-1848-1849.html>

### [DONE]{.done .DONE} Volupté

<https://classiques-garnier.com/volupte.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du Moyen Âge

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-moyen-age-villehardouin-joinville-froissart-villon-commynes-charles-d-orleans.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XVIe siècle Les prosateurs

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xvie-siecle-les-prosateurs-marguerite-de-navarre-rabelais-montluc-amyot-pasquier-la-boetie-montaigne-charron-agrippa-d-aubigne.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XVIe siècle Les poètes

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xvie-siecle-les-poetes-ronsard-du-bellay-louise-labe-du-bartas-desportes.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XVIIe siècle Écrivains et {#les-grands-écrivains-français-du-xviie-siècle-écrivains-et}

orateurs religieux

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviie-siecle-ecrivains-et-orateurs-religieux-saint-francois-de-sales-bossuet-flechier-bourdaloue-fenelon-massillon.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XVIIe siècle Les poètes

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviie-siecle-les-poetes-malherbe-racan-maynard-mathurin-regnier-theophile-de-viau-saint-amant-voiture-la-fontaine-boileau.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XVIIe siècle Mémorialistes, {#les-grands-écrivains-français-du-xviie-siècle-mémorialistes}

épistoliers, romanciers

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviie-siecle-memorialistes-epistoliers-romanciers-le-cardinal-de-retz-madame-de-sevigne-madame-de-la-fayette-hamilton-saint-simon.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XVIIIe siècle Auteurs {#les-grands-écrivains-français-du-xviiie-siècle-auteurs}

dramatiques et poètes

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviiie-siecle-auteurs-dramatiques-et-poetes-beaumarchais-florian-andre-chenier.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XVIIIe siècle Philosophes et {#les-grands-écrivains-français-du-xviiie-siècle-philosophes-et}

savants. Tome I

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviiie-siecle-philosophes-et-savants-tome-i-fontenelle-montesquieu-buffon-diderot.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XVIIIe siècle Philosophes et {#les-grands-écrivains-français-du-xviiie-siècle-philosophes-et-1}

savants. Tome II

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviiie-siecle-philosophes-et-savants-tome-ii-jean-jacques-rousseau-bernardin-de-saint-pierre.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XVIIIe siècle Voltaire

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviiie-siecle-voltaire-sa-vie-et-sa-correspondance.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XVIIIe siècle Romanciers et {#les-grands-écrivains-français-du-xviiie-siècle-romanciers-et}

moralistes

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviiie-siecle-romanciers-et-moralistes-lesage-marivaux-l-abbe-prevost-vauvenargues-chamfort-rivarol.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XIXe siècle Les poètes. Tome I

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-les-poetes-tome-i-lamartine-vigny.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XIXe siècle Les poètes. Tome {#les-grands-écrivains-français-du-xixe-siècle-les-poètes.-tome}

II

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-les-poetes-tome-ii-hugo-musset-theophile-gautier.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XIXe siècle Les poètes. Tome {#les-grands-écrivains-français-du-xixe-siècle-les-poètes.-tome-1}

III

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-les-poetes-tome-iii-marceline-desbordes-valmore-sainte-beuve-leconte-de-lisle-banville-baudelaire-sully-prudhomme.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XIXe siècle Les romanciers. {#les-grands-écrivains-français-du-xixe-siècle-les-romanciers.}

Tome I

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-les-romanciers-tome-i-xavier-de-maistre-benjamin-constant-senancour-stendhal-balzac.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XIXe siècle Les romanciers. {#les-grands-écrivains-français-du-xixe-siècle-les-romanciers.-1}

Tome II

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-les-romanciers-tome-ii-merimee-george-sand-fromentin-flaubert-edmond-et-jules-de-goncourt.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XIXe siècle Philosophes et {#les-grands-écrivains-français-du-xixe-siècle-philosophes-et}

essayistes. Tome I

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-philosophes-et-essayistes-tome-i-joseph-de-maistre-joubert-de-bonald-paul-louis-courier.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XIXe siècle Philosophes et {#les-grands-écrivains-français-du-xixe-siècle-philosophes-et-1}

essayistes. Tome II

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-philosophes-et-essayistes-tome-ii-la-mennais-victor-cousin-jouffroy.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XIXe siècle Philosophes et {#les-grands-écrivains-français-du-xixe-siècle-philosophes-et-2}

essayistes. Tome III

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-philosophes-et-essayistes-tome-iii-lacordaire-montalembert-louis-veuillot-renan-taine.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XIXe siècle Chateaubriand

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-chateaubriand.html>

### [TODO]{.todo .TODO} Les Grands Écrivains français du XIXe siècle Mme de Stael

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xixe-siecle-madame-de-stael.html>

### [DONE]{.done .DONE} Chateaubriand et son groupe littéraire sous l\'Empire. Tome II

<https://classiques-garnier.com/chateaubriand-et-son-groupe-litteraire-sous-l-empire-tome-ii-cours-professe-a-liege-en-1848-1849.html>

### [DONE]{.done .DONE} Pages choisies de Port-Royal. Tome I

<https://classiques-garnier.com/pages-choisies-de-port-royal-tome-i.html>

### [DONE]{.done .DONE} Pages choisies de Port-Royal. Tome II

<https://classiques-garnier.com/pages-choisies-de-port-royal-tome-ii.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome I

<https://classiques-garnier.com/causeries-du-lundi-tome-i.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome II

<https://classiques-garnier.com/causeries-du-lundi-tome-ii.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome III

<https://classiques-garnier.com/causeries-du-lundi-tome-iii.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome IV

<https://classiques-garnier.com/causeries-du-lundi-tome-iv.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome IX

<https://classiques-garnier.com/causeries-du-lundi-tome-ix.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome V

<https://classiques-garnier.com/causeries-du-lundi-tome-v.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome VI

<https://classiques-garnier.com/causeries-du-lundi-tome-vi.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome VII

<https://classiques-garnier.com/causeries-du-lundi-tome-vii.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome VIII

<https://classiques-garnier.com/causeries-du-lundi-tome-viii.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome X

<https://classiques-garnier.com/causeries-du-lundi-tome-x.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome XI

<https://classiques-garnier.com/causeries-du-lundi-tome-xi.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome XII

<https://classiques-garnier.com/causeries-du-lundi-tome-xii.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome XIII

<https://classiques-garnier.com/causeries-du-lundi-tome-xiii.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome XIV

<https://classiques-garnier.com/causeries-du-lundi-tome-xiv.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome XV

<https://classiques-garnier.com/causeries-du-lundi-tome-xv.html>

### [DONE]{.done .DONE} Causeries du lundi. Tome XVI

<https://classiques-garnier.com/causeries-du-lundi-tome-xvi-table-generale-et-analytique.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XVIIe siècle Les poètes {#les-grands-écrivains-français-du-xviie-siècle-les-poètes}

dramatiques

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviie-siecle-les-poetes-dramatiques-corneille-moliere-racine-regnard.html>

### [DONE]{.done .DONE} Les Grands Écrivains français du XVIIe siècle Les philosophes {#les-grands-écrivains-français-du-xviie-siècle-les-philosophes}

et moralistes

<https://classiques-garnier.com/les-grands-ecrivains-francais-du-xviie-siecle-les-philosophes-et-moralistes-descartes-saint-evremond-la-rochefoucault-pascal-la-bruyere-pierre-bayle.html>

### [TODO]{.todo .TODO} Portraits de femmes

<https://classiques-garnier.com/portraits-de-femmes.html>

### [TODO]{.todo .TODO} Portraits littéraires. Tome I

<https://classiques-garnier.com/portraits-litteraires-tome-i.html>

### [TODO]{.todo .TODO} Portraits littéraires. Tome II

<https://classiques-garnier.com/portraits-litteraires-tome-ii.html>

<https://classiques-garnier.com/causeries-du-lundi-tome-xvi-table-generale-et-analytique.html>

### [TODO]{.todo .TODO} Portraits littéraires. Tome III

<https://classiques-garnier.com/portraits-litteraires-tome-iii.html>

## [TODO]{.todo .TODO} Chevalier de Mouhy

### [TODO]{.todo .TODO} La Mouche ou les Aventures de M. Bigand

<https://classiques-garnier.com/la-mouche-ou-les-aventures-de-m-bigand.html>

## [DONE]{.done .DONE} Choderlos de Laclos

### [DONE]{.done .DONE} Les Liaisons dangereuses

<https://classiques-garnier.com/les-liaisons-dangereuses.html>

## [TODO]{.todo .TODO} Christie McDonald

### [TODO]{.todo .TODO} French Global

<https://classiques-garnier.com/french-global-une-nouvelle-perspective-sur-l-histoire-litteraire-1.html>

## [TODO]{.todo .TODO} Christophe Martin

### [TODO]{.todo .TODO} « Éducations négatives »

<https://classiques-garnier.com/educations-negatives-fictions-d-experimentation-pedagogique-au-xviiie-siecle.html>

## [TODO]{.todo .TODO} Chrétien de Troyes

### [TODO]{.todo .TODO} Le Chevalier de la charrette

<https://classiques-garnier.com/le-chevalier-de-la-charrette-lancelot-1.html>

## [TODO]{.todo .TODO} Claude Crébillon

### [TODO]{.todo .TODO} Œuvres complètes. Tome I

<https://classiques-garnier.com/crebillon-claude-oeuvres-completes-tome-i.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome II

<https://classiques-garnier.com/crebillon-claude-oeuvres-completes-tome-ii.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome III

<https://classiques-garnier.com/crebillon-claude-oeuvres-completes-tome-iii.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome IV

<https://classiques-garnier.com/crebillon-claude-oeuvres-completes-tome-iv.html>

## [TODO]{.todo .TODO} Clément Marot

### [TODO]{.todo .TODO} Œuvres poétiques complètes. Tome I

<https://classiques-garnier.com/marot-clement-oeuvres-poetiques-completes-tome-i.html>

### [TODO]{.todo .TODO} Œuvres poétiques complètes. Tome II

<https://classiques-garnier.com/marot-clement-oeuvres-poetiques-completes-tome-ii.html>

## [DONE]{.done .DONE} Condorcet

### [DONE]{.done .DONE} Écrits sur les États-Unis

<https://classiques-garnier.com/ecrits-sur-les-etats-unis-1.html>

## [DONE]{.done .DONE} Confucius

### [DONE]{.done .DONE} Doctrine ou les Quatre Livres de philosophie morale et {#doctrine-ou-les-quatre-livres-de-philosophie-morale-et}

politique de la Chine

<https://classiques-garnier.com/doctrine-ou-les-quatre-livres-de-philosophie-morale-et-politique-de-la-chine.html>

## [TODO]{.todo .TODO} Cyrano de Bergerac

### [TODO]{.todo .TODO} Œuvres diverses

<https://classiques-garnier.com/cyrano-de-bergerac-oeuvres-diverses.html>

### [TODO]{.todo .TODO} L\'Autre Monde ou les États et empires de la lune et du soleil

<https://classiques-garnier.com/l-autre-monde-ou-les-etats-et-empires-de-la-lune-et-du-soleil.html>

## [TODO]{.todo .TODO} Daniel Defoe

### [TODO]{.todo .TODO} Robinson Crusoé

<https://classiques-garnier.com/robinson-crusoe.html>

## [TODO]{.todo .TODO} Dante Alighieri

### [TODO]{.todo .TODO} La Divine Comédie

<https://classiques-garnier.com/la-divine-comedie.html>

### [TODO]{.todo .TODO} Vie nouvelle

<https://classiques-garnier.com/vie-nouvelle-1.html>

## [TODO]{.todo .TODO} David Herbert Lawrence

### [TODO]{.todo .TODO} Nouvelles complètes. Tome I

<https://classiques-garnier.com/nouvelles-completes-tome-i.html>

### [TODO]{.todo .TODO} Nouvelles complètes. Tome II

<https://classiques-garnier.com/nouvelles-completes-tome-ii.html>

## [TODO]{.todo .TODO} Delphine Nicolas-Pierre

### [TODO]{.todo .TODO} Simone de Beauvoir, l\'existence comme un roman

<https://classiques-garnier.com/simone-de-beauvoir-l-existence-comme-un-roman-1.html>

## [TODO]{.todo .TODO} Denis Diderot

### [TODO]{.todo .TODO} Mémoires pour Catherine II

<https://classiques-garnier.com/memoires-pour-catherine-ii.html>

### [TODO]{.todo .TODO} Œuvres philosophiques

<https://classiques-garnier.com/diderot-denis-oeuvres-philosophiques.html>

### [TODO]{.todo .TODO} Œuvres esthétiques

<https://classiques-garnier.com/diderot-denis-oeuvres-esthetiques.html>

### [TODO]{.todo .TODO} Œuvres politiques

<https://classiques-garnier.com/diderot-denis-oeuvres-politiques.html>

### [TODO]{.todo .TODO} Œuvres romanesques

<https://classiques-garnier.com/diderot-denis-oeuvres-romanesques.html>

## [TODO]{.todo .TODO} Donald Frame

### [TODO]{.todo .TODO} Montaigne

<https://classiques-garnier.com/montaigne-une-vie-une-oeuvre.html>

## [TODO]{.todo .TODO} E.T.A. Hoffmann

### [TODO]{.todo .TODO} Contes nocturnes

<https://classiques-garnier.com/contes-nocturnes-1.html>

### [TODO]{.todo .TODO} Contes, récits et nouvelles choisis

<https://classiques-garnier.com/contes-recits-et-nouvelles-choisis.html>

## [TODO]{.todo .TODO} Edgar Allan Poe

### [TODO]{.todo .TODO} Contes policiers et autres

<https://classiques-garnier.com/contes-policiers-et-autres-1.html>

### [TODO]{.todo .TODO} Nouvelles Histoires extraordinaires

<https://classiques-garnier.com/nouvelles-histoires-extraordinaires.html>

### [TODO]{.todo .TODO} Histoires extraordinaires

<https://classiques-garnier.com/histoires-extraordinaires.html>

### [TODO]{.todo .TODO} Histoires grotesques et sérieuses suivies des Derniers contes

<https://classiques-garnier.com/histoires-grotesques-et-serieuses-suivies-des-derniers-contes.html>

## [TODO]{.todo .TODO} Edme Boursault

### [TODO]{.todo .TODO} Théâtre choisi

<https://classiques-garnier.com/boursault-edme-theatre-choisi.html>

## [TODO]{.todo .TODO} Elsa de Lavergne

### [TODO]{.todo .TODO} La Naissance du roman policier français

<https://classiques-garnier.com/la-naissance-du-roman-policier-francais-du-second-empire-a-la-premiere-guerre-mondiale-1.html>

## [TODO]{.todo .TODO} Emily Brontë

### [TODO]{.todo .TODO} Hurlemont

<https://classiques-garnier.com/hurlemont-wuthering-heights.html>

## [TODO]{.todo .TODO} Eugène Fromentin

### [TODO]{.todo .TODO} Les Maîtres d\'autrefois

<https://classiques-garnier.com/les-maitres-d-autrefois.html>

### [TODO]{.todo .TODO} Dominique

<https://classiques-garnier.com/dominique-1.html>

## [TODO]{.todo .TODO} Eugène-Melchior de Vogüé

### [TODO]{.todo .TODO} Le Roman russe

<https://classiques-garnier.com/le-roman-russe-1.html>

## [TODO]{.todo .TODO} Fiodor Dostoïevski

### [TODO]{.todo .TODO} Les Frères Karamazov

<https://classiques-garnier.com/les-freres-karamazov.html>

## [TODO]{.todo .TODO} Florence Prudhomme

### [TODO]{.todo .TODO} Cahiers de mémoire, Kigali, 2019

<https://classiques-garnier.com/cahiers-de-memoire-kigali-2019-1.html>

### [TODO]{.todo .TODO} Cahiers de mémoire, Kigali, 2014

<https://classiques-garnier.com/cahiers-de-memoire-kigali-2014-1.html>

## [TODO]{.todo .TODO} Florent Carton Dancourt

### [TODO]{.todo .TODO} Théâtre choisi

<https://classiques-garnier.com/dancourt-florent-carton-theatre-choisi.html>

## [TODO]{.todo .TODO} Fontenelle

### [TODO]{.todo .TODO} Digression sur les Anciens et les Modernes et autres textes {#digression-sur-les-anciens-et-les-modernes-et-autres-textes}

philosophiques

<https://classiques-garnier.com/digression-sur-les-anciens-et-les-modernes-et-autres-textes-philosophiques-1.html>

### [TODO]{.todo .TODO} Éloges

<https://classiques-garnier.com/eloges.html>

## [TODO]{.todo .TODO} Francesco Orlando

### [TODO]{.todo .TODO} Les Objets désuets dans l\'imagination littéraire

<https://classiques-garnier.com/les-objets-desuets-dans-l-imagination-litteraire-ruines-reliques-raretes-rebuts-lieux-inhabites-et-tresors-caches-1.html>

## [TODO]{.todo .TODO} Francisco Luís Gomes

### [TODO]{.todo .TODO} Les Brahmanes

<https://classiques-garnier.com/les-brahmanes-1.html>

## [TODO]{.todo .TODO} François Béroalde de Verville

### [TODO]{.todo .TODO} Le Moyen de parvenir

<https://classiques-garnier.com/le-moyen-de-parvenir-oeuvre-contenant-la-raison-de-tout-ce-qui-a-ete-est-et-sera.html>

## [TODO]{.todo .TODO} François Maynard

### [TODO]{.todo .TODO} Poésies (1646)

<https://classiques-garnier.com/poesies-1646.html>

## [TODO]{.todo .TODO} François Pétrarque

### [TODO]{.todo .TODO} Le Chansonnier

<https://classiques-garnier.com/le-chansonnier-canzoniere.html>

### [TODO]{.todo .TODO} Œuvres amoureuses

<https://classiques-garnier.com/petrarque-francois-oeuvres-amoureuses-sonnets-et-triomphes.html>

## [TODO]{.todo .TODO} François Rabelais

### [TODO]{.todo .TODO} Œuvres complètes. Tome II

<https://classiques-garnier.com/rabelais-francois-oeuvres-completes-tome-ii.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome I

<https://classiques-garnier.com/rabelais-francois-oeuvres-completes-tome-i.html>

## [TODO]{.todo .TODO} François Vidocq

### [TODO]{.todo .TODO} Mémoires. Tome I

<https://classiques-garnier.com/memoires-tome-i-chapitres-i-xxx.html>

### [TODO]{.todo .TODO} Mémoires. Tome II

<https://classiques-garnier.com/memoires-tome-ii-chapitres-xxxi-lxxvii.html>

## [TODO]{.todo .TODO} François Villon

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/villon-francois-oeuvres-1.html>

## [TODO]{.todo .TODO} François de Malherbe

### [TODO]{.todo .TODO} Poésies

<https://classiques-garnier.com/poesies-5.html>

## [TODO]{.todo .TODO} François-René de Chateaubriand

### [TODO]{.todo .TODO} Atala suivi de René et des Aventures du dernier Abencérage

<https://classiques-garnier.com/atala-suivi-de-rene-et-des-aventures-du-dernier-abencerage.html>

### [TODO]{.todo .TODO} Mémoires d\'outre-tombe. II

<https://classiques-garnier.com/chateaubriand-francois-rene-de-memoires-d-outre-tombe-ii-oeuvres-completes-13.html>

### [TODO]{.todo .TODO} Mémoires d\'outre-tombe. IV

<https://classiques-garnier.com/chateaubriand-francois-rene-de-memoires-d-outre-tombe-iv-oeuvres-completes-13.html>

### [TODO]{.todo .TODO} Les Martyrs ou le Triomphe de la religion chrétienne

<https://classiques-garnier.com/chateaubriand-francois-rene-de-les-martyrs-ou-le-triomphe-de-la-religion-chretienne-oeuvres-completes-4.html>

### [TODO]{.todo .TODO} Génie du christianisme. I

<https://classiques-garnier.com/chateaubriand-francois-rene-de-genie-du-christianisme-i-oeuvres-completes-2.html>

### [TODO]{.todo .TODO} Génie du christianisme. II

<https://classiques-garnier.com/chateaubriand-francois-rene-de-genie-du-christianisme-ii-oeuvres-completes-2.html>

### [TODO]{.todo .TODO} Génie du christianisme suivi de la Défense du génie du {#génie-du-christianisme-suivi-de-la-défense-du-génie-du}

christianisme. III

<https://classiques-garnier.com/chateaubriand-francois-rene-de-genie-du-christianisme-suivi-de-la-defense-du-genie-du-christianisme-iii-oeuvres-completes-2.html>

### [TODO]{.todo .TODO} Itinéraire de Paris à Jérusalem

<https://classiques-garnier.com/chateaubriand-francois-rene-de-itineraire-de-paris-a-jerusalem-oeuvres-completes-5.html>

### [TODO]{.todo .TODO} Le Paradis perdu (de John Milton)

<https://classiques-garnier.com/chateaubriand-francois-rene-de-le-paradis-perdu-de-john-milton-oeuvres-completes-11.html>

### [TODO]{.todo .TODO} Mémoires d\'outre-tombe. I

<https://classiques-garnier.com/chateaubriand-francois-rene-de-memoires-d-outre-tombe-i-oeuvres-completes-13.html>

### [TODO]{.todo .TODO} Mémoires d\'outre-tombe. III

<https://classiques-garnier.com/chateaubriand-francois-rene-de-memoires-d-outre-tombe-iii-oeuvres-completes-13.html>

### [TODO]{.todo .TODO} Études historiques suivies des Mélanges historiques

<https://classiques-garnier.com/chateaubriand-francois-rene-de-etudes-historiques-suivies-des-melanges-historiques-oeuvres-completes-9.html>

### [TODO]{.todo .TODO} Voyages en Amérique, en Italie, au Mont-Blanc suivis des {#voyages-en-amérique-en-italie-au-mont-blanc-suivis-des}

Mélanges littéraires

<https://classiques-garnier.com/chateaubriand-francois-rene-de-voyages-en-amerique-en-italie-au-mont-blanc-suivis-des-melanges-litteraires-oeuvres-completes-6.html>

### [TODO]{.todo .TODO} Histoire de France suivie des Quatre Stuarts et de la Vie de {#histoire-de-france-suivie-des-quatre-stuarts-et-de-la-vie-de}

Rancé

<https://classiques-garnier.com/chateaubriand-francois-rene-de-histoire-de-france-suivie-des-quatre-stuarts-et-de-la-vie-de-rance-oeuvres-completes-10.html>

### [TODO]{.todo .TODO} Mélanges politiques suivis de Polémique (préface)

<https://classiques-garnier.com/chateaubriand-francois-rene-de-melanges-politiques-suivis-de-polemique-preface-oeuvres-completes-7.html>

### [TODO]{.todo .TODO} Congrés de Vérone suivi de la Guerre d\'Espagne

<https://classiques-garnier.com/chateaubriand-francois-rene-de-congres-de-verone-suivi-de-la-guerre-d-espagne-oeuvres-completes-12.html>

### [TODO]{.todo .TODO} Polémique suivie des Opinions et discours politiques et de {#polémique-suivie-des-opinions-et-discours-politiques-et-de}

fragments divers

<https://classiques-garnier.com/chateaubriand-francois-rene-de-polemique-suivie-des-opinions-et-discours-politiques-et-de-fragments-divers-oeuvres-completes-8.html>

### [TODO]{.todo .TODO} Essai sur les révolutions anciennes et modernes

<https://classiques-garnier.com/chateaubriand-francois-rene-de-essai-sur-les-revolutions-anciennes-et-modernes-oeuvres-completes-1.html>

## [TODO]{.todo .TODO} Françoise de Graffigny

### [TODO]{.todo .TODO} Lettres d\'une Péruvienne

<https://classiques-garnier.com/lettres-d-une-peruvienne-1.html>

## [TODO]{.todo .TODO} Friedrich von Schiller

### [TODO]{.todo .TODO} Œuvres dramatiques. Tome I

<https://classiques-garnier.com/schiller-friedrich-von-oeuvres-dramatiques-tome-i-etude-sur-la-vie-de-schiller-les-brigands-la-conjuration-de-fiesque-et-intrigue-et-amour.html>

### [TODO]{.todo .TODO} Œuvres dramatiques. Tome II

<https://classiques-garnier.com/schiller-friedrich-von-oeuvres-dramatiques-tome-ii-don-carlos-wallenstein-le-misanthrope-et-semele.html>

### [TODO]{.todo .TODO} Œuvres dramatiques suivies de plans et fragments. Tome III

<https://classiques-garnier.com/schiller-friedrich-von-oeuvres-dramatiques-suivies-de-plans-et-fragments-tome-iii-marie-stuart-la-pucelle-d-orleans-la-fiancee-de-messine-et-guillaume-tell.html>

## [TODO]{.todo .TODO} Félicité de Lamennais

### [TODO]{.todo .TODO} De l\'Art et du Beau

<https://classiques-garnier.com/de-l-art-et-du-beau.html>

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/lamennais-felicite-de-oeuvres-paroles-d-un-croyant-livre-du-peuple-une-voix-de-prison-melanges-du-passe-et-de-l-avenir-du-peuple-de-l-esclavage-moderne.html>

### [TODO]{.todo .TODO} De la Société première et de ses lois ou de la Religion

<https://classiques-garnier.com/de-la-societe-premiere-et-de-ses-lois-ou-de-la-religion.html>

### [TODO]{.todo .TODO} Affaires de Rome

<https://classiques-garnier.com/affaires-de-rome-des-maux-de-l-eglise-et-de-la-societe.html>

### [TODO]{.todo .TODO} Essai sur l\'indifférence en matière de religion. Tome I

<https://classiques-garnier.com/essai-sur-l-indifference-en-matiere-de-religion-tome-i-parties-i-et-ii.html>

### [TODO]{.todo .TODO} Essai sur l\'indifférence en matière de religion. Tome II

<https://classiques-garnier.com/essai-sur-l-indifference-en-matiere-de-religion-tome-ii-parties-iii-et-iv.html>

### [TODO]{.todo .TODO} Essai sur l\'indifférence en matière de religion. Tome III

<https://classiques-garnier.com/essai-sur-l-indifference-en-matiere-de-religion-tome-iii-partie-iv-suite.html>

### [TODO]{.todo .TODO} Essai sur l\'indifférence en matière de religion. Tome IV

<https://classiques-garnier.com/essai-sur-l-indifference-en-matiere-de-religion-tome-iv-partie-iv-suite-et-fin.html>

## [TODO]{.todo .TODO} Fénelon

### [TODO]{.todo .TODO} Dialogues sur l\'éloquence

<https://classiques-garnier.com/dialogues-sur-l-eloquence.html>

### [TODO]{.todo .TODO} Lectures spirituelles sur la vie intérieure

<https://classiques-garnier.com/lectures-spirituelles-sur-la-vie-interieure.html>

### [TODO]{.todo .TODO} De l\'existence de Dieu et autres œuvres choisies

<https://classiques-garnier.com/de-l-existence-de-dieu-et-autres-oeuvres-choisies.html>

### [TODO]{.todo .TODO} Les Aventures de Télémaque

<https://classiques-garnier.com/les-aventures-de-telemaque.html>

## [TODO]{.todo .TODO} Georg Luck

### [TODO]{.todo .TODO} Arcana Mundi

<https://classiques-garnier.com/arcana-mundi-magie-et-occulte-dans-les-mondes-grec-et-romain-1.html>

## [TODO]{.todo .TODO} George Sand

### [TODO]{.todo .TODO} Indiana

<https://classiques-garnier.com/indiana.html>

### [TODO]{.todo .TODO} Les Maîtres sonneurs

<https://classiques-garnier.com/les-maitres-sonneurs.html>

### [TODO]{.todo .TODO} La Petite Fadette

<https://classiques-garnier.com/la-petite-fadette.html>

### [TODO]{.todo .TODO} La Mare au diable suivie de François le Champi

<https://classiques-garnier.com/la-mare-au-diable-suivie-de-francois-le-champi.html>

## [TODO]{.todo .TODO} Georges Feydeau

### [TODO]{.todo .TODO} Théâtre complet. Tome II

<https://classiques-garnier.com/feydeau-georges-theatre-complet-tome-ii.html>

### [TODO]{.todo .TODO} Théâtre complet. Tome III

<https://classiques-garnier.com/feydeau-georges-theatre-complet-tome-iii.html>

### [TODO]{.todo .TODO} Théâtre complet. Tome IV

<https://classiques-garnier.com/feydeau-georges-theatre-complet-tome-iv.html>

### [TODO]{.todo .TODO} Théâtre complet. Tome I

<https://classiques-garnier.com/feydeau-georges-theatre-complet-tome-i.html>

## [TODO]{.todo .TODO} Gottfried Wilhelm Leibniz

### [TODO]{.todo .TODO} Œuvres choisies

<https://classiques-garnier.com/leibniz-gottfried-wilhelm-oeuvres-choisies.html>

## [TODO]{.todo .TODO} Gregorio Martínez Sierra

### [TODO]{.todo .TODO} Jardin ensoleillé

<https://classiques-garnier.com/jardin-ensoleille.html>

## [TODO]{.todo .TODO} Gustave Flaubert

### [TODO]{.todo .TODO} La Tentation de saint Antoine

<https://classiques-garnier.com/la-tentation-de-saint-antoine.html>

### [TODO]{.todo .TODO} Salammbô

<https://classiques-garnier.com/salammbo.html>

### [TODO]{.todo .TODO} Trois Contes

<https://classiques-garnier.com/trois-contes-un-coeur-simple-la-legende-de-saint-julien-l-hospitalier-et-herodias.html>

### [TODO]{.todo .TODO} Bouvard et Pécuchet

<https://classiques-garnier.com/bouvard-et-pecuchet.html>

### [DONE]{.done .DONE} Madame Bovary

<https://classiques-garnier.com/madame-bovary-moeurs-de-province.html>

### [TODO]{.todo .TODO} L\'Éducation sentimentale

<https://classiques-garnier.com/l-education-sentimentale-histoire-d-un-jeune-homme.html>

## [TODO]{.todo .TODO} Guy de Maupassant

### [TODO]{.todo .TODO} Le Horla et autres Contes cruels et fantastiques

<https://classiques-garnier.com/le-horla-et-autres-contes-cruels-et-fantastiques.html>

### [TODO]{.todo .TODO} La Parure et autres contes parisiens

<https://classiques-garnier.com/la-parure-et-autres-contes-parisiens.html>

### [TODO]{.todo .TODO} Boule de suif et autres contes normands

<https://classiques-garnier.com/boule-de-suif-et-autres-contes-normands.html>

### [TODO]{.todo .TODO} Bel-Ami

<https://classiques-garnier.com/bel-ami.html>

### [TODO]{.todo .TODO} Pierre et Jean

<https://classiques-garnier.com/pierre-et-jean.html>

## [TODO]{.todo .TODO} Gédéon Tallemant des Réaux

### [TODO]{.todo .TODO} Les Historiettes. Tome I

<https://classiques-garnier.com/les-historiettes-tome-i.html>

### [TODO]{.todo .TODO} Les Historiettes. Tome II

<https://classiques-garnier.com/les-historiettes-tome-ii.html>

### [TODO]{.todo .TODO} Les Historiettes. Tome III

<https://classiques-garnier.com/les-historiettes-tome-iii.html>

### [TODO]{.todo .TODO} Les Historiettes. Tome IV

<https://classiques-garnier.com/les-historiettes-tome-iv.html>

### [TODO]{.todo .TODO} Les Historiettes. Tome V

<https://classiques-garnier.com/les-historiettes-tome-v.html>

### [TODO]{.todo .TODO} Les Historiettes. Tome VI

<https://classiques-garnier.com/les-historiettes-tome-vi.html>

### [TODO]{.todo .TODO} Les Historiettes. Tome VII

<https://classiques-garnier.com/les-historiettes-tome-vii.html>

### [TODO]{.todo .TODO} Les Historiettes suivies de la table générale. Tome VIII

<https://classiques-garnier.com/les-historiettes-suivies-de-la-table-generale-tome-viii.html>

## [TODO]{.todo .TODO} Gérard de Nerval

### [TODO]{.todo .TODO} Les Nuits d\'octobre suivi de Contes et Facéties

<https://classiques-garnier.com/les-nuits-d-octobre-suivi-de-contes-et-faceties.html>

### [TODO]{.todo .TODO} Les Filles du feu

<https://classiques-garnier.com/les-filles-du-feu.html>

### [TODO]{.todo .TODO} Scènes de la vie orientale. Tome 1

<https://classiques-garnier.com/scenes-de-la-vie-orientale-tome-1-les-femmes-du-caire.html>

### [TODO]{.todo .TODO} Scènes de la vie orientale. Tome 2

<https://classiques-garnier.com/scenes-de-la-vie-orientale-tome-2-les-femmes-du-liban.html>

### [TODO]{.todo .TODO} Aurélia ou le Rêve et la Vie

<https://classiques-garnier.com/aurelia-ou-le-reve-et-la-vie.html>

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/nerval-gerard-de-oeuvres.html>

## [TODO]{.todo .TODO} Hans Christian Andersen

### [TODO]{.todo .TODO} Contes danois. Tome IV

<https://classiques-garnier.com/contes-danois-tome-iv.html>

### [TODO]{.todo .TODO} Contes danois. Tome V

<https://classiques-garnier.com/contes-danois-tome-v.html>

### [TODO]{.todo .TODO} Contes danois. Tome I

<https://classiques-garnier.com/contes-danois-tome-i.html>

### [TODO]{.todo .TODO} Contes danois. Tome II

<https://classiques-garnier.com/contes-danois-tome-ii.html>

### [TODO]{.todo .TODO} Contes danois. Tome III

<https://classiques-garnier.com/contes-danois-tome-iii.html>

## [TODO]{.todo .TODO} Harriet Beecher Stowe

### [TODO]{.todo .TODO} La Case de l\'oncle Tom ou la Vie des nègres en Amérique

<https://classiques-garnier.com/la-case-de-l-oncle-tom-ou-la-vie-des-negres-en-amerique.html>

## [TODO]{.todo .TODO} Heinrich Heine

### [TODO]{.todo .TODO} Le Livre des chants

<https://classiques-garnier.com/le-livre-des-chants.html>

## [TODO]{.todo .TODO} Henri Beyle, dit Stendhal

### [TODO]{.todo .TODO} De l\'amour

<https://classiques-garnier.com/de-l-amour.html>

### [TODO]{.todo .TODO} La Chartreuse de Parme

<https://classiques-garnier.com/la-chartreuse-de-parme.html>

### [TODO]{.todo .TODO} Armance

<https://classiques-garnier.com/armance.html>

### [TODO]{.todo .TODO} Vie de Henry Brulard

<https://classiques-garnier.com/vie-de-henry-brulard.html>

### [TODO]{.todo .TODO} L\'Abbesse de Castro suivie de Vittoria Accoramboni, Les Cenci, {#labbesse-de-castro-suivie-de-vittoria-accoramboni-les-cenci}

La Duchesse de Palliano, Vanina Vanini, Le Coffre et le Revenant, Le
Philtre

<https://classiques-garnier.com/l-abbesse-de-castro-suivie-de-vittoria-accoramboni-les-cenci-la-duchesse-de-palliano-vanina-vanini-le-coffre-et-le-revenant-le-philtre.html>

### [TODO]{.todo .TODO} Le Rouge et le Noir

<https://classiques-garnier.com/le-rouge-et-le-noir-chronique-du-xixe-siecle.html>

## [TODO]{.todo .TODO} Henri de Régnier

### [TODO]{.todo .TODO} Correspondance (1893-1936)

<https://classiques-garnier.com/correspondance-1893-1936-1.html>

## [TODO]{.todo .TODO} Henri-Dominique Lacordaire

### [TODO]{.todo .TODO} Sainte Marie-Madeleine

<https://classiques-garnier.com/sainte-marie-madeleine.html>

### [TODO]{.todo .TODO} Vie de saint Dominique précédée du Mémoire pour le {#vie-de-saint-dominique-précédée-du-mémoire-pour-le}

rétablissement en France de l\'Ordre des Frères prêcheurs

<https://classiques-garnier.com/vie-de-saint-dominique-precedee-du-memoire-pour-le-retablissement-en-france-de-l-ordre-des-freres-precheurs.html>

### [TODO]{.todo .TODO} Conférences de Notre-Dame de Paris. Tome I

<https://classiques-garnier.com/conferences-de-notre-dame-de-paris-tome-i-annees-1835-1836-et-1843.html>

### [TODO]{.todo .TODO} Conférences de Notre-Dame de Paris. Tome II

<https://classiques-garnier.com/conferences-de-notre-dame-de-paris-tome-ii-annees-1844-1845.html>

### [TODO]{.todo .TODO} Conférences de Notre-Dame de Paris. Tome III

<https://classiques-garnier.com/conferences-de-notre-dame-de-paris-tome-iii-annees-1846-1848.html>

### [TODO]{.todo .TODO} Conférences de Notre-Dame de Paris. Tome IV

<https://classiques-garnier.com/conferences-de-notre-dame-de-paris-tome-iv-annees-1849-1850.html>

### [TODO]{.todo .TODO} Conférences de Notre-Dame de Paris suivies des Conférences de {#conférences-de-notre-dame-de-paris-suivies-des-conférences-de}

Toulouse. Tome V

<https://classiques-garnier.com/conferences-de-notre-dame-de-paris-suivies-des-conferences-de-toulouse-tome-v-annees-1851-1854.html>

### [TODO]{.todo .TODO} Notices et panégyriques

<https://classiques-garnier.com/notices-et-panegyriques.html>

## [TODO]{.todo .TODO} Henry Fielding

### [TODO]{.todo .TODO} Histoire de Tom Jones, ou l\'Enfant trouvé (1750)

<https://classiques-garnier.com/histoire-de-tom-jones-ou-l-enfant-trouve-1750.html>

## [TODO]{.todo .TODO} Henry Murger

### [TODO]{.todo .TODO} Le Bonhomme Jadis

<https://classiques-garnier.com/le-bonhomme-jadis.html>

### [TODO]{.todo .TODO} Le Pays latin suivi des Buveurs d\'Eau et de La Scène du {#le-pays-latin-suivi-des-buveurs-deau-et-de-la-scène-du}

Gouverneur

<https://classiques-garnier.com/le-pays-latin-suivi-des-buveurs-d-eau-et-de-la-scene-du-gouverneur.html>

### [TODO]{.todo .TODO} Scènes de la vie de bohème

<https://classiques-garnier.com/scenes-de-la-vie-de-boheme.html>

## [TODO]{.todo .TODO} Honorat de Bueil de Racan

### [TODO]{.todo .TODO} Les Bergeries et autres poésies lyriques

<https://classiques-garnier.com/les-bergeries-et-autres-poesies-lyriques.html>

## [TODO]{.todo .TODO} Honoré de Balzac

### [TODO]{.todo .TODO} Histoire des treize

<https://classiques-garnier.com/histoire-des-treize-ferragus-la-duchesse-de-langeais-la-fille-aux-yeux-d-or.html>

### [TODO]{.todo .TODO} L\'Illustre Gaudissart suivi de La Muse du département

<https://classiques-garnier.com/l-illustre-gaudissart-suivi-de-la-muse-du-departement.html>

### [TODO]{.todo .TODO} Les Petits Bourgeois

<https://classiques-garnier.com/les-petits-bourgeois.html>

### [TODO]{.todo .TODO} Le Curé de Tours suivi de Pierrette

<https://classiques-garnier.com/le-cure-de-tours-suivi-de-pierrette.html>

### [TODO]{.todo .TODO} La Rabouilleuse

<https://classiques-garnier.com/la-rabouilleuse.html>

### [TODO]{.todo .TODO} Illusions perdues

<https://classiques-garnier.com/illusions-perdues.html>

### [TODO]{.todo .TODO} Le Cousin Pons

<https://classiques-garnier.com/le-cousin-pons.html>

### [TODO]{.todo .TODO} La Cousine Bette

<https://classiques-garnier.com/la-cousine-bette.html>

### [TODO]{.todo .TODO} Le Colonel Chabert suivi de Honorine et de L\'Interdiction

<https://classiques-garnier.com/le-colonel-chabert-suivi-de-honorine-et-de-l-interdiction.html>

### [TODO]{.todo .TODO} La Femme de trente ans

<https://classiques-garnier.com/la-femme-de-trente-ans.html>

### [TODO]{.todo .TODO} Le Lys dans la vallée

<https://classiques-garnier.com/le-lys-dans-la-vallee.html>

### [TODO]{.todo .TODO} La Peau de chagrin

<https://classiques-garnier.com/la-peau-de-chagrin.html>

### [TODO]{.todo .TODO} Eugénie Grandet

<https://classiques-garnier.com/eugenie-grandet.html>

### [TODO]{.todo .TODO} Le Père Goriot

<https://classiques-garnier.com/le-pere-goriot.html>

### [TODO]{.todo .TODO} Béatrix

<https://classiques-garnier.com/beatrix.html>

### [TODO]{.todo .TODO} Le Cabinet des Antiques

<https://classiques-garnier.com/le-cabinet-des-antiques.html>

### [TODO]{.todo .TODO} Les Chouans

<https://classiques-garnier.com/les-chouans.html>

### [TODO]{.todo .TODO} L\'Envers de l\'histoire contemporaine suivi d\'un fragment inédit {#lenvers-de-lhistoire-contemporaine-suivi-dun-fragment-inédit}

Les Précepteurs en Dieu

<https://classiques-garnier.com/l-envers-de-l-histoire-contemporaine-suivi-d-un-fragment-inedit-les-precepteurs-en-dieu.html>

### [TODO]{.todo .TODO} Le Médecin de campagne

<https://classiques-garnier.com/le-medecin-de-campagne.html>

### [TODO]{.todo .TODO} Splendeurs et misères des courtisanes

<https://classiques-garnier.com/splendeurs-et-miseres-des-courtisanes.html>

### [TODO]{.todo .TODO} Histoire de la grandeur et de la décadence de César Birotteau

<https://classiques-garnier.com/histoire-de-la-grandeur-et-de-la-decadence-de-cesar-birotteau.html>

### [TODO]{.todo .TODO} La Maison du chat-qui-pelote suivie du Bal de Sceaux et de La {#la-maison-du-chat-qui-pelote-suivie-du-bal-de-sceaux-et-de-la}

Vendetta

<https://classiques-garnier.com/la-maison-du-chat-qui-pelote-suivie-du-bal-de-sceaux-et-de-la-vendetta.html>

### [TODO]{.todo .TODO} La Vieille Fille

<https://classiques-garnier.com/la-vieille-fille.html>

### [TODO]{.todo .TODO} Les Paysans

<https://classiques-garnier.com/les-paysans.html>

### [TODO]{.todo .TODO} Ursule Mirouët

<https://classiques-garnier.com/ursule-mirouet.html>

## [TODO]{.todo .TODO} Hégésippe Moreau

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/moreau-hegesippe-oeuvres-le-myosotis-et-contes-en-prose.html>

## [TODO]{.todo .TODO} Hélène Vérin

### [TODO]{.todo .TODO} Entrepreneurs, entreprise

<https://classiques-garnier.com/entrepreneurs-entreprise-histoire-d-une-idee-1.html>

## [TODO]{.todo .TODO} Jacob et Wilhelm Grimm

### [TODO]{.todo .TODO} Contes

<https://classiques-garnier.com/contes-3.html>

## [TODO]{.todo .TODO} Jacques Bénigne Bossuet

### [TODO]{.todo .TODO} Oraisons funèbres et panégyriques. Tome II

<https://classiques-garnier.com/oraisons-funebres-et-panegyriques-tome-ii.html>

### [TODO]{.todo .TODO} Oraisons funèbres et panégyriques. Tome I

<https://classiques-garnier.com/oraisons-funebres-et-panegyriques-tome-i.html>

### [TODO]{.todo .TODO} De la connaissance de Dieu et de soi-même

<https://classiques-garnier.com/de-la-connaissance-de-dieu-et-de-soi-meme.html>

### [TODO]{.todo .TODO} Élévations à Dieu sur tous les mystères de la religion {#élévations-à-dieu-sur-tous-les-mystères-de-la-religion}

chrétienne

<https://classiques-garnier.com/elevations-a-dieu-sur-tous-les-mysteres-de-la-religion-chretienne.html>

### [TODO]{.todo .TODO} Sermons. Tome I

<https://classiques-garnier.com/sermons-tome-i.html>

### [TODO]{.todo .TODO} Sermons. Tome II

<https://classiques-garnier.com/sermons-tome-ii.html>

### [TODO]{.todo .TODO} Sermons. Tome III

<https://classiques-garnier.com/sermons-tome-iii.html>

### [TODO]{.todo .TODO} Méditations sur l\'Évangile. Tome I

<https://classiques-garnier.com/meditations-sur-l-evangile-tome-i.html>

### [TODO]{.todo .TODO} Méditations sur l\'Évangile. Tome II

<https://classiques-garnier.com/meditations-sur-l-evangile-tome-ii.html>

### [TODO]{.todo .TODO} Sermons. Tome IV

<https://classiques-garnier.com/sermons-tome-iv.html>

### [TODO]{.todo .TODO} Discours sur l\'histoire universelle

<https://classiques-garnier.com/discours-sur-l-histoire-universelle.html>

### [TODO]{.todo .TODO} Lectures spirituelles pour la préparation au carême

<https://classiques-garnier.com/lectures-spirituelles-pour-la-preparation-au-careme.html>

### [TODO]{.todo .TODO} Histoire des variations des églises protestantes. Tome I

<https://classiques-garnier.com/histoire-des-variations-des-eglises-protestantes-tome-i-livres-i-ix.html>

### [TODO]{.todo .TODO} Histoire des variations des églises protestantes. Tome II

<https://classiques-garnier.com/histoire-des-variations-des-eglises-protestantes-tome-ii-livres-x-xv.html>

### [TODO]{.todo .TODO} Traité de la concupiscence suivi des Lettre, maximes et {#traité-de-la-concupiscence-suivi-des-lettre-maximes-et}

réflexions sur la comédie, de La Logique et du Traité du libre arbitre

<https://classiques-garnier.com/traite-de-la-concupiscence-suivi-des-lettre-maximes-et-reflexions-sur-la-comedie-de-la-logique-et-du-traite-du-libre-arbitre.html>

## [TODO]{.todo .TODO} Jacques Casanova de Seingalt

### [TODO]{.todo .TODO} Mémoires. Tome I

<https://classiques-garnier.com/memoires-tome-i.html>

### [TODO]{.todo .TODO} Mémoires. Tome II

<https://classiques-garnier.com/memoires-tome-ii.html>

### [TODO]{.todo .TODO} Mémoires. Tome III

<https://classiques-garnier.com/memoires-tome-iii.html>

### [TODO]{.todo .TODO} Mémoires. Tome IV

<https://classiques-garnier.com/memoires-tome-iv.html>

### [TODO]{.todo .TODO} Mémoires. Tome V

<https://classiques-garnier.com/memoires-tome-v.html>

### [TODO]{.todo .TODO} Mémoires. Tome VI

<https://classiques-garnier.com/memoires-tome-vi.html>

### [TODO]{.todo .TODO} Mémoires. Tome VII

<https://classiques-garnier.com/memoires-tome-vii.html>

### [TODO]{.todo .TODO} Mémoires. Tome VIII

<https://classiques-garnier.com/memoires-tome-viii.html>

## [TODO]{.todo .TODO} Jacques Grévin

### [TODO]{.todo .TODO} Théâtre complet et Poésies choisies

<https://classiques-garnier.com/grevin-jacques-theatre-complet-et-poesies-choisies.html>

## [TODO]{.todo .TODO} Jacques Jasmin

### [TODO]{.todo .TODO} Las Papilhôtos. Tome II

<https://classiques-garnier.com/las-papilhotos-tome-ii-les-satires-et-les-epitres.html>

### [TODO]{.todo .TODO} Las Papilhôtos. Tome I

<https://classiques-garnier.com/las-papilhotos-tome-i-les-poemes-et-les-odes.html>

## [TODO]{.todo .TODO} Jacques Ninet

### [TODO]{.todo .TODO} Taux d\'intérêt négatifs

<https://classiques-garnier.com/taux-d-interet-negatifs-le-trou-noir-du-capitalisme-financier.html>

## [TODO]{.todo .TODO} Jacques de Voragine

### [TODO]{.todo .TODO} La Légende dorée

<https://classiques-garnier.com/la-legende-doree-2.html>

## [TODO]{.todo .TODO} James Macpherson

### [TODO]{.todo .TODO} Œuvres d\'Ossian

<https://classiques-garnier.com/macpherson-james-oeuvres-d-ossian-1.html>

## [TODO]{.todo .TODO} Janina Hescheles Altman

### [TODO]{.todo .TODO} Les Cahiers de Janina

<https://classiques-garnier.com/les-cahiers-de-janina.html>

## [TODO]{.todo .TODO} Jean Anthelme Brillat-Savarin

### [TODO]{.todo .TODO} Physiologie du goût ou méditations de gastronomie transcendante

<https://classiques-garnier.com/physiologie-du-gout-ou-meditations-de-gastronomie-transcendante.html>

## [TODO]{.todo .TODO} Jean Boccace

### [TODO]{.todo .TODO} Le Décaméron

<https://classiques-garnier.com/le-decameron.html>

## [TODO]{.todo .TODO} Jean Racine

### [TODO]{.todo .TODO} Théâtre complet

<https://classiques-garnier.com/racine-jean-theatre-complet-1.html>

## [TODO]{.todo .TODO} Jean Second

### [TODO]{.todo .TODO} Les Baisers suivis de l\' Épithalame, des Odes et des Élégies

<https://classiques-garnier.com/les-baisers-suivis-de-l-epithalame-des-odes-et-des-elegies.html>

## [TODO]{.todo .TODO} Jean Vauquelin de la Fresnaye

### [TODO]{.todo .TODO} L\'Art poétique

<https://classiques-garnier.com/l-art-poetique-texte-conforme-a-l-edition-de-1605.html>

## [TODO]{.todo .TODO} Jean de Joinville

### [TODO]{.todo .TODO} Vie de saint Louis

<https://classiques-garnier.com/vie-de-saint-louis-1.html>

## [TODO]{.todo .TODO} Jean de La Bruyère

### [TODO]{.todo .TODO} Les Caractères ou les Mœurs de ce siècle précédés des {#les-caractères-ou-les-mœurs-de-ce-siècle-précédés-des}

Caractères de Théophraste

<https://classiques-garnier.com/les-caracteres-ou-les-moeurs-de-ce-siecle-precedes-des-caracteres-de-theophraste.html>

## [TODO]{.todo .TODO} Jean de La Fontaine

### [TODO]{.todo .TODO} Fables choisies

<https://classiques-garnier.com/fables-choisies.html>

### [TODO]{.todo .TODO} Contes et nouvelles en vers

<https://classiques-garnier.com/contes-et-nouvelles-en-vers.html>

### [TODO]{.todo .TODO} Théâtre

<https://classiques-garnier.com/la-fontaine-jean-de-theatre-oeuvres-completes-3.html>

### [TODO]{.todo .TODO} Poèmes et poésies diverses

<https://classiques-garnier.com/la-fontaine-jean-de-poemes-et-poesies-diverses-oeuvres-completes-4.html>

### [TODO]{.todo .TODO} Les Amours de Psyché suivies des Opuscules en prose et des {#les-amours-de-psyché-suivies-des-opuscules-en-prose-et-des}

lettres

<https://classiques-garnier.com/la-fontaine-jean-de-les-amours-de-psyche-suivies-des-opuscules-en-prose-et-des-lettres-oeuvres-completes-5.html>

## [TODO]{.todo .TODO} Jean de Rotrou

### [TODO]{.todo .TODO} Théâtre choisi

<https://classiques-garnier.com/rotrou-jean-de-theatre-choisi.html>

## [TODO]{.todo .TODO} Jean-Baptiste Massillon

### [TODO]{.todo .TODO} Petit Carême suivi de sermons divers

<https://classiques-garnier.com/petit-careme-suivi-de-sermons-divers.html>

### [TODO]{.todo .TODO} Lectures spirituelles pour le temps du carême

<https://classiques-garnier.com/lectures-spirituelles-pour-le-temps-du-careme.html>

### [TODO]{.todo .TODO} Oraisons funèbres

<https://classiques-garnier.com/oraisons-funebres.html>

## [TODO]{.todo .TODO} Jean-Baptiste-Louis Gresset

### [TODO]{.todo .TODO} Œuvres choisies

<https://classiques-garnier.com/gresset-jean-baptiste-louis-oeuvres-choisies.html>

## [TODO]{.todo .TODO} Jean-Christophe Igalens

### [TODO]{.todo .TODO} Casanova

<https://classiques-garnier.com/casanova-l-ecrivain-en-ses-fictions-1.html>

## [TODO]{.todo .TODO} Jean-François Collin d\'Harleville

### [TODO]{.todo .TODO} Théâtre suivi de poésies fugitives

<https://classiques-garnier.com/collin-d-harleville-jean-francois-theatre-suivi-de-poesies-fugitives.html>

## [TODO]{.todo .TODO} Jean-François Regnard

### [TODO]{.todo .TODO} Théâtre

<https://classiques-garnier.com/regnard-jean-francois-theatre.html>

### [TODO]{.todo .TODO} Œuvres. Tome I

<https://classiques-garnier.com/regnard-jean-francois-oeuvres-tome-i.html>

### [TODO]{.todo .TODO} Œuvres. Tome II

<https://classiques-garnier.com/regnard-jean-francois-oeuvres-tome-ii.html>

## [TODO]{.todo .TODO} Jean-Jacques Rousseau

### [TODO]{.todo .TODO} Œuvres politiques

<https://classiques-garnier.com/rousseau-jean-jacques-oeuvres-politiques.html>

### [TODO]{.todo .TODO} Rousseau juge de Jean Jaques

<https://classiques-garnier.com/rousseau-juge-de-jean-jaques-manuscrit-condillac-avec-les-variantes-ulterieures.html>

### [TODO]{.todo .TODO} Les Rêveries du promeneur solitaire, cartes à jouer

<https://classiques-garnier.com/les-reveries-du-promeneur-solitaire-cartes-a-jouer.html>

### [TODO]{.todo .TODO} Les Rêveries du promeneur solitaire Édition augmentée des {#les-rêveries-du-promeneur-solitaire-édition-augmentée-des}

Lettres à Malesherbes

<https://classiques-garnier.com/les-reveries-du-promeneur-solitaire-edition-augmentee-des-lettres-a-malesherbes.html>

### [TODO]{.todo .TODO} Émile ou de l\'éducation

<https://classiques-garnier.com/emile-ou-de-l-education.html>

### [TODO]{.todo .TODO} Lettre à d\'Alembert sur les spectacles

<https://classiques-garnier.com/lettre-a-d-alembert-sur-les-spectacles.html>

### [TODO]{.todo .TODO} Julie ou la Nouvelle Héloïse

<https://classiques-garnier.com/julie-ou-la-nouvelle-heloise-1.html>

### [TODO]{.todo .TODO} Les Confessions

<https://classiques-garnier.com/les-confessions.html>

## [TODO]{.todo .TODO} Jean-Joseph Vadé

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/vade-jean-joseph-oeuvres.html>

## [TODO]{.todo .TODO} Jean-Pierre Camus

### [TODO]{.todo .TODO} Les Spectacles d\'horreur

<https://classiques-garnier.com/les-spectacles-d-horreur-1.html>

## [TODO]{.todo .TODO} Jean-Pierre Claris de Florian

### [TODO]{.todo .TODO} Fables et théâtre

<https://classiques-garnier.com/fables-et-theatre.html>

## [TODO]{.todo .TODO} Joachim Du Bellay

### [TODO]{.todo .TODO} La Défense et Illustration de la langue française suivie De la {#la-défense-et-illustration-de-la-langue-française-suivie-de-la}

Précellence du langage françois par Henri Estienne

<https://classiques-garnier.com/la-defense-et-illustration-de-la-langue-francaise-suivie-de-la-precellence-du-langage-francois-par-henri-estienne.html>

### [TODO]{.todo .TODO} Œuvres poétiques. Tome I

<https://classiques-garnier.com/du-bellay-joachim-oeuvres-poetiques-tome-i-l-olive-l-anterotique-vers-lyriques-recueil-de-poesie-oeuvre-de-l-invention-de-l-autheur.html>

### [TODO]{.todo .TODO} Œuvres poétiques. Tome II

<https://classiques-garnier.com/du-bellay-joachim-oeuvres-poetiques-tome-ii-les-antiquitez-le-songe-les-regrets-le-poete-courtisan-divers-jeux-rustiques.html>

## [TODO]{.todo .TODO} Joaquim Maria Machado de Assis

### [TODO]{.todo .TODO} Histoires diverses

<https://classiques-garnier.com/histoires-diverses.html>

### [TODO]{.todo .TODO} Mémoires posthumes de Braz Cubas

<https://classiques-garnier.com/memoires-posthumes-de-braz-cubas.html>

### [TODO]{.todo .TODO} Quelques Contes

<https://classiques-garnier.com/quelques-contes.html>

## [TODO]{.todo .TODO} Johan Ludvig Runeberg

### [TODO]{.todo .TODO} Œuvres suivies de poésies détachées

<https://classiques-garnier.com/runeberg-johan-ludvig-oeuvres-suivies-de-poesies-detachees-le-porte-enseigne-stole-la-veillee-de-noel-hanna-et-le-roi-fialar.html>

## [TODO]{.todo .TODO} Johann Wolfgang von Gœthe

### [TODO]{.todo .TODO} Faust suivi du Second Faust

<https://classiques-garnier.com/faust-suivi-du-second-faust.html>

### [TODO]{.todo .TODO} Werther suivi de Hermann et Dorothée

<https://classiques-garnier.com/werther-suivi-de-hermann-et-dorothee.html>

## [TODO]{.todo .TODO} John Gay

### [TODO]{.todo .TODO} Trivia et autres vues urbaines

<https://classiques-garnier.com/trivia-et-autres-vues-urbaines-1.html>

## [TODO]{.todo .TODO} Jonathan Swift

### [TODO]{.todo .TODO} Voyages de Gulliver

<https://classiques-garnier.com/voyages-de-gulliver.html>

## [TODO]{.todo .TODO} Joris-Karl Huysmans

### [TODO]{.todo .TODO} À rebours

<https://classiques-garnier.com/a-rebours-1.html>

## [TODO]{.todo .TODO} Joseph de Maistre

### [TODO]{.todo .TODO} Les Soirées de Saint-Pétersbourg ou Entretiens sur le {#les-soirées-de-saint-pétersbourg-ou-entretiens-sur-le}

gouvernement temporel de la providence. Tome I

<https://classiques-garnier.com/les-soirees-de-saint-petersbourg-ou-entretiens-sur-le-gouvernement-temporel-de-la-providence-tome-i.html>

### [TODO]{.todo .TODO} Les Soirées de Saint-Pétersbourg ou Entretiens sur le {#les-soirées-de-saint-pétersbourg-ou-entretiens-sur-le-1}

gouvernement temporel de la providence. Tome II

<https://classiques-garnier.com/les-soirees-de-saint-petersbourg-ou-entretiens-sur-le-gouvernement-temporel-de-la-providence-tome-ii.html>

### [TODO]{.todo .TODO} Du Pape

<https://classiques-garnier.com/du-pape.html>

## [TODO]{.todo .TODO} Jules Amédée Barbey d\'Aurevilly

### [TODO]{.todo .TODO} Les Diaboliques

<https://classiques-garnier.com/les-diaboliques.html>

## [TODO]{.todo .TODO} Jules Michelet

### [TODO]{.todo .TODO} Pages littéraires

<https://classiques-garnier.com/pages-litteraires.html>

### [TODO]{.todo .TODO} Pages historiques

<https://classiques-garnier.com/pages-historiques.html>

## [TODO]{.todo .TODO} Julie de Lespinasse

### [TODO]{.todo .TODO} Lettres

<https://classiques-garnier.com/lettres-1.html>

## [TODO]{.todo .TODO} Jérôme Blanc

### [TODO]{.todo .TODO} Les Pensées monétaires dans l\'histoire

<https://classiques-garnier.com/les-pensees-monetaires-dans-l-histoire-l-europe-1517-1776-1.html>

## [TODO]{.todo .TODO} La Rochefoucauld

### [TODO]{.todo .TODO} Maximes suivies des Réflexions diverses

<https://classiques-garnier.com/maximes-suivies-des-reflexions-diverses.html>

## [TODO]{.todo .TODO} Laurence Campa

### [TODO]{.todo .TODO} Poètes de la Grande Guerre

<https://classiques-garnier.com/poetes-de-la-grande-guerre-experience-combattante-et-activite-poetique-1.html>

## [TODO]{.todo .TODO} Laurence Sterne

### [TODO]{.todo .TODO} Voyage sentimental

<https://classiques-garnier.com/voyage-sentimental-1.html>

### [TODO]{.todo .TODO} Tristram Shandy. Tome I

<https://classiques-garnier.com/tristram-shandy-tome-i-chapitres-i-cciv.html>

### [TODO]{.todo .TODO} Tristram Shandy suivi du Voyage sentimental. Tome II

<https://classiques-garnier.com/tristram-shandy-suivi-du-voyage-sentimental-tome-ii-chapitres-ccv-cccliii.html>

## [TODO]{.todo .TODO} Le Pogge

### [TODO]{.todo .TODO} Les Facéties suivies de la Description des bains de Bade au XVe {#les-facéties-suivies-de-la-description-des-bains-de-bade-au-xve}

siècle et du dialogue Un vieillard doit-il se marier ?

<https://classiques-garnier.com/les-faceties-suivies-de-la-description-des-bains-de-bade-au-xve-siecle-et-du-dialogue-un-vieillard-doit-il-se-marier.html>

## [TODO]{.todo .TODO} Le Tasse

### [TODO]{.todo .TODO} La Jérusalem délivrée

<https://classiques-garnier.com/la-jerusalem-delivree.html>

## [TODO]{.todo .TODO} Lord Byron

### [TODO]{.todo .TODO} Œuvres complètes. Tome I

<https://classiques-garnier.com/byron-lord-oeuvres-completes-tome-i.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome II

<https://classiques-garnier.com/byron-lord-oeuvres-completes-tome-ii.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome III

<https://classiques-garnier.com/byron-lord-oeuvres-completes-tome-iii.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome IV

<https://classiques-garnier.com/byron-lord-oeuvres-completes-tome-iv.html>

## [TODO]{.todo .TODO} Louis Bourdaloue

### [TODO]{.todo .TODO} Sermons choisis

<https://classiques-garnier.com/sermons-choisis.html>

### [TODO]{.todo .TODO} Chefs-d\'œuvre oratoires suivis d\'opuscules

<https://classiques-garnier.com/chefs-d-oeuvre-oratoires-suivis-d-opuscules.html>

### [TODO]{.todo .TODO} Lectures spirituelles pour le temps de l\'avent

<https://classiques-garnier.com/lectures-spirituelles-pour-le-temps-de-l-avent.html>

## [TODO]{.todo .TODO} Louis Petit de Bachaumont

### [TODO]{.todo .TODO} Mémoires secrets (1762-1771)

<https://classiques-garnier.com/memoires-secrets-1762-1771.html>

## [TODO]{.todo .TODO} Louis-Benoît Picard

### [TODO]{.todo .TODO} Théâtre. Tome I

<https://classiques-garnier.com/picard-louis-benoit-theatre-tome-i.html>

### [TODO]{.todo .TODO} Théâtre. Tome II

<https://classiques-garnier.com/picard-louis-benoit-theatre-tome-ii.html>

## [TODO]{.todo .TODO} Louise Michel

### [TODO]{.todo .TODO} La Chasse aux loups

<https://classiques-garnier.com/la-chasse-aux-loups-1.html>

## [TODO]{.todo .TODO} Louvet de Couvray

### [TODO]{.todo .TODO} Les Amours du chevalier de Faublas. Tome I

<https://classiques-garnier.com/les-amours-du-chevalier-de-faublas-tome-i.html>

### [TODO]{.todo .TODO} Les Amours du chevalier de Faublas. Tome II

<https://classiques-garnier.com/les-amours-du-chevalier-de-faublas-tome-ii.html>

## [TODO]{.todo .TODO} Ludovic Tournès

### [TODO]{.todo .TODO} Sciences de l\'homme et politique

<https://classiques-garnier.com/sciences-de-l-homme-et-politique-les-fondations-philanthropiques-americaines-en-france-au-xxe-siecle-1.html>

## [TODO]{.todo .TODO} Ludwig Tieck

### [TODO]{.todo .TODO} La Barbe bleue suivie des Sept Femmes de Barbe-Bleue

<https://classiques-garnier.com/la-barbe-bleue-suivie-des-sept-femmes-de-barbe-bleue.html>

## [TODO]{.todo .TODO} Luis de Camoëns

### [TODO]{.todo .TODO} Les Lusiades

<https://classiques-garnier.com/les-lusiades.html>

## [TODO]{.todo .TODO} L\' Arioste

### [TODO]{.todo .TODO} Roland furieux. Tome I

<https://classiques-garnier.com/roland-furieux-tome-i-chants-i-xxiii.html>

### [TODO]{.todo .TODO} Roland furieux. Tome II

<https://classiques-garnier.com/roland-furieux-tome-ii-chants-xxiv-xlvi.html>

## [TODO]{.todo .TODO} Madame de Lafayette

### [TODO]{.todo .TODO} Romans et nouvelles

<https://classiques-garnier.com/romans-et-nouvelles-la-princesse-de-montpensier-zaide-la-princesse-de-cleves-et-la-comtesse-de-tende.html>

## [TODO]{.todo .TODO} Madame de Maintenon

### [TODO]{.todo .TODO} Proverbes dramatiques

<https://classiques-garnier.com/proverbes-dramatiques-1.html>

## [TODO]{.todo .TODO} Madame de Murat

### [TODO]{.todo .TODO} Journal pour Mademoiselle de Menou

<https://classiques-garnier.com/journal-pour-mademoiselle-de-menou-1.html>

## [TODO]{.todo .TODO} Madame de Staël

### [TODO]{.todo .TODO} De la littérature considérée dans ses rapports avec les {#de-la-littérature-considérée-dans-ses-rapports-avec-les}

institutions sociales

<https://classiques-garnier.com/de-la-litterature-consideree-dans-ses-rapports-avec-les-institutions-sociales.html>

### [TODO]{.todo .TODO} Corinne ou l\'Italie

<https://classiques-garnier.com/corinne-ou-l-italie.html>

### [TODO]{.todo .TODO} De l\'Allemagne. Tome I

<https://classiques-garnier.com/de-l-allemagne-tome-i.html>

### [TODO]{.todo .TODO} De l\'Allemagne. Tome II

<https://classiques-garnier.com/de-l-allemagne-tome-ii.html>

### [TODO]{.todo .TODO} Delphine

<https://classiques-garnier.com/delphine.html>

## [TODO]{.todo .TODO} Madame de Sévigné

### [TODO]{.todo .TODO} Lettres choisies

<https://classiques-garnier.com/lettres-choisies.html>

## [TODO]{.todo .TODO} Manuel Ugarte

### [TODO]{.todo .TODO} Contes de la Pampa

<https://classiques-garnier.com/contes-de-la-pampa-2.html>

### [TODO]{.todo .TODO} Contes de la Pampa

<https://classiques-garnier.com/contes-de-la-pampa-1.html>

## [TODO]{.todo .TODO} Marc-Antoine Désaugiers

### [TODO]{.todo .TODO} Théâtre

<https://classiques-garnier.com/desaugiers-marc-antoine-theatre.html>

## [TODO]{.todo .TODO} Marcel Proust

### [TODO]{.todo .TODO} La Prisonnière

<https://classiques-garnier.com/la-prisonniere.html>

## [TODO]{.todo .TODO} Marceline Desbordes-Valmore

### [TODO]{.todo .TODO} Poésies choisies

<https://classiques-garnier.com/poesies-choisies.html>

## [TODO]{.todo .TODO} Marguerite de Navarre

### [TODO]{.todo .TODO} L\'Heptaméron

<https://classiques-garnier.com/l-heptameron.html>

## [TODO]{.todo .TODO} Marguerite de Valois

### [TODO]{.todo .TODO} Album de poésies (Manuscrit français 25455 de la BNF)

<https://classiques-garnier.com/album-de-poesies-manuscrit-francais-25455-de-la-bnf.html>

## [TODO]{.todo .TODO} Marivaux

### [TODO]{.todo .TODO} Journaux et œuvres diverses

<https://classiques-garnier.com/journaux-et-oeuvres-diverses.html>

### [TODO]{.todo .TODO} La Vie de Marianne ou les Aventures de Madame la comtesse de {#la-vie-de-marianne-ou-les-aventures-de-madame-la-comtesse-de}

**\***

<https://classiques-garnier.com/la-vie-de-marianne-ou-les-aventures-de-madame-la-comtesse-de.html>

### [TODO]{.todo .TODO} Théâtre complet. Tome II

<https://classiques-garnier.com/marivaux-theatre-complet-tome-ii.html>

### [TODO]{.todo .TODO} Le Paysan parvenu

<https://classiques-garnier.com/le-paysan-parvenu.html>

### [TODO]{.todo .TODO} Théâtre complet. Tome I

<https://classiques-garnier.com/marivaux-theatre-complet-tome-i.html>

## [TODO]{.todo .TODO} Marquise de Créquy

### [TODO]{.todo .TODO} Souvenirs de 1710 à 1803. Tomes I et II

<https://classiques-garnier.com/souvenirs-de-1710-a-1803-tomes-i-et-ii.html>

### [TODO]{.todo .TODO} Souvenirs de 1710 à 1803. Tomes III et IV

<https://classiques-garnier.com/souvenirs-de-1710-a-1803-tomes-iii-et-iv.html>

### [TODO]{.todo .TODO} Souvenirs de 1710 à 1803. Tomes V et VI

<https://classiques-garnier.com/souvenirs-de-1710-a-1803-tomes-v-et-vi.html>

### [TODO]{.todo .TODO} Souvenirs de 1710 à 1803. Tomes VII et VIII

<https://classiques-garnier.com/souvenirs-de-1710-a-1803-tomes-vii-et-viii.html>

### [TODO]{.todo .TODO} Souvenirs de 1710 à 1803. Tomes IX et X

<https://classiques-garnier.com/souvenirs-de-1710-a-1803-tomes-ix-et-x.html>

## [TODO]{.todo .TODO} Mary Shelley

### [TODO]{.todo .TODO} Les Aventures de Perkin Warbeck

<https://classiques-garnier.com/les-aventures-de-perkin-warbeck-1.html>

## [TODO]{.todo .TODO} Mathurin Régnier

### [TODO]{.todo .TODO} Œuvres complètes

<https://classiques-garnier.com/regnier-mathurin-oeuvres-completes-satyres-epitres-elegies-poesies-diverses-et-spirituelles.html>

## [TODO]{.todo .TODO} Maurice Scève

### [TODO]{.todo .TODO} Microcosme

<https://classiques-garnier.com/microcosme.html>

### [TODO]{.todo .TODO} Œuvres poétiques complètes

<https://classiques-garnier.com/sceve-maurice-oeuvres-poetiques-completes-delie-arion-saulsaye-microcosme-poesies-diverses-et-latines.html>

### [TODO]{.todo .TODO} Délie

<https://classiques-garnier.com/delie-objet-de-plus-haute-vertu.html>

## [TODO]{.todo .TODO} Maurice de Guérin

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/guerin-maurice-de-oeuvres-le-cahier-vert-pages-sans-titre-poemes-lettres-a-barbey-d-aurevilly.html>

## [TODO]{.todo .TODO} Michel Lutfalla

### [TODO]{.todo .TODO} Une histoire de la dette publique en France

<https://classiques-garnier.com/une-histoire-de-la-dette-publique-en-france-1.html>

## [TODO]{.todo .TODO} Michel de Montaigne

### [TODO]{.todo .TODO} Essais. Tome I

<https://classiques-garnier.com/essais-tome-i-livre-i-livre-ii-chapitres-i-xii.html>

### [TODO]{.todo .TODO} Essais. Tome II

<https://classiques-garnier.com/essais-tome-ii-livre-ii-chapitres-xiii-a-xxxvii-livre-iii.html>

### [TODO]{.todo .TODO} Journal de voyage en Italie par la Suisse et l\'Allemagne en {#journal-de-voyage-en-italie-par-la-suisse-et-lallemagne-en}

1580 et 1581

<https://classiques-garnier.com/journal-de-voyage-en-italie-par-la-suisse-et-l-allemagne-en-1580-et-1581.html>

## [TODO]{.todo .TODO} Michel-Jean Sedaine

### [TODO]{.todo .TODO} Théâtre

<https://classiques-garnier.com/sedaine-michel-jean-theatre.html>

## [TODO]{.todo .TODO} Miguel de Cervantès

### [TODO]{.todo .TODO} Don Quichotte de la Manche

<https://classiques-garnier.com/don-quichotte-de-la-manche.html>

### [TODO]{.todo .TODO} Les Nouvelles exemplaires

<https://classiques-garnier.com/les-nouvelles-exemplaires.html>

## [TODO]{.todo .TODO} Mirabeau

### [TODO]{.todo .TODO} Lettres d\'amour

<https://classiques-garnier.com/lettres-d-amour.html>

## [TODO]{.todo .TODO} Molière

### [TODO]{.todo .TODO} Œuvres complètes. Tome I

<https://classiques-garnier.com/moliere-oeuvres-completes-tome-i.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome II

<https://classiques-garnier.com/moliere-oeuvres-completes-tome-ii.html>

## [TODO]{.todo .TODO} Montesquieu

### [TODO]{.todo .TODO} Correspondance choisie

<https://classiques-garnier.com/correspondance-choisie-avec-respect-et-l-amitie-la-plus-tendre-1.html>

### [TODO]{.todo .TODO} Considérations sur les causes de la grandeur des Romains et de {#considérations-sur-les-causes-de-la-grandeur-des-romains-et-de}

leur décadence

<https://classiques-garnier.com/considerations-sur-les-causes-de-la-grandeur-des-romains-et-de-leur-decadence.html>

### [TODO]{.todo .TODO} L\'Esprit des lois. Tome I

<https://classiques-garnier.com/l-esprit-des-lois-tome-i-livres-i-xix.html>

### [TODO]{.todo .TODO} L\'Esprit des lois. Tome II

<https://classiques-garnier.com/l-esprit-des-lois-tome-ii-livres-xx-xxxi.html>

### [TODO]{.todo .TODO} Lettres persanes

<https://classiques-garnier.com/lettres-persanes.html>

## [TODO]{.todo .TODO} Nathaniel Hawthorne

### [TODO]{.todo .TODO} L\'Élixir de vie

<https://classiques-garnier.com/l-elixir-de-vie-1.html>

## [TODO]{.todo .TODO} Nicholas Wiseman

### [TODO]{.todo .TODO} Fabiola ou l\'Église des catacombes

<https://classiques-garnier.com/fabiola-ou-l-eglise-des-catacombes.html>

## [TODO]{.todo .TODO} Nicolas Boileau

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/boileau-nicolas-oeuvres.html>

## [TODO]{.todo .TODO} Nicolas Joseph Florent Gilbert

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/gilbert-nicolas-joseph-florent-oeuvres.html>

## [TODO]{.todo .TODO} Nicolas Machiavel

### [TODO]{.todo .TODO} Le Prince précédé des premiers écrits politiques

<https://classiques-garnier.com/le-prince-precede-des-premiers-ecrits-politiques.html>

## [TODO]{.todo .TODO} Nicolas de Malebranche

### [TODO]{.todo .TODO} Conversations chrétiennes dans lesquelles on justifie la vérité {#conversations-chrétiennes-dans-lesquelles-on-justifie-la-vérité}

de la religion et de la morale de Jésus-Christ

<https://classiques-garnier.com/conversations-chretiennes-dans-lesquelles-on-justifie-la-verite-de-la-religion-et-de-la-morale-de-jesus-christ.html>

### [TODO]{.todo .TODO} De la recherche de la vérité. Tome I

<https://classiques-garnier.com/de-la-recherche-de-la-verite-tome-i-livres-i-v.html>

### [TODO]{.todo .TODO} De la recherche de la vérité. Tome II

<https://classiques-garnier.com/de-la-recherche-de-la-verite-tome-ii-livre-vi.html>

## [TODO]{.todo .TODO} Nikolaï Leskov

### [TODO]{.todo .TODO} La Lady Macbeth de Mtsensk

<https://classiques-garnier.com/la-lady-macbeth-de-mtsensk.html>

## [TODO]{.todo .TODO} Ninon de Lenclos

### [TODO]{.todo .TODO} Lettres

<https://classiques-garnier.com/lettres-2.html>

## [TODO]{.todo .TODO} Noël Du Fail

### [TODO]{.todo .TODO} Propos rustiques suivis des Baliverneries

<https://classiques-garnier.com/propos-rustiques-suivis-des-baliverneries.html>

## [TODO]{.todo .TODO} Olivier Basselin

### [TODO]{.todo .TODO} Vaux-de-Vire suivis d\'anciennes chansons normandes choisies

<https://classiques-garnier.com/vaux-de-vire-suivis-d-anciennes-chansons-normandes-choisies.html>

## [TODO]{.todo .TODO} Olivier Goldsmith

### [TODO]{.todo .TODO} Le Vicaire de Wakefield

<https://classiques-garnier.com/le-vicaire-de-wakefield.html>

## [TODO]{.todo .TODO} Patrick Gibert

### [TODO]{.todo .TODO} La Modernisation de l\'État

<https://classiques-garnier.com/la-modernisation-de-l-etat-une-promesse-trahie-1.html>

## [TODO]{.todo .TODO} Paul Scarron

### [TODO]{.todo .TODO} Le Virgile travesti

<https://classiques-garnier.com/le-virgile-travesti.html>

### [TODO]{.todo .TODO} Théâtre complet

<https://classiques-garnier.com/scarron-paul-theatre-complet.html>

### [TODO]{.todo .TODO} Le Roman comique

<https://classiques-garnier.com/le-roman-comique-1.html>

## [TODO]{.todo .TODO} Paul Verlaine

### [TODO]{.todo .TODO} Œuvres poétiques

<https://classiques-garnier.com/verlaine-paul-oeuvres-poetiques.html>

## [TODO]{.todo .TODO} Paul-Louis Courier

### [TODO]{.todo .TODO} Œuvres. Tome I

<https://classiques-garnier.com/courier-paul-louis-oeuvres-tome-i-pamphlets-politiques-pamphlets-litteraires-oeuvres-diverses.html>

### [TODO]{.todo .TODO} Œuvres. Tome II

<https://classiques-garnier.com/courier-paul-louis-oeuvres-tome-ii-daphnis-et-chloe-lettres-inedites-de-france-et-d-italie.html>

## [TODO]{.todo .TODO} Percy Bysshe Shelley

### [TODO]{.todo .TODO} Odes, Poèmes et fragments lyriques choisis

<https://classiques-garnier.com/odes-poemes-et-fragments-lyriques-choisis.html>

## [TODO]{.todo .TODO} Philippe Gilles

### [TODO]{.todo .TODO} L\'Actualité des textes fondateurs

<https://classiques-garnier.com/l-actualite-des-textes-fondateurs-adam-smith-karl-marx-et-john-maynard-keynes-1.html>

## [TODO]{.todo .TODO} Philippe Néricault Destouches

### [TODO]{.todo .TODO} Théâtre choisi

<https://classiques-garnier.com/destouches-philippe-nericault-theatre-choisi.html>

## [TODO]{.todo .TODO} Philippe Quinault

### [TODO]{.todo .TODO} Théâtre choisi

<https://classiques-garnier.com/quinault-philippe-theatre-choisi.html>

## [TODO]{.todo .TODO} Pierre Abélard

### [TODO]{.todo .TODO} Lettres complètes

<https://classiques-garnier.com/lettres-completes-1.html>

## [TODO]{.todo .TODO} Pierre Commelin

### [TODO]{.todo .TODO} Mythologie grecque et romaine

<https://classiques-garnier.com/mythologie-grecque-et-romaine.html>

## [TODO]{.todo .TODO} Pierre Corneille

### [TODO]{.todo .TODO} Théâtre complet. Tome I

<https://classiques-garnier.com/corneille-pierre-theatre-complet-tome-i.html>

### [TODO]{.todo .TODO} Théâtre complet. Tome III

<https://classiques-garnier.com/corneille-pierre-theatre-complet-tome-iii.html>

### [TODO]{.todo .TODO} Théâtre complet. Tome II

<https://classiques-garnier.com/corneille-pierre-theatre-complet-tome-ii.html>

## [TODO]{.todo .TODO} Pierre Dockès

### [TODO]{.todo .TODO} Le Capitalisme et ses rythmes, quatre siècles en perspective. {#le-capitalisme-et-ses-rythmes-quatre-siècles-en-perspective.}

Tome I

<https://classiques-garnier.com/le-capitalisme-et-ses-rythmes-quatre-siecles-en-perspective-tome-i-sous-le-regard-des-geants-1.html>

## [TODO]{.todo .TODO} Pierre Le Moyne

### [TODO]{.todo .TODO} Entretiens et lettres poétiques

<https://classiques-garnier.com/entretiens-et-lettres-poetiques-1.html>

## [TODO]{.todo .TODO} Pierre de Ronsard

### [TODO]{.todo .TODO} Poésies choisies

<https://classiques-garnier.com/poesies-choisies-1.html>

### [TODO]{.todo .TODO} Œuvres en prose Texte de 1578 suivies des appendices, index et {#œuvres-en-prose-texte-de-1578-suivies-des-appendices-index-et}

glossaire

<https://classiques-garnier.com/ronsard-pierre-de-oeuvres-en-prose-texte-de-1578-suivies-des-appendices-index-et-glossaire-oeuvres-completes-6.html>

### [TODO]{.todo .TODO} Les Odes Texte de 1578

<https://classiques-garnier.com/ronsard-pierre-de-les-odes-texte-de-1578-oeuvres-completes-2.html>

### [TODO]{.todo .TODO} Les Poèmes Texte de 1578

<https://classiques-garnier.com/ronsard-pierre-de-les-poemes-texte-de-1578-oeuvres-completes-3.html>

### [TODO]{.todo .TODO} Les Élégies, Églogues et Mascarades Texte de 1578

<https://classiques-garnier.com/ronsard-pierre-de-les-elegies-eglogues-et-mascarades-texte-de-1578-oeuvres-completes-4.html>

### [TODO]{.todo .TODO} Les Hymnes suivis des Discours et de La Franciade Texte de 1578

<https://classiques-garnier.com/ronsard-pierre-de-les-hymnes-suivis-des-discours-et-de-la-franciade-texte-de-1578-oeuvres-completes-5.html>

### [TODO]{.todo .TODO} Les Amours Texte de 1578. Tome II

<https://classiques-garnier.com/ronsard-pierre-de-les-amours-texte-de-1578-tome-ii-oeuvres-completes-1.html>

### [TODO]{.todo .TODO} Les Amours Texte de 1578. Tome I

<https://classiques-garnier.com/ronsard-pierre-de-les-amours-texte-de-1578-tome-i-oeuvres-completes-1.html>

## [TODO]{.todo .TODO} Pierre-Augustin Caron de Beaumarchais

### [TODO]{.todo .TODO} Théâtre

<https://classiques-garnier.com/beaumarchais-pierre-augustin-caron-de-theatre-le-barbier-de-seville-le-mariage-de-figaro-la-mere-coupable.html>

### [TODO]{.todo .TODO} Mémoires dans l\'affaire Goëzman

<https://classiques-garnier.com/memoires-dans-l-affaire-goezman.html>

## [TODO]{.todo .TODO} Pierre-Jean de Béranger

### [TODO]{.todo .TODO} Ma biographie Ouvrage posthume

<https://classiques-garnier.com/beranger-pierre-jean-de-ma-biographie-ouvrage-posthume-oeuvres-completes-2.html>

### [TODO]{.todo .TODO} Chansons. I

<https://classiques-garnier.com/beranger-pierre-jean-de-chansons-i-oeuvres-completes-1.html>

### [TODO]{.todo .TODO} Chansons. II

<https://classiques-garnier.com/beranger-pierre-jean-de-chansons-ii-oeuvres-completes-1.html>

### [TODO]{.todo .TODO} Chansons anciennes et posthumes avec accompagnement de piano

<https://classiques-garnier.com/beranger-pierre-jean-de-chansons-anciennes-et-posthumes-avec-accompagnement-de-piano-oeuvres-completes-3.html>

## [TODO]{.todo .TODO} Prosper Jolyot de Crébillon

### [TODO]{.todo .TODO} Théâtre complet. Tome I

<https://classiques-garnier.com/crebillon-prosper-jolyot-de-theatre-complet-tome-i-idomenee-atree-et-thyeste-electre-rhadamisthe-et-zenobie-xerces-1.html>

## [TODO]{.todo .TODO} Prosper Mérimée

### [TODO]{.todo .TODO} Romans et nouvelles. Tome I

<https://classiques-garnier.com/romans-et-nouvelles-tome-i.html>

### [TODO]{.todo .TODO} Romans et nouvelles. Tome II

<https://classiques-garnier.com/romans-et-nouvelles-tome-ii.html>

### [TODO]{.todo .TODO} Carmen

<https://classiques-garnier.com/carmen.html>

### [TODO]{.todo .TODO} Colomba suivie de La Vénus d\'Ille et des Âmes du purgatoire

<https://classiques-garnier.com/colomba-suivie-de-la-venus-d-ille-et-des-ames-du-purgatoire.html>

### [TODO]{.todo .TODO} Théâtre de Clara Gazul, comédienne espagnole suivi de La {#théâtre-de-clara-gazul-comédienne-espagnole-suivi-de-la}

Famille de Carvajal

<https://classiques-garnier.com/merimee-prosper-theatre-de-clara-gazul-comedienne-espagnole-suivi-de-la-famille-de-carvajal.html>

### [TODO]{.todo .TODO} Chronique du règne de Charles IX

<https://classiques-garnier.com/chronique-du-regne-de-charles-ix.html>

## [TODO]{.todo .TODO} Ramón del Valle-Inclán

### [TODO]{.todo .TODO} Sonates

<https://classiques-garnier.com/sonates-memoires-du-marquis-de-bradomin-et-autres-textes-inedits-1.html>

## [TODO]{.todo .TODO} Remy de Gourmont

### [TODO]{.todo .TODO} Le Problème du style

<https://classiques-garnier.com/le-probleme-du-style-questions-d-art-de-litterature-et-de-grammaire-1.html>

## [TODO]{.todo .TODO} René Descartes

### [TODO]{.todo .TODO} Œuvres philosophiques. Tome I -- 1618-1637

<https://classiques-garnier.com/descartes-rene-oeuvres-philosophiques-tome-i-1618-1637-1.html>

### [TODO]{.todo .TODO} Œuvres philosophiques. Tome II -- 1638-1642

<https://classiques-garnier.com/descartes-rene-oeuvres-philosophiques-tome-ii-1638-1642-1.html>

### [TODO]{.todo .TODO} Œuvres philosophiques. Tome III -- 1643-1650

<https://classiques-garnier.com/descartes-rene-oeuvres-philosophiques-tome-iii-1643-1650-1.html>

## [TODO]{.todo .TODO} Robert Challe

### [TODO]{.todo .TODO} Les Illustres Françaises

<https://classiques-garnier.com/les-illustres-francaises-1.html>

## [TODO]{.todo .TODO} Robert Garnier

### [TODO]{.todo .TODO} Hippolyte (1573) La Troade (1579)

<https://classiques-garnier.com/hippolyte-1573-la-troade-1579.html>

### [TODO]{.todo .TODO} Bradamante suivie des Juifves

<https://classiques-garnier.com/bradamante-suivie-des-juifves.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome I

<https://classiques-garnier.com/garnier-robert-oeuvres-completes-tome-i-theatre-et-poesies.html>

### [TODO]{.todo .TODO} Œuvres complètes. Tome II

<https://classiques-garnier.com/garnier-robert-oeuvres-completes-tome-ii-theatre-et-poesies.html>

## [TODO]{.todo .TODO} Rodolphe Töpffer

### [TODO]{.todo .TODO} Premiers Voyages en zigzag ou excursions d\'un pensionnat en {#premiers-voyages-en-zigzag-ou-excursions-dun-pensionnat-en}

vacances dans les cantons suisses et sur le revers italien des Alpes.
Tome I

<https://classiques-garnier.com/premiers-voyages-en-zigzag-ou-excursions-d-un-pensionnat-en-vacances-dans-les-cantons-suisses-et-sur-le-revers-italien-des-alpes-tome-i-vallee-d-aoste-saint-gervais-valais-saint-gothard-schwitz-milan-come-splugen.html>

### [TODO]{.todo .TODO} Nouvelles genevoises

<https://classiques-garnier.com/nouvelles-genevoises.html>

### [TODO]{.todo .TODO} Le Presbytère

<https://classiques-garnier.com/le-presbytere.html>

### [TODO]{.todo .TODO} Rosa et Gertrude

<https://classiques-garnier.com/rosa-et-gertrude.html>

### [TODO]{.todo .TODO} Premiers Voyages en zigzag ou excursions d\'un pensionnat en {#premiers-voyages-en-zigzag-ou-excursions-dun-pensionnat-en-1}

vacances dans les cantons suisses et sur le revers italien des Alpes.
Tome II

<https://classiques-garnier.com/premiers-voyages-en-zigzag-ou-excursions-d-un-pensionnat-en-vacances-dans-les-cantons-suisses-et-sur-le-revers-italien-des-alpes-tome-ii-chamounix-l-oberland-le-rihi-le-tour-du-lac-de-geneve-venise.html>

### [TODO]{.todo .TODO} Nouveaux Voyages en zigzag. Tome I

<https://classiques-garnier.com/nouveaux-voyages-en-zigzag-tome-i-voyage-a-la-grande-chartreuse-et-autour-du-mont-blanc.html>

### [TODO]{.todo .TODO} Nouveaux Voyages en zigzag. Tome II

<https://classiques-garnier.com/nouveaux-voyages-en-zigzag-tome-ii-voyage-dans-les-vallees-d-herens-de-zermatt-au-grimsel-a-genes-et-a-la-corniche.html>

## [TODO]{.todo .TODO} Roger de Bussy-Rabutin

### [TODO]{.todo .TODO} Histoire amoureuse des Gaules suivie de La France galante. Tome {#histoire-amoureuse-des-gaules-suivie-de-la-france-galante.-tome}

I

<https://classiques-garnier.com/histoire-amoureuse-des-gaules-suivie-de-la-france-galante-tome-i.html>

### [TODO]{.todo .TODO} Histoire amoureuse des Gaules suivie de La France galante {#histoire-amoureuse-des-gaules-suivie-de-la-france-galante}

(suite). Tome II

<https://classiques-garnier.com/histoire-amoureuse-des-gaules-suivie-de-la-france-galante-suite-tome-ii.html>

## [TODO]{.todo .TODO} Roland Breeur

### [TODO]{.todo .TODO} Autour de la bêtise

<https://classiques-garnier.com/autour-de-la-betise-1.html>

## [TODO]{.todo .TODO} Romain Rolland

### [TODO]{.todo .TODO} Correspondance (1912-1942)

<https://classiques-garnier.com/correspondance-1912-1942-1.html>

## [TODO]{.todo .TODO} Rétif de la Bretonne

### [TODO]{.todo .TODO} La Vie de mon père

<https://classiques-garnier.com/la-vie-de-mon-pere.html>

## [TODO]{.todo .TODO} Saint-Amant

### [TODO]{.todo .TODO} Œuvres poétiques

<https://classiques-garnier.com/saint-amant-oeuvres-poetiques-poemes-raillerie-a-part-pieces-diverses-les-caprices-et-moyse-sauve.html>

## [TODO]{.todo .TODO} Saint-Évremond

### [TODO]{.todo .TODO} Œuvres choisies

<https://classiques-garnier.com/saint-evremond-oeuvres-choisies.html>

## [TODO]{.todo .TODO} Silvio Pellico

### [TODO]{.todo .TODO} Mes Prisons suivies des Devoirs des hommes

<https://classiques-garnier.com/mes-prisons-suivies-des-devoirs-des-hommes.html>

## [TODO]{.todo .TODO} Stéphane Mallarmé

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/mallarme-stephane-oeuvres.html>

## [TODO]{.todo .TODO} Tabarin

### [TODO]{.todo .TODO} Œuvres

<https://classiques-garnier.com/tabarin-oeuvres.html>

## [TODO]{.todo .TODO} Teodor de Wyzewa

### [TODO]{.todo .TODO} Valbert ou les Récits d\'un jeune homme

<https://classiques-garnier.com/valbert-ou-les-recits-d-un-jeune-homme-1.html>

## [TODO]{.todo .TODO} Teofilo Folengo

### [TODO]{.todo .TODO} Histoire maccaronique de Merlin Coccaie ou est traicté Les {#histoire-maccaronique-de-merlin-coccaie-ou-est-traicté-les}

Ruses de Cingar, Les Tours de Boccal, Les Aventures de Léonard, Les
Forces de Fracasse, Les Enchantements de Gelfore et Pandrague, Les
Rencontres heureuses de Balde

<https://classiques-garnier.com/histoire-maccaronique-de-merlin-coccaie-ou-est-traicte-les-ruses-de-cingar-les-tours-de-boccal-les-aventures-de-leonard-les-forces-de-fracasse-les-enchantements-de-gelfore-et-pandrague-les-rencontres-heureuses-de-balde.html>

## [TODO]{.todo .TODO} Thomas Corneille

### [TODO]{.todo .TODO} Théâtre choisi

<https://classiques-garnier.com/corneille-thomas-theatre-choisi.html>

## [TODO]{.todo .TODO} Théodore Agrippa d\'Aubigné

### [TODO]{.todo .TODO} Les Tragiques

<https://classiques-garnier.com/les-tragiques-1.html>

## [TODO]{.todo .TODO} Théophile Gautier

### [TODO]{.todo .TODO} Mademoiselle de Maupin

<https://classiques-garnier.com/mademoiselle-de-maupin-texte-complet-1835.html>

### [TODO]{.todo .TODO} Le Capitaine Fracasse

<https://classiques-garnier.com/le-capitaine-fracasse-texte-complet-1863.html>

### [TODO]{.todo .TODO} Le Roman de la momie précédé de trois contes antiques Une Nuit {#le-roman-de-la-momie-précédé-de-trois-contes-antiques-une-nuit}

de Cléopâtre, Le Roi Candaule, Arria Marcella

<https://classiques-garnier.com/le-roman-de-la-momie-precede-de-trois-contes-antiques-une-nuit-de-cleopatre-le-roi-candaule-arria-marcella.html>

### [TODO]{.todo .TODO} Émaux et Camées Texte définitif (1872) suivi de Poésies {#émaux-et-camées-texte-définitif-1872-suivi-de-poésies}

choisies

<https://classiques-garnier.com/emaux-et-camees-texte-definitif-1872-suivi-de-poesies-choisies.html>

### [TODO]{.todo .TODO} Souvenirs romantiques

<https://classiques-garnier.com/souvenirs-romantiques-hugo-nerval-balzac-lamartine-heine-madame-de-girardin-les-cenacles-1830-baudelaire.html>

### [TODO]{.todo .TODO} Fortunio et autres nouvelles

<https://classiques-garnier.com/fortunio-et-autres-nouvelles-textes-complets-1833-1849.html>

### [TODO]{.todo .TODO} L\'Œuvre fantastique. Tome I

<https://classiques-garnier.com/l-oeuvre-fantastique-tome-i-nouvelles-1.html>

### [TODO]{.todo .TODO} L\'Œuvre fantastique. Tome II

<https://classiques-garnier.com/l-oeuvre-fantastique-tome-ii-romans-1.html>

### [TODO]{.todo .TODO} Théâtre de poche

<https://classiques-garnier.com/gautier-theophile-theatre-de-poche-1.html>

## [TODO]{.todo .TODO} Théophile de Viau

### [TODO]{.todo .TODO} Œuvres poétiques suivies des Amours tragiques de Pyrame et {#œuvres-poétiques-suivies-des-amours-tragiques-de-pyrame-et}

Thisbé

<https://classiques-garnier.com/viau-theophile-de-oeuvres-poetiques-suivies-des-amours-tragiques-de-pyrame-et-thisbe.html>

## [TODO]{.todo .TODO} Timothy D. Allman

### [TODO]{.todo .TODO} La Floride

<https://classiques-garnier.com/la-floride-coeur-revelateur-des-etats-unis-1.html>

## [TODO]{.todo .TODO} Toussaint Louverture

### [TODO]{.todo .TODO} Mémoires

<https://classiques-garnier.com/memoires.html>

## [TODO]{.todo .TODO} Tristan L\'Hermite

### [TODO]{.todo .TODO} Les Amours et autres poésies choisies

<https://classiques-garnier.com/les-amours-et-autres-poesies-choisies.html>

## [TODO]{.todo .TODO} Victor Hugo

### [TODO]{.todo .TODO} Les Contemplations

<https://classiques-garnier.com/les-contemplations.html>

### [TODO]{.todo .TODO} La Légende des siècles

<https://classiques-garnier.com/la-legende-des-siecles.html>

### [TODO]{.todo .TODO} Les Misérables. Tome II

<https://classiques-garnier.com/les-miserables-tome-ii.html>

### [TODO]{.todo .TODO} Les Misérables. Tome I

<https://classiques-garnier.com/les-miserables-tome-i.html>

### [TODO]{.todo .TODO} Notre-Dame de Paris 1482

<https://classiques-garnier.com/notre-dame-de-paris-1482.html>

### [TODO]{.todo .TODO} Quatre-vingt-treize

<https://classiques-garnier.com/quatre-vingt-treize.html>

### [TODO]{.todo .TODO} Les Feuilles d\'automne suivies des Chants du crépuscule

<https://classiques-garnier.com/les-feuilles-d-automne-suivies-des-chants-du-crepuscule.html>

### [TODO]{.todo .TODO} Les Voix intérieures suivies de Les Rayons et les Ombres

<https://classiques-garnier.com/les-voix-interieures-suivies-de-les-rayons-et-les-ombres.html>

## [TODO]{.todo .TODO} Volney

### [TODO]{.todo .TODO} Les Ruines ou Méditation sur les révolutions des empires {#les-ruines-ou-méditation-sur-les-révolutions-des-empires}

suivies de La Loi naturelle et de l\'Histoire de Samuel

<https://classiques-garnier.com/les-ruines-ou-meditation-sur-les-revolutions-des-empires-suivies-de-la-loi-naturelle-et-de-l-histoire-de-samuel.html>

## [TODO]{.todo .TODO} William Shakespeare

### [TODO]{.todo .TODO} Théâtre complet. Tome I

<https://classiques-garnier.com/shakespeare-william-theatre-complet-tome-i.html>

### [TODO]{.todo .TODO} Théâtre complet. Tome II

<https://classiques-garnier.com/shakespeare-william-theatre-complet-tome-ii.html>

### [TODO]{.todo .TODO} Théâtre complet. Tome III

<https://classiques-garnier.com/shakespeare-william-theatre-complet-tome-iii.html>

## [TODO]{.todo .TODO} Xavier de Maistre

### [TODO]{.todo .TODO} Œuvres complètes

<https://classiques-garnier.com/maistre-xavier-de-oeuvres-completes.html>

## [TODO]{.todo .TODO} Xénophon

### [TODO]{.todo .TODO} Helléniques

<https://classiques-garnier.com/helleniques-1.html>

### [TODO]{.todo .TODO} L\'Anabase ou l\'Expédition des Dix-Mille

<https://classiques-garnier.com/l-anabase-ou-l-expedition-des-dix-mille-1.html>

## [TODO]{.todo .TODO} cardinal de Retz

### [TODO]{.todo .TODO} Mémoires précédés de La Conjuration du comte de Fiesque. Tome I

<https://classiques-garnier.com/memoires-precedes-de-la-conjuration-du-comte-de-fiesque-tome-i-1613-1649.html>

### [TODO]{.todo .TODO} Mémoires. Tome II

<https://classiques-garnier.com/memoires-tome-ii-1650-1655.html>

## [TODO]{.todo .TODO} saint Bernard de Clairvaux

### [TODO]{.todo .TODO} Lectures spirituelles sur la vie chrétienne

<https://classiques-garnier.com/lectures-spirituelles-sur-la-vie-chretienne.html>

## [TODO]{.todo .TODO} saint François de Sales

### [TODO]{.todo .TODO} Introduction à la vie dévote

<https://classiques-garnier.com/introduction-a-la-vie-devote.html>

### [TODO]{.todo .TODO} Lettres choisies. Tome I

<https://classiques-garnier.com/lettres-choisies-tome-i-lettres-1-131-lettres-i-cxxxi.html>

### [TODO]{.todo .TODO} Lettres choisies. Tome II

<https://classiques-garnier.com/lettres-choisies-tome-ii-lettres-132-320-lettres-cxxxii-cccxx.html>

### [TODO]{.todo .TODO} Lectures spirituelles sur la piété

<https://classiques-garnier.com/lectures-spirituelles-sur-la-piete.html>

## [TODO]{.todo .TODO} saint Louis de Grenade

### [TODO]{.todo .TODO} Lectures spirituelles sur les fêtes de la très sainte Vierge

<https://classiques-garnier.com/lectures-spirituelles-sur-les-fetes-de-la-tres-sainte-vierge.html>

## [TODO]{.todo .TODO} Émile Zola

### [TODO]{.todo .TODO} Nana

<https://classiques-garnier.com/nana.html>

### [TODO]{.todo .TODO} Germinal

<https://classiques-garnier.com/germinal.html>

## [TODO]{.todo .TODO} Éric Thierry

### [TODO]{.todo .TODO} La France de Henri IV en Amérique du Nord

<https://classiques-garnier.com/la-france-de-henri-iv-en-amerique-du-nord-de-la-creation-de-l-acadie-a-la-fondation-de-quebec-1.html>

## [TODO]{.todo .TODO} Étienne Jodelle

### [TODO]{.todo .TODO} L\'Eugène

<https://classiques-garnier.com/l-eugene.html>

## [TODO]{.todo .TODO} Évariste de Parny

### [TODO]{.todo .TODO} Œuvres

## [DONE]{.done .DONE} Ajouter type de pdf

# KILL Que sais-je (Cairn)

Déjà disponible

# [TODO]{.todo .TODO} Cairn

## [TODO]{.todo .TODO} Histoire

Liste ici : 1773 livres
<https://www-cairn-info.bases-doc.univ-lorraine.fr/liste-des-ouvrages.php?editeur=&discipline=3>

### [TODO]{.todo .TODO} \[#B\] Nouvelle clio as ebook

52 livres
<https://www-cairn-info.bases-doc.univ-lorraine.fr/liste-des-ouvrages.php?searchTermAccess=all&editeur=PUF&collection=PUF_NOCLI&discipline=3&orderby=titre>
Exemple de requete

-\> ok jusque e-christianisme-de-constantin-a-la-conquete-arabe

1.  DONE Récupérer HTML
2.  DONE Conversion epub
3.  TODO Canada et États-Unis depuis 1770 - Claude Fohlen
4.  TODO Conquête et exploitation des nouveaux mondes - Pierre Chaunu
5.  TODO Enfance de l\'Europe. Aspects économiques et sociaux - Robert
    Fossier
6.  TODO Enfance de l\'Europe. Aspects économiques et sociaux. - Robert
    Fossier
7.  TODO États, sociétés et cultures du Monde musulman médiéval -
    Jean-Claude Garcin
8.  TODO Expansion européenne et décolonisation - Jean-Louis Miège
9.  TODO Guerre et société à l\'époque moderne - Jean Chagniot
10. TODO Histoire d\'Angleterre - Bernard Cottret
11. TODO Histoire de l\'URSS - Andrea Graziosi
12. TODO Histoire de la civilisation romaine - Hervé Inglebert
13. TODO Histoire des techniques - Liliane Hilaire-Pérez
14. TODO L\'Afrique noire, de 1800 à nos jours - Catherine
    Coquery-Vidrovitch
15. TODO L\'Amérique latine de l\'Indépendance à nos jours - François
    Chevalier
16. TODO L\'Asie orientale et méridionale aux XIX - Hartmut O. Rotermund
17. TODO L\'Égypte et la vallée du Nil. Tome 2 - Claude Vandersleyen
18. TODO L\'Égypte et la vallée du Nil. Tome 3 - Frédéric Payraudeau
19. TODO L\'Europe celtique à l\'âge du Fer - Olivier Buchsenschutz
20. TODO L\'Europe culturelle et religieuse de 1815 à nos jours - Paul
    Gerbod
21. TODO L\'Europe du Nord-Ouest et du Nord - Pierre Jeannin
22. TODO L\'expansion européenne - Frédéric Mauro
23. TODO L\'expansion européenne du XIII - Pierre Chaunu
24. TODO L\'expansion musulmane - Robert Mantran
25. TODO La préhistoire dans le monde - José Garanger
26. TODO La protohistoire de l\'Europe - Jan Lichardus
27. TODO La Russie impériale - Pierre Gonneau
28. TODO Le catholicisme entre Luther et Voltaire - Jean Delumeau
29. TODO Le christianisme de Constantin à la conquête arabe - Pierre
    Maraval
30. TODO Le christianisme des origines à Constantin - Simon Claude
    Mimouni
31. TODO Le judaïsme ancien du VI - Simon Claude Mimouni
32. TODO Le judaïsme et le christianisme antique - André Benoit
33. TODO Le monde byzantin I - Cécile Morrisson
34. TODO Le monde byzantin II - Jean-Claude Cheynet
35. TODO Le monde byzantin III - Angeliki Laiou
36. TODO Le monde grec aux temps classiques. Tome 2 - Pierre Brulé
37. TODO Le monde hellénistique. Tome 1 - Claire Préaux
38. TODO Le monde hellénistique. Tome 2 - Claire Préaux
39. TODO Le Proche-Orient Asiatique. Tome 1 - Paul Garelli
40. TODO Le XIII - Léopold Genicot
41. TODO Les Grecs et la Méditerranée orientale - Claude Baurain
42. TODO Les invasions - les vagues germaniques - Lucien Musset
43. TODO Les Latins en Orient - Michel Balard
44. TODO Les Pays nordiques aux XIXe et XXe siècles - Jean-Jacques Fol
45. TODO L\'Europe au XVIe siècle - Alain Tallon
46. TODO L\'Europe de 1815 à nos jours - Georges-Henri Soutou
47. TODO Mentalités médiévales - Hervé Martin
48. TODO Mentalités médiévales. Tome 2 - Hervé Martin
49. TODO Naissance et affirmation de la Réforme - Jean Delumeau
50. TODO Rome et l\'intégration de l\'Empire - Tome 2 - Claude Lepelley
51. TODO Rome et l\'intégration de l\'Empire (44 av. J.-C.-260 ap.
    J.-C.). Tome 1 - François Jacques
52. TODO Rome et la conquête du monde méditerranéen (264-27 av. J.-C.).
    Tome 1 - Claude Nicolet
53. TODO Rome et la conquête du monde méditerranéen (264-27 av. J.-C.).
    Tome 2 - Claude Nicolet
54. TODO Rome et la Méditerranée occidentale jusqu\'aux guerres
    puniques - Jacques Heurgon

### [TODO]{.todo .TODO} \[#A\] Collection U as ebook \[2/103\]

101 ouvrages
<https://www-cairn-info.bases-doc.univ-lorraine.fr/liste-des-ouvrages.php?searchTermAccess=all&editeur=&collection=ARCO_U&discipline=3&orderby=titre&offset=100>

1.  DONE Récupérer HTML

2.  DONE Générer ebook

3.  TODO [Citoyenneté, République et Démocratie en
    France](https://www.cairn.info/citoyennete-republique-et-democratie-en-france--9782200294045.htm)

4.  TODO [Croisades et Orient latin : XIe-XIVe
    siècle](https://www.cairn.info/croisades-et-orient-latin--9782200264987.htm)

    1.  DONE Corriger
    2.  TODO Uploader
    3.  TODO Notes
    4.  DONE Uploader

5.  TODO [Droit de conquête et droits des
    Indiens](https://www.cairn.info/droit-de-conquete-et-droits-des-indiens--9782200293055.htm)

6.  TODO [Église et société en
    Occident](https://www.cairn.info/eglise-et-societe-en-occident--9782200355876.htm)

7.  TODO [Église et société en
    Occident](https://www.cairn.info/eglise-et-societe-en-occident-xiiie-xve-siecles--9782200267636.htm)

8.  TODO [Famille et société dans le monde grec et en
    Italie](https://www.cairn.info/famille-et-societe-dans-le-monde-grec-et-en-italie--9782200625627.htm)

9.  TODO [Film et
    histoire](https://www.cairn.info/film-et-histoire--9782200345570.htm)

10. TODO [Géohistoire de la
    mondialisation](https://www.cairn.info/geohistoire-de-la%20mondialisation--9782200602949.htm)

11. TODO [Histoire culturelle de la France au XIXe
    siècle](https://www.cairn.info/histoire-culturelle-de-la-france-au-xixe-siecle--9782200353278.htm)

12. TODO [Histoire de
    l\'art](https://www.cairn.info/histoire-de-l-art--9782200622350.htm)

13. TODO [Histoire de
    l\'Autriche](https://www.cairn.info/histoire-de-l-autriche--9782200355906.htm)

14. TODO [Histoire de l\'Espagne
    contemporaine](https://www.cairn.info/histoire-de-l-espagne-contemporaine--9782200614607.htm)

15. TODO [Histoire de l\'Europe de
    l\'Est](https://www.cairn.info/histoire-de-l-europe-de-l-est--9782200248994.htm)

16. TODO [Histoire de l\'Italie depuis 1943 à nos
    jours](https://www.cairn.info/histoire-de-l-italie-depuis-1943-a-nos-jours--9782200262150.htm)

17. TODO [Histoire de
    l\'Océanie](https://www.cairn.info/histoire-de-l-oceanie--9782200601300.htm)

18. TODO [Histoire de la globalisation
    financière](https://www.cairn.info/histoire-de-la-globalisation-financiere--9782200355388.htm)

19. TODO [Histoire de la presse en
    France](https://www.cairn.info/histoire-de-la-presse-en-france--9782200613327.htm)

20. TODO [Histoire de la République Populaire de
    Chine](https://www.cairn.info/histoire-de-la-republique-populaire-de-chine--9782200614881.htm)

21. TODO [Histoire des
    bibliothèques](https://www.cairn.info/histoire-des-bibliotheques--9782200616250.htm)

22. TODO [Histoire des
    États-Unis](https://www.cairn.info/histoire-des-etats-unis--9782200618094.htm)

23. TODO [Histoire des pays
    d\'Islam](https://www.cairn.info/histoire-des-pays-d-islam--9782200618421.htm)

24. TODO [Histoire des sciences à l\'époque
    moderne](https://www.cairn.info/histoire-des-sciences-epoque-moderne--9782200345211.htm)

25. TODO [Histoire du christianisme en
    France](https://www.cairn.info/histoire-du-christianisme-en-france--9782200290665.htm)

26. TODO [Histoire du livre en
    Occident](https://www.cairn.info/histoire-du-livre-en-occident--9782200277512.htm)

27. TODO [Histoire économique de l\'Afrique
    tropicale](https://www.cairn.info/histoire-economique-de-l-afrique-tropicale--9782200602642.htm)

28. TODO [Histoire politique de la Ve
    République](https://www.cairn.info/histoire-politique-de-la-v-e-republique--9782200346935.htm)

29. TODO [Histoire
    romaine](https://www.cairn.info/histoire-romaine--9782200622909.htm)

30. TODO [Hommes et femmes d\'Égypte
    (IV](https://www.cairn.info/hommes-et-femmes-d-egypte-ive-siecle-av-n-e--9782200346454.htm)

31. TODO [Impérialisme et démocratie à
    Athènes](https://www.cairn.info/imperialisme-et-democratie-a-athenes--9782200269289.htm)

32. TODO [L\'Afrique du 20e siècle à nos
    jours](https://www.cairn.info/l-afrique-du-20-e-siecle-a-nos-jours--9782200285074.htm)

33. TODO [L\'Allemagne de 1870 à nos
    jours](https://www.cairn.info/l-allemagne-de-1870-a-nos-jours--9782200285050.htm)

34. TODO [L\'Amérique
    ibérique](https://www.cairn.info/l-amerique-iberique--9782200625641.htm)

35. TODO [L\'Anatolie
    hellénistique](https://www.cairn.info/l-anatolie-hellenistique--9782200268329.htm)

36. TODO [L\'aristocratie
    médiévale](https://www.cairn.info/l-aristocratie-medievale--9782200262938.htm)

37. TODO [L\'armée
    romaine](https://www.cairn.info/l-armee-romaine--9782200276539.htm)

38. TODO [L\'éducation physique de 1945 à nos
    jours](https://www.cairn.info/education-physique-de-1945-a-nos-jours--9782200600686.htm)

39. TODO [L\'Égypte grecque et
    romaine](https://www.cairn.info/l-egypte-grecque-et-romaine--9782200262884.htm)

40. TODO [L\'Empire
    austro-hongrois](https://www.cairn.info/l-empire-austro-hongrois--9782200248888.htm)

41. TODO [L\'Europe](https://www.cairn.info/l-europe--9782200601386.htm)

42. TODO [L\'Europe au
    19](https://www.cairn.info/l-europe-au-19-e-siecle--9782200622565.htm)

43. TODO [L\'Europe centrale et
    orientale](https://www.cairn.info/l-europe-centrale-et-orientale--9782200602635.htm)

44. TODO [L\'héritage ambigu de la
    colonisation](https://www.cairn.info/l-heritage-ambigu-de-la-colonisation--9782200281335.htm)

45. TODO [L\'histoire
    immédiate](https://www.cairn.info/l-histoire-immediate--9782200277390.htm)

46. TODO [La construction de
    l\'Europe](https://www.cairn.info/la-construction-de-l-europe--9782200353056.htm)

47. TODO [La culture matérielle de la
    France](https://www.cairn.info/la-culture-materielle-de-la-france--9782200286569.htm)

48. TODO [La famille en France à l\'époque
    moderne](https://www.cairn.info/la-famille-en-france-a-l-epoque-moderne--9782200244170.htm)

49. TODO [La France à l\'époque
    moderne](https://www.cairn.info/la-france-a-l-epoque-moderne--9782200626181.htm)

50. TODO [La France au
    XIX](https://www.cairn.info/la-france-au-xix-e-siecle--9782200622596.htm)

51. TODO [La France et l\'Europe de
    Napoléon](https://www.cairn.info/la-france-et-l-europe-de-napoleon--9782200265335.htm)

52. TODO [La Grande-Bretagne et le
    monde](https://www.cairn.info/la-grande-bretagne-et-le-monde--9782200244576.htm)

53. TODO [La guerre dans le monde
    grec](https://www.cairn.info/la-guerre-dans-le-monde-grec--9782200600297.htm)

54. TODO [La péninsule Ibérique aux
    époques romaines](https://www.cairn.info/la-peninsule-iberique-aux-epoques-romaines--9782200268336.htm)

55. TODO [La République romaine et son
    empire](https://www.cairn.info/la-republique-romaine-et-son-empire--9782200622053.htm)

56. TODO [La Révolution
    française](https://www.cairn.info/la-revolution-francaise--9782200627690.htm)

57. TODO [La Révolution française et l\'histoire du
    monde](https://www.cairn.info/La-revolution-francaise-et-l-histoire-du-monde--9782200257699.htm)

58. TODO [La société du haut Moyen
    Âge](https://www.cairn.info/la-societe-du-haut-moyen-age--9782200265779.htm)

59. TODO [La société française de 1945 à nos
    jours](https://www.cairn.info/la-societe-francaise-de-1945-a-nos-jours--9782200613082.htm)

60. TODO [Le christianisme
    antique](https://www.cairn.info/le-christianisme-antique--9782200626914.htm)

61. TODO [Le christianisme occidental au Moyen
    Âge](https://www.cairn.info/le-christianisme-occidental-au-moyen-age--9782200251871.htm)

62. TODO [Le Maghreb par les
    textes](https://www.cairn.info/le-maghreb-par-les-textes--9782200627294.htm)

63. TODO [Le monde grec à l\'époque
    classique](https://www.cairn.info/le-monde-grec-a-l-epoque-classique--9782200614713.htm)

64. TODO [Le monde
    hellénistique](https://www.cairn.info/monde-hellenistique--9782200618179.htm)

65. TODO [Le Reich
    allemand](https://www.cairn.info/le-reich-allemand--9782200262334.htm)

66. TODO [Le
    Saint-Empire](https://www.cairn.info/saint-empire-1500-1800--9782200617639.htm)

67. TODO [Le Second
    Empire](https://www.cairn.info/le-second-empire--9782200246075.htm)

68. TODO [Le
    XX](https://www.cairn.info/le-xx-e-siecle--9782200271534.htm)

69. TODO [Les accords d\'Evian
    (1962)](https://www.cairn.info/les-accords-d-evian--9782200249076.htm)

70. TODO [Les années
    1970](https://www.cairn.info/les-annees-1970--9782200623289.htm)

71. TODO [Les décolonisations au
    XX](https://www.cairn.info/les-decolonisations-au-xxe-siecle--9782200249458.htm)

72. TODO [Les États-Unis et le monde au 19e
    siècle](https://www.cairn.info/les-etats-unis-et-le-monde-au-19e-siecle--9782200266929.htm)

73. TODO [Les femmes dans la France
    moderne](https://www.cairn.info/les-femmes-dans-la-france-moderne--9782200601584.htm)

74. TODO [Les femmes, actrices de l\'histoire France, de 1789 à nos
    jours](https://www.cairn.info/les-femmes-actrices-histoire-de-france--9782200246549.htm)

75. TODO [Les mondes méditerranéens au Moyen
    Âge](https://www.cairn.info/les-mondes-mediterraneens-au-moyen-age--9782200620288.htm)

76. TODO [Les ouvriers en
    France](https://www.cairn.info/les-ouvriers-en-france--9782200277420.htm)

77. TODO [Les Perses vus par les
    Grecs](https://www.cairn.info/les-perses-vus-par-les-grecs--9782200270353.htm)

78. TODO [Les Provinces-Unies à l\'époque
    moderne](https://www.cairn.info/les-provinces-unies-a-l-epoque-moderne--9782200614515.htm)

79. TODO [Les relations internationales dans l\'Europe
    moderne](https://www.cairn.info/les-relations-internationales-dans-l-europe-modern--9782200623005.htm)

80. TODO [Les relations internationales depuis
    1945](https://www.cairn.info/les-relations-internationales-depuis-1945--9782200622558.htm)

81. TODO [Les sociétés en
    guerre](https://www.cairn.info/les-societes-en-guerre--9782200265649.htm)

82. TODO [Les villes portuaires maritimes dans la France
    moderne](https://www.cairn.info/les-villes-portuaires-maritimes-dans-la-france--9782200278205.htm)

83. TODO [L\'affaire
    Dreyfus](https://www.cairn.info/l-affaire-dreyfus--9782200244163.htm)

84. TODO [L\'alimentation en Europe à l\'époque
    moderne](https://www.cairn.info/l-alimentation-en-europe-a-l-epoque-moderne--9782200244071.htm)

85. TODO [L\'empire colonial français de Richelieu à
    Napoléon](https://www.cairn.info/l-empire-colonial-francais-de-richelieu-a-napoleon--9782200354909.htm)

86. TODO [L\'enseignement de l\'Histoire en
    France](https://www.cairn.info/l-enseignement-de-l-histoire-en-france--9782200262754.htm)

87. TODO [L\'Italie
    fasciste](https://www.cairn.info/l-italie-fasciste--9782200614584.htm)

88. TODO [Manuel
    d\'archéologie](https://www.cairn.info/manuel-d-archeologie--9782200266769.htm)

89. TODO [Manuel d\'archéologie médiévale et
    moderne](https://www.cairn.info/manuel-d-archeologie-medievale-et-moderne--9782200281397.htm)

90. TODO [Manuel d\'histoire
    globale](https://www.cairn.info/manuel-d-histoire-globale--9782200278995.htm)

91. TODO [Naissance de l\'Italie
    contemporaine](https://www.cairn.info/naissance-de-litalie-contemporaine--9782200267926.htm)

92. TODO [Paysans et seigneurs au
    Moyen-Age](https://www.cairn.info/paysans-et-seigneurs-au-moyen-age--9782200618162.htm)

93. TODO [Petite histoire de la
    France](https://www.cairn.info/petite-histoire-de-la-france--9782200285128.htm)

94. TODO [Pouvoir et religion en
    Europe](https://www.cairn.info/pouvoir-et-religion-en-europe--9782200623463.htm)

95. TODO [Pouvoir royal et institutions dans la France
    moderne](https://www.cairn.info/pouvoir-royal-et-institutions-dans-la-france-moder--9782200613075.htm)

96. TODO [Précis d\'histoire
    européenne](https://www.cairn.info/precis-d-histoire-europeenne--9782200601188.htm)

97. TODO [Révoltes et répressions dans la France
    moderne](https://www.cairn.info/revoltes-et-repressions-dans-la-france-moderne--9782200274900.htm)

98. TODO [Rome et le monde
    provincial](https://www.cairn.info/rome-et-le-monde-provincial--9782200249526.htm)

99. TODO [Rome. Paysage urbain et
    idéologie](https://www.cairn.info/rome-paysage-urbain-et-ideologie--9782200263843.htm)

100. TODO [Royauté et idéologie au Moyen
     Âge](https://www.cairn.info/royaute-et-ideologie-au-moyen-age--9782200249212.htm)

101. TODO [Sparte](https://www.cairn.info/sparte--9782200618148.htm)

102. TODO [Un siècle d\'histoire culturelle en
     France](https://www.cairn.info/un-siecle-d-histoire-culturelle-en-france--9782200286637.htm)

103. TODO [Une histoire culturelle des
     États-Unis](https://www.cairn.info/une-histoire-culturelle-des-etats-unis--9782200278588.htm)

# [TODO]{.todo .TODO} Askhistorians

## [TODO]{.todo .TODO} Goodreads non à jour -\> utiliser le wiki

Pandoc ou HTML ? v1: seulement les liens et \"manuel\" ? Utiliser pandoc
?
