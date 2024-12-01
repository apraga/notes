Problèmes mineurs :
- installer les LSP à la main
- pas de spellcheck : (vale pour markdown ok. Procédure : [https://github.com/helix-editor/helix/discussions/3637#discussioncomment-9867577](Github). 
Il faut .vale.ini dans le projet ou dans ~/.config/vale/.vale.ini. Par exemple:

```
MinAlertLevel = suggestion

[*]
BasedOnStyles = Vale
```
