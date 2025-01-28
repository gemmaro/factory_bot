# skip_createとto_create、そしてinitialize_with

`skip_create`メソッドと`to_create`メソッドと`initialize_with`メソッドは、factory\_botによる[構築戦略](build-strategies.html)とのやり取りの仕方を制御します。

これらのメソッドは`factory`定義ブロック内で呼べます。
作用はそのファクトリに留まります。
`FactoryBot.define`内にすると大域的な変更として作用します。

## initialize_with

`initialize_with`メソッドはブロックを取り、ファクトリのクラスのインスタンスを返します。
`attributes`メソッドを使うことができます。
このメソッドはオブジェクトの全てのフィールドと値からなるハッシュです。

既定の定義は以下です。

```ruby
initialize_with { new }
```

## to_create

`to_create`メソッドは`FactoryBot.create`戦略を制御します。
このメソッドは`initialize_with`で構築されたオブジェクトとfactory\_botの文脈を取るブロックを取ります。
文脈には[`transient`]ブロックからの追加のデータがあります。

[`transient`]: transient.html

既定の定義は以下です。

```ruby
to_create { |obj, context| obj.save! }
```

`skip_create`メソッドは`to_create`を何もしないように変える早道です。
これにより`create`戦略を`build`の同意語として使えます。
ただし`create`フックは追加で掛かっています。
