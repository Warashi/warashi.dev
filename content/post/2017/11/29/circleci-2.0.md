---
categories: []
date: "2017-11-29T18:57:20+09:00"
type: post
tags: []
title: CircleCI 2.0
---

このブログのHTML生成にはCircleCIでHugoを動かしているんですが、今までCircleCIのバージョン1を使っていたのをバージョン2に移行しました。
移行のためにDockerコンテナを作るところから始める、というちょっと面倒な事態になりましたが、なんとか移行完了したのでちょっと記事書くかなって感じです。

まず先にこのブログのリポジトリ構成をちょっと書いておくと、sourceブランチにHugoに渡すMarkdownとかがあって、masterブランチには生成されたHTMLとかがある、という構成になってます。
つまり、sourceブランチを取ってきて、Hugoを走らせて、結果public以下にできるファイル群をmasterブランチにpushすればいいことになります。

これをするために作ったDockerコンテナのGitHubリポジトリが[こちら](https://github.com/Warashi/docker-alpine-hugo-git-ssh-rsync)。
とりあえずalpineで、なんとなく使いそうだったコマンドを入れてある感じになります。

そして、CircleCIの設定ファイルが[こちら](https://github.com/Warashi/warashi.github.io/blob/source/.circleci/config.yml)。
これを参考にしてもらえば、このブログと同じことができるはずになってます。

誰かの助けになれば幸いです。
