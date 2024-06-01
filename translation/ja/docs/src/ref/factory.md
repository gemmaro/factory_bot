# factory

`FactoryBot.define`ブロック内ではファクトリを定義できます。
`factory`を使って定義された全てのものは[構築戦略](build-strategies.html)を使って構築できます。

`factory`メソッドは3つの実引数を取ります。
必須である名前、省略できるオプションのハッシュと省略できるブロックです。

名前はSymbolであることが期待されます。

## オプション

- `:class`はクラスが構築するものです。
  クラスないしStringやSymbol（`#to_s`に応答する任意のもの）にできます。
  既定では親クラス名かファクトリ名の何れかです。
- `:parent`はこのファクトリが継承する別のファクトリ名です。
  既定では`nil`です。
- `:aliases`はこのファクトリの代わりの名前です。
  これらの名前は構築戦略で使えます。
  既定では空のリストです。
- `:traits`はこのファクトリを構築するときに既定で使われる基底のトレイトです。
  基底で空のリストです。

## ブロック

ブロックを使ってファクトリを定義できます。
この中では以下のメソッドが使えます。

- [`add_attribute`](add_attribute.md)
- [`association`](association.md)
- [`sequence`](sequence.md)
- [`trait`](trait.md)
- [`method_missing`](method_missing.md)
- [`transient`](transient.md)
- [`traits_for_enum`](traits_for_enum.md)
- [`initialize_with`](build-and-create.md#initialize_with)
- [`skip_create`](build-and-create.md)
- [`to_create`](build-and-create.md#to_create)
- [`before`](hooks.md#after-and-before-methods)
- [`after`](hooks.md#after-and-before-methods)
- [`callback`](hooks.md#callback)
- `factory`

`factory`内で`factory`を使うと、暗示した親を持つ新しいファクトリを定義できます。
