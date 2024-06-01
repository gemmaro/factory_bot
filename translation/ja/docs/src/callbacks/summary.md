# コールバック

factory\_botは4つのコールバックを作れます。

* after(:build) はファクトリが構築された後に（`FactoryBot.build`と`FactoryBot.create`を介して）呼ばれます。
* before(:create) はファクトリが保存される前に（`FactoryBot.create`を介して）呼ばれます。
* after(:create) はファクトリが保存された後に（`FactoryBot.create`を介して）呼ばれます。
* after(:stub) はファクトリがスタブ化された後に（`FactoryBot.build_stubbed`を介して）呼ばれます。

例は以下です。

```ruby
# 利用者ファクトリが構築された後にgenerate_hashed_passwordメソッドを呼ぶファクトリを定義します。
factory :user do
  after(:build) { |user, context| generate_hashed_password(user) }
end
```

なお、ブロックのオブジェクトのインスタンスが得られます。
