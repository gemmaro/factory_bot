# オブジェクトを永続化するための独自メソッド

既定で、レコードを作成するとインスタンスに`save!`を呼びます。
これは常に最適ではないことがあるため、ファクトリに`to_create`を定義して挙動を上塗りできます。

```ruby
factory :different_orm_model do
  to_create { |instance| instance.persist! }
end
```

作成で永続化のメソッドも一緒に無効化するには、ファクトリで`skip_create`することができます。

```ruby
factory :user_without_database do
  skip_create
end
```

全てのファクトリで`to_create`を上塗りするには`FactoryBot.define`ブロック内で定義します。

```ruby
FactoryBot.define do
  to_create { |instance| instance.persist! }


  factory :user do
    name { "John Doe" }
  end
end
```
