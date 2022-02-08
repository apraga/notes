# org-nutrition Tracker de calories (lisp)
### Offline ?
1.  Data
    <https://fdc.nal.usda.gov/download-datasets.html> Notamment : full
    <https://fdc.nal.usda.gov/fdc-datasets/FoodData_Central_csv_2021-04-28.zip>
    CSV <https://github.com/mrc/el-csv> SQL
    <https://github.com/skeeto/emacsql>

### KILL REST ?

<https://tkf.github.io/emacs-request/>
<https://fdc.nal.usda.gov/api-guide.html>

### KILL Comparer REST et offline en performances

REST: search renvoie vraiment trop de résultats... Plus logique de le
faire avec le CSV mais les données sont éparpillées

### [TODO]{.todo .TODO} comprendr les données {#comprendr-les-données}

1.  Exploration

    Doc: <https://fdc.nal.usda.gov/portal-data/external/dataDictionary>
    food.csv: contient l\'identifiant (fdc~id~) et le nom (description)
    ex:
    \"fdc~id~\",\"data~type~\",\"description\",\"food~categoryid~\",\"publication~date~\"

    food~nutrient~.csv contient l\'information intéressante pour l\'ID
    (fdc~id~)
    \"id\",\"fdc~id~\",\"nutrient~id~\",\"amount\",\"data~points~\",\"derivation~id~\",\"min\",\"max\",\"median\",\"footnote\",\"min~yearacquired~\"

    Exemple : huile WESSON (fdc~id~ = 1105904) : foods.csv:
    \"1105904\",\"branded~food~\",\"WESSON Vegetable Oil 1
    GAL\",\"\",\"2020-11-13\"

    A beaucoup de nutrients : food~nutrients~.csv:
    \"1009437\",\"1105904\",\"\",\"\",\"Ingredients\",\"3\"
    \"13706913\",\"1105904\",\"203\",\"0\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706914\",\"1105904\",\"204\",\"93.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706915\",\"1105904\",\"205\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706916\",\"1105904\",\"208\",\"867\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706917\",\"1105904\",\"269\",\"0\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706918\",\"1105904\",\"291\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706919\",\"1105904\",\"301\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706920\",\"1105904\",\"303\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706921\",\"1105904\",\"306\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706922\",\"1105904\",\"307\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706923\",\"1105904\",\"318\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706924\",\"1105904\",\"324\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706925\",\"1105904\",\"401\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706926\",\"1105904\",\"601\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706927\",\"1105904\",\"605\",\"0\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706928\",\"1105904\",\"606\",\"13.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706929\",\"1105904\",\"645\",\"20\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706930\",\"1105904\",\"646\",\"53.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"

    En enlevant ceux qui sont nul (amount = 0)
    \"1009437\",\"1105904\",\"\",\"\",\"Ingredients\",\"3\"
    \"13706914\",\"1105904\",\"204\",\"93.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706916\",\"1105904\",\"208\",\"867\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706914\",\"1105904\",\"204\",\"93.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706916\",\"1105904\",\"208\",\"867\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"

    En enlevant ceux qui sont redondant, on retrouve 5 (différents des 3
    mentionnés ??) food~nutrients~.csv
    \"13706914\",\"1105904\",\"204\",\"93.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706916\",\"1105904\",\"208\",\"867\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706928\",\"1105904\",\"606\",\"13.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706929\",\"1105904\",\"645\",\"20\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706930\",\"1105904\",\"646\",\"53.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"

    Les codes ne correspondent pas à nutrient.csv ou
    nutrient~incomingname~. mais d\'après le site
    <https://fdc.nal.usda.gov/fdc-app.html#/food-details/1455596/nutrients>
    (au passage, l\'ID est encore différent) :

    -   204 = lipid
    -   208 = énergie
    -   606 = fat total saturated
    -   645 = fat total monounsaturated
    -   646 = fat total polyunsaturated

    En fait, le code est donné par nutrient~nbr~ dans nutrients.csv (!)

2.  En résumé

    Requirements : food.csv, nutrient.csv, food~nutrients~.csv

    1.  Chercher l\'ID dans food.csv (nom = description, id = fdc~id~)
    2.  Pour fdc~id~, obtenir la liste des nutriments (nutrient~id~)
        avec leurs valeurs (amonut) dans food~nutrients~.csv
    3.  Convertir l\'Id nutrient (nutrient~nbr~ = nutrient~id~) en son
        nom (nutrient~nbr~)avec nutrient.csv

# Vc-darcs
- [ ] Corriger record
- Ajouter support pour push 

