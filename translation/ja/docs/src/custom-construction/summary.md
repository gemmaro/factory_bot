# 独自の構築

factory\_botを使って、`initialize`に渡される属性があるオブジェクトを構築したいときや、クラスを構築する上で単に`new`を呼ぶ以上のことをしたいときは、ファクトリに`initialize_with`を定義して既定の挙動を上塗りできます。
例えば以下です。

```ruby
# user.rb
class User
  attr_accessor :name, :email

  def initialize(name)
    @name = name
  end
end

# factories.rb
sequence(:email) { |n| "person#{n}@example.com" }

factory :user do
  name { "Jane Doe" }
  email

  initialize_with { new(name) }
end

build(:user).name # Jane Doe
```

factory\_botはActiveRecordで飛び抜けて上手く書けるようになっていますが、どんなRubyクラスでも動作できます。
ActiveRecordと最大限の互換性があるよう、既定の初期化器はクラスを構築するのに実引数なしで`new`を読んで全てのインスタンスを構築します。
それから属性の書込みメソッドを呼んで全ての属性値を代入します。
ActiveRecordでは上手く動きますが、他のRubyのクラスのほとんどは実際にはうまくいきません。

以下の目的で初期化器を上塗りできます。

* `initialize`に実引数が必須の非ActiveRecordオブジェクトを構築する。
* `new`ではないメソッドを使ってインスタンスをインスタンス化する。
* 構築された後にインスタンスを修飾するような雑なことをする。

`initialize_with`を使うとき、`new`を呼ぶときにクラス自体を宣言する必要はありません。
しかし呼びたいその他のクラスメソッドは明示的にクラスに対して呼ばなければなりません。

例は以下です。

```ruby
factory :user do
  name { "John Doe" }

  initialize_with { User.build_with_name(name) }
end
```

`attributes`を呼んで`initialize_with`ブロック内で全ての公の属性を使うこともできます。

```ruby
factory :user do
  transient do
    comments_count { 5 }
  end

  name "John Doe"

  initialize_with { new(**attributes) }
end
```

こうすると`new`に渡される全ての属性のハッシュを構築します。
一過的属性は含まれませんが、ファクトリで定義されたその他全て（関連、評価された系列など）が渡されます。

`FactoryBot.define`ブロック内に含めると全てのファクトリに`initialize_with`を定義できます。

```ruby
FactoryBot.define do
  initialize_with { new("Awesome first argument") }
end
```

`initialize_with`を使うとき、`initialize_with`ブロック内で使う属性は構築子で*のみ*代入されます。
これは以下のコードと大まかに同じです。

```ruby
FactoryBot.define do
  factory :user do
    initialize_with { new(name) }

    name { 'value' }
  end
end

build(:user)
# ……とすると以下が実行されます。
User.new('value')
```

これは重複する代入を防止しています。
4.0より前のfactory\_botでは以下が走っていました。

```ruby
FactoryBot.define do
  factory :user do
    initialize_with { new(name) }

    name { 'value' }
  end
end

build(:user)
# ……とすると以下が実行されます。
user = User.new('value')
user.name = 'value'
```
