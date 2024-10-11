# 関連付き

トレイトは関連とも簡単に使えます。

```ruby
factory :user do
  name { "Friendly User" }

  trait :admin do
    admin { true }
  end
end

factory :post do
  association :user, :admin, name: 'John Doe'
end

# 名前が「John Doe」の管理者の利用者を作ります。
create(:post).user
```

ファクトリと異なる関連名を使うときは次のようにします。

```ruby
factory :user do
  name { "Friendly User" }

  trait :admin do
    admin { true }
  end
end

factory :post do
  association :author, :admin, factory: :user, name: 'John Doe'
  # もしくは以下です。
  association :author, factory: [:user, :admin], name: 'John Doe'
end

# 名前が「John Doe」の管理者の利用者を作ります。
create(:post).author
```
