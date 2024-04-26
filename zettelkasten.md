---
title: Zettelkasten
---

# zk-org-zk

Configuration avec nushell
Attente de résolution de https://github.com/zk-org/zk/issues/279
```nu
$env.ZK_SHELL = bash
```
Graph
```sh
 zk list --tag cli --format json | mustache graph.mustache | dot -Tpng > picture.png
```sh
