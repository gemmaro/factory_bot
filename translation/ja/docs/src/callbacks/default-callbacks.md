# 既定コールバック

factory\_botでは、コードを挿入する上で、4つコールバックが使えます。

* after(:build) はファクトリが構築された後に（`FactoryBot.build`と`FactoryBot.create`を介して）呼ばれます。
* before(:create) はファクトリが保存される前に（`FactoryBot.create`を介して）呼ばれます。
* after(:create) はファクトリが保存された後に（`FactoryBot.create`を介して）呼ばれます。
* after(:stub) はファクトリがスタブ化された後に（`FactoryBot.build_stubbed`を介して）呼ばれます。

例は以下です。

```ruby
# 構築後にgenerate_hashed_passwordメソッドを呼ぶファクトリを定義
factory :user do
  after(:build) { |user| generate_hashed_password(user) }
end
```

なお、ブロックにはオブジェクトのインスタンスがあります。
こうなっていることで便利なときがあります。
