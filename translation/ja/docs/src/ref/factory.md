# ファクトリ

`FactoryBot.define`ブロック内ではファクトリを定義できます。
`factory`を使って定義された全てのものは[構築戦略](build-strategies.html)を使って構築できます。

`factory`メソッドは3つの実引数を取ります。
必須の名前、省略できるオプションのハッシュ、そして省略できるブロックです。

名前はSymbolにすることになっています。

## オプション

- `:class`は、構築するクラスです。
  クラスないしStringやSymbol（`#to_s`に応答する任意のもの）にできます。
  既定では親クラス名かファクトリ名の何れかです。
- `:parent`はこのファクトリが継承する別のファクトリ名です。
  既定では`nil`です。
- `:aliases`はこのファクトリの別名です。
  構築戦略で使えます。
  既定では空リストです。
- `:traits`はこのファクトリを構築するときに既定で使われる既定のトレイトです。
  既定で空リストです。

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
