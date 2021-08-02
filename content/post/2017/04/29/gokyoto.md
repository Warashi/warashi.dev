---
categories: []
date: "2017-04-29T20:15:58+09:00"
tags:
- Go
- 勉強会
title: 「そうだ Go、京都。」参加報告
---

本日、はてなさんで開かれた Go の勉強会に参加してきましたので、備忘録も兼ねて内容をメモしておこうと思います。

## LTじゃないやつ

### String::Random の Go 版を作った話 (by [tさん](//twitter.com/t_snzk))
[ご本人の解説記事](//blog.yux3.net/entry/2017/05/01/014200)

[String::Random](//metacpan.org/pod/String::Random) という Perl のモジュールがあって、それを Go に移植したという話でした。
実装はこちら ([gocha](//github.com/t-mrt/gocha))

1. String::Random は正規表現に従ってランダムな文字列を生成するモジュールで、それをGoに移植するに当たってはじめは正規表現のパーサなどを実装していた。
2. とりあえずの実装はできたが、Unicode文字プロパティなどの対応が大変。さてどうするか。
3. **Goの標準ライブラリにはGoで書かれた正規表現エンジンがある。**
4. Goの`regexp`パッケージはVMなので、それを利用して文字列生成をする。
5. Unicode文字プロパティもiオプションも対応できた！

### 毎日 Go を書く (by [yuukiさん](//twitter.com/y_uuk1))
githubの草を生やす活動を始めたので、それについての話とのこと

#### 大事なこと
- 1 commit / 1 day でもいいので毎日書くことが大事。継続は力なり。
- モチベーションが大事なので、それが維持されるなら `git commit --date` もあり。ただしやり過ぎ厳禁。
- 平日にはあまり時間がとれないので、土日に細かいIssueを用意しておいて平日に消化
- 一つのプロジェクトだと行き詰まったときに継続できなくなるので複数のプロジェクトを持つ
- 作るもののネタを見つけるのが大変
  - 業務で課題を見つけてそれを汎用化して解くなど

#### 利点
- 脳内メモリに乗った状態が保持されるので、次に書くときに悩まない
- 小さな変更を積み重ねる癖がつく
- 無理すると続かないので無理しなくなる

### REST is not only (web) API interface (by [kadotaさん](//twitter.com/plan9user))
[資料](//speakerdeck.com/lufia/rest-is-not-only-web-api-interface)

プッシュ配信システムで REST API は辛いよ、とのこと

どう辛いかというと、シンプルに 1 request / 1 message / 1 user とすると、大量の request が発生する。
他のもの、たとえば gRPC, QraphQL などを使うことも検討に入れましょう。

### Go で軽量マークアップ言語のパーサを書く (by [aerealさん](//twitter.com/aereal))
[参考文献](//b.hatena.ne.jp/aereal/2017gokyoto/)

Go ではてな記法のパーサを書いたという話でした。
実装はこちら ([go-text-hatena](//github.com/aereal/go-text-hatena))

はてな記法にははっきりとした定義がなく、実装が定義。
数えられるだけでも7つの実装がある。辛い。

実装には、goyacc および `text/scanner` パッケージを用いている。
インデントでネストを表現する場合はyaccでは辛いが、はてな記法はマーカ (+記号など) を重複させてネストを表現するという記法であり、それに助けられた。
標準入力から受け取って、ASTをJSON形式で標準出力にはき出すのでツールから使いやすい。

---

## LT
LTはメモ取ってなかったので完全に資料頼りの感想です。

### encoding/csv (by [pinzoloさん](//twitter.com/pinzolo))
[資料](//speakerdeck.com/pinzolo/csv)

`csv.Reader`, `csv.Writer` が `io.Reader`, `io.Writer` ではないのは知ってたんですが、改めて言われると不思議な感じですね。
csvっぽい形式を読み込んだりすることはあったんですが、 encoding/csv は発表であったとおり融通がきかなくて使ってませんでした。
というか、ちゃんとしたcsvじゃなくてそれっぽい形式を扱ってただけだったのが大きい。
また使ってみようと思います。

### Server Push Middleware "Plasma" (by [stormcat24さん](//twitter.com/stormcat24))
[資料](//speakerdeck.com/stormcat24/server-push-middleware-plasma)

東京から来ててすごいなって思ったら天皇賞のついでらしかった。
ポーリング撲滅のためにミドルウェアを作ったって話でした。
作ったとはいうものの、実装は[インターン生](//twitter.com/upamune)がほぼ一人でやったとのこと。すごい。
インターン生の書いたブログ記事は[これ](//upamune.hatenablog.com/entry/2017/04/07/165658)っぽい。

### パッケージの公開方法 (by [kwmt27さん](//twitter.com/kwmt27))
[資料](//go-talks.appspot.com/github.com/kwmt/go-talks/2017/souda-kyoto-go.slide)

なんと14:30ごろに参加申し込みしてLTなされている。すごい。
パッケージの公開方法についての話でした。

### そうだ Go、再確認。 (by [qt_luigiさん](//twitter.com/qt_luigi))
[資料](//speakerdeck.com/qt_luigi/souda-go-zai-que-ren)

Go の基礎的な事柄に対するお話でした。
再確認できてよかったです。

### Go 合宿 (by [maro_ktさん](//twitter.com/maro_kt))
[Go合宿](//go-beginners.connpass.com/event/47481/)の参加報告でした。
土善旅館はいいぞ。
