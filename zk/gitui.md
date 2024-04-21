Problème : "bad credentials" pour push/pull
https://github.com/extrawurst/gitui/issues/495

Hack (nushell)

❯ ^ssh-agent -c
∙     | lines
∙     | first 2
∙     | parse "setenv {name} {value};"
∙     | transpose -r
∙     | into record
∙     | load-env
∙ 

ssh-add ~/.ssh/id_rsa
