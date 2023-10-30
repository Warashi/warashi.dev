---
title: "Go Commits in This Week at 2022-05-14"
date: 2022-05-14T10:45:03+09:00
type: post
tags: [Go]
draft: false
---
# [math/big: don't force second arg to Jacobi and Int.ModSqrt to escape · golang/go@831f116](https://github.com/golang/go/commit/831f1168289e65a7ef49942ad8d16cf14af2ef43)
Goはコンパイル時のエスケープ解析で変数のアロケート場所がスタックとヒープに決まります。
このコミットはほんのちょっとの変更でスタックにアロケートできたという変更です。
普段僕たちが書く時はここまでカリカリのチューニングをする前にもうちょっと他の改善がありそうですが、もし必要になったときは参考にできそうですね。

# [archive/zip: permit zip files to have prefixes · golang/go@df57592](https://github.com/golang/go/commit/df57592276bc26e2eb4e4ca5e77e4e2e422c7c6b)
自己展開型のzipファイルなどはzipファイルの先頭に自分自身を展開するためのコードが入っています。
今までのコードではそれをうまく取り扱えていなかったのを、取り扱えるようにしたという変更です。

# [internal/abi, internal/buildcfg: enable regabi on riscv64 by default · golang/go@53f1312](https://github.com/golang/go/commit/53f13128a7a4c7d16af5ea9ca5f25b56ff9881fe)
Go 1.17から内部のABIを徐々にレジスタベースに変更しているのですが、それをRISC-Vに適用するという変更ですね。

# [net/http: close accepted connection · golang/go@1ce7fcf](https://github.com/golang/go/commit/1ce7fcf139417d618c2730010ede2afb41664211)
## [Revert "net/http: close accepted connection" · golang/go@c14ed5b](https://github.com/golang/go/commit/c14ed5b37c6cc387b29a7939cad7c7cbccd59934)
net/httpのServerはShutdownを呼ばれたときにコネクションをcloseします。
それが一部うまくいっていなかったのを修正した…のですが、graceful shutdownでバグがあったようでrevertされています。

# [go/doc: group play example imports · golang/go@59ef3a9](https://github.com/golang/go/commit/59ef3a966b38cb2ac537d1be43f0b8fd2468ea70)
Goは ExampleXXX というテストを書くと pkg.go.dev 上で実行可能な例として表示されます。
その例を表示する際に、importのグルーピング(\*) を壊してしまっていたのを壊さないようにする変更です。

(\*): importを空行で分割して複数のグループがあるように見せること。

# [go/printer: align expression list elements containing tabs · golang/go@bf68170](https://github.com/golang/go/commit/bf68170c638e7e69bedcc64fadfd83354fd06c10)
タブ文字がstring literal中などインデント以外で使われているときにgofmtの挙動がおかしかったようです。

# [cmd/compile: fix bad order of evaluation for multi-value f()(g()) calls · golang/go@7b314d2](https://github.com/golang/go/commit/7b314d27ce5dbc31eed2076e28c0af4ea8c24473)
このような呼び出しが記述されているとき、言語仕様に従うなら `f()` → `t1()` → `t2()` の順に評価されます。
これが、現在は違う順序での評価となっていたものを修正するコミットです。
```go
f()(t1(), t2())
```

# [go/build: replace ioutil.ReadDir with os.ReadDir · golang/go@5362827](https://github.com/golang/go/commit/536282763f7357edd81d85993c12fd977fecd378)
`ioutil.ReadDir` を `os.ReadDir` に置き換えるPRです。
Go1.16からioutilは他のパッケージに同等のものが実装され、新しいコードでのioutilの利用は推奨されていません。
Go内部でもまだ利用があった箇所を修正するコミットですが、これだけでパフォーマンスが上がるので積極的に置き換えていきたいですね。

# [runtime: measure stack usage; start stacks larger if needed · golang/go@016d755](https://github.com/golang/go/commit/016d7552138077741a9c3fdadc73c0179f5d3ff7)
stackの利用状況を計測して、goroutineを立ち上げるときに必要そうならあらかじめ大きなスタックを確保して起動するという変更です。

# [cmd/compile: use jump table on ARM64 · golang/go@540f8c2](https://github.com/golang/go/commit/540f8c2b50f5def060244853673ccfc94d2d3e43)
ARM64 において、switch-caseでジャンプテーブルが使われるようになっています。
これによってパフォーマンス改善が行われています。
