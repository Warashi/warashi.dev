+++
title = "Go Commits in This Week at 2022-05-21"
author = ["warashi"]
date = 2022-05-23T07:29:53+09:00
tags = ["Go"]
draft = false
type = "post"
+++

## [time: add Time.ZoneBounds ? golang/go@41b9d8c](https://github.com/golang/go/commit/41b9d8c75e45636a153c2a31d117196a22a7fc6c) {#time-add-time-dot-zonebounds-golang-go-41b9d8c}

`time.ZoneBounds` という関数が追加されるようです。
テストコードも見たんですが、何をするための関数なのかよくわかりませんでした…。


## [net/http: allow sending 1xx responses ? golang/go@770e0e5](https://github.com/golang/go/commit/770e0e584a98dfd5e8d0d00558085c339fda0ed7) {#net-http-allow-sending-1xx-responses-golang-go-770e0e5}

net/http で 1xx 系のレスポンスを返せるようにする変更です。
今までは返せなかったことにちょっと驚きました。


## [fmt: add Append, Appendln, Appendf ? golang/go@668041e](https://github.com/golang/go/commit/668041ef66ddafffccf1863e6180b83ea1ad30c9) {#fmt-add-append-appendln-appendf-golang-go-668041e}

`fmt` package に関数が追加されたようです。
いままで `strings.Builder` や `bytes.Buffer` を `io.Writer` にして、 `fmt.Fprint` 系の関数でやっていたことを `[]byte` に対して直接行えるようにする変更のように見えますね。
