# 構築戦略

factory\_botのファクトリを定義したら、組み込みの構築戦略や独自の構築戦略を使って構築できます。

こうした戦略は全て、[ActiveSupport::Notifications]を使って`factory_bot.run_factory`計装に通知し、キー`:name`、`:strategy`、`:traits`、`:overrides`、`:factory`を持つペイロードを渡します。

[ActiveSupport::Notifications]: https://api.rubyonrails.org/classes/ActiveSupport/Notifications.html

リストではないメソッド（`.build`や`.build_pair`や`.create`など）は、必須の実引数であるファクトリ名を取ります。
また、省略できるトレイト名や、上塗りする属性のハッシュもあります。
最後にブロックを取れます。
このブロックは、生成されたオブジェクトを実引数とし、更新されたオブジェクトを返します。

リストのメソッド（`.build_list`や`.create_list`など）には2つの必須の実引数を持ちます。
ファクトリの名前と構築するインスタンスの数です。
また省略可能なトレイトと上塗りするものを取れます。
最後にブロックを取れます。
このブロックは生成されたオブジェクトとゼロ始まりの添字を実引数として取り、更新されたオブジェクトを返します。

## `build`

`FactoryBot.build`メソッドは`initialize_with`にしたがってクラスのインスタンスを構築します。
既定では`.new`クラスメソッドを呼びます。
`.build_list`は複数のインスタンスを構築し、`.build_pair`は2つのインスタンスを構築する早道です。

`initialize_with`を呼んだ後、`after_build`フックを呼びます。

関連は`build`構築戦略を使って構築されます。

## `create`

`FactoryBot.create`メソッドは`initialize_with`にしたがってクラスのインスタンスを構築し、`to_create`を使って永続化します。
`.create_list`クラスメソッドは複数のインスタンスを構築します。
また`.create_pair`は2つのインスタンスを構築する早道です。

`initialize_with`を呼んだ後、以下のフックを順番に呼びます。

1. `after_build`
1. `before_create`
1. フックではない`to_create`
1. `after_create`

関連は`create`構築戦略を使って構築されます。

`to_create`フックはオブジェクトの永続化方法を制御します。
オブジェクトとfactory\_botの文脈を持つブロックを取り、副作用を見越して走ります。
既定では`#save!`を呼びます。

## `attributes_for`

`FactoryBot.attributes_for`メソッドは、属性とその値を持つHashを、`initialize_with`を使って構築します。
`attributes_for_pair`メソッドと`attributes_for_list`メソッドは、`build_pair`と`build_list`と似た動作です。

関連は`null`構築戦略（構築されません）を使って構築されます。

フックは呼ばれません。

## `build_stubbed`

`FactoryBot.build_stubbed`メソッドは、偽のActiveRecordオブジェクトを返します。
`.build_stubbed_pair`メソッドと`.build_stubbed_list`メソッドは、`.build_pair`と`.build_list`と似た定義です。

`initialize_with`を使ってオブジェクトを構築します。
ただし、メソッドとデータを適切にスタブします。

- `id`は（属性で上塗りされない限り）連番で設定されます。
- `created_at`と`updated_at`は（属性で上塗りされない限り）現在時刻に設定されます。
- 全ての[ActiveModel::Dirty]の変更の記録が消去されます。
- `persisted?`は真です。
- `new_record?`は偽です。
- `destroyed?`は偽です。
- 永続化メソッド（`#connection`や`#delete`や`#save`や`#update`など）は`RuntimeError`を投げます。

[ActiveModel::Dirty]: https://api.rubyonrails.org/classes/ActiveModel/Dirty.html

オブジェクトを設定した後`after_stub`フックを呼びます。

## `null`

`FactoryBot.null`メソッドは`nil`を返します。
`.null_pair`メソッドはnilの対を与えます。
`.null_list`は欲しい数だけnilを与えます。
内部的に使われています。
