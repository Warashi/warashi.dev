---
categories: []
date: "2017-04-22T09:03:51+09:00"
type: post
tags: []
title: ブログはじめました
---

[Hugo](//gohugo.io) を使ってブログを始めました。
ブログの生成元ファイル群は[ここ](//github.com/Warashi/warashi.github.io)にあります。
[Circle CI](//ciecleci.com) を使って1リポジトリの複数ブランチでソースと生成結果を管理してます。
よかったら参考にどうぞ。

Theme には [AMP](//github.com/pdevty/amp) を使ってます。
シンプルでよいテーマだと思います。

ちょっとだけ説明しておくと、`public`ディレクトリを`submodule`にしておいて、更新の直前で`git checkout master`するっていうなんとも変則的な方法を使ってます。
なんとなく`circle.yml`や環境変数にリポジトリ名を入れたくなかったのでこうなりました。

どんなことを書くかはまだ未定ですが、やる気の起きた日に更新していきます。
