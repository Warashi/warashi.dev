---
title: "Go Commits in this Week at 2022-04-30"
date: 2022-04-30T11:43:23+09:00
tags: [Go]
draft: false
---
<https://github.com/golang/go> に今週あったコミットのうち、僕の目にとまったもをの書いていきます。

# [slices: use !{{Less}} instead of {{GreaterOrEqual}}](https://github.com/golang/go/commit/415e3fd8a6e62d7e9cf7d0c995518179dc0b7723)
sortで `a` と `b` を比較する際に `a >= b` を使うか `!(a < b)` を使うかによって結果が変わってしまうから元に戻すよ、ということのようです。
この2つは一見同じように見えるのですが、浮動小数点数で `NaN` が混じっているときに同じ結果ではなくなります。
```go
package main

import (
	"fmt"
	"math"

	"golang.org/x/exp/constraints"
)

func compare[T constraints.Ordered](a, b T) bool {
	return !(a < b) == (a >= b)
}

func main() {
	fmt.Println("1 and 2:", compare(1, 2))
	fmt.Println("Inf and 0:", compare(math.Inf(1), 0))
	fmt.Println("Inf and Inf:", compare(math.Inf(1), math.Inf(1)))
	fmt.Println("NaN and 1:", compare(math.NaN(), 1))
	fmt.Println("NaN and NaN:", compare(math.NaN(), math.NaN()))
}
```
Playground: <https://go.dev/play/p/iAMjcAgU8pz>

# [time: document hhmmss formats](https://github.com/golang/go/commit/24b570354caee33d4fb3934ce7ef1cc97fb403fd)
`(time.Time).Format` のフォーマット指定文字列、時差の部分について、もともと秒単位まで指定が可能だったにもかかわらずドキュメントに示されていなかったようです。
とはいえ秒単位で時差のある地域はないはずなので、これを使う機会はくるのか…… 🤔 という感じではありますが。

# [crypto/tls: remove tls10default GODEBUG flag](https://github.com/golang/go/commit/f0ee7fda636408b4f04ca3f3b11788f662c90610)
`GODEBUG` 環境変数で TLS 1.0 を有効にする指定があったのですが、それが無効になったようです。
コード中でconfigから有効にする手段はのこっていますが、TLS 1.0は今となっては古くて脆弱……？ですし1.0を使うのはもうやめにしたいですね。

# [os/exec: return error when PATH lookup would use current directory](https://github.com/golang/go/commit/3ce203db80cd1f320f0c597123b918c3b3bb0449)
`golang.org/x/sys/execabs` と同様に、os/execで実行しようとしたコマンドがカレントディレクトリの実行ファイルだった場合にエラーを返すようになったようです。
もともとWindowsでのみの挙動（のはず）ですが、それがUnix環境と同様になった感じですかね。
おそらく、こちらでGit LFSの脆弱性としてあげられていたことに対する対処だと思われます。
ref; [「Git for Windows」v2.36.0が公開 ～「Git LFS」の脆弱性に対処](https://forest.watch.impress.co.jp/docs/news/1404405.html)

## [Revert "os/exec: return error when PATH lookup would use current directory"](https://github.com/golang/go/commit/f2b674756b3b684118e4245627d4ed8c07e518e7)
と思ったらrevertされてました。どうも `x/sys/execabs` のテストを壊してしまったようです。
