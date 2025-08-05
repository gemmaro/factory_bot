# 既定コールバック

factory\_botでは、コードを挿入する上で、4つコールバックが使えます。

* before(:all) はどの戦略が使われたときも、その前に呼ばれます（例：`FactoryBot.build`, `FactoryBot.create`, `FactoryBot.build_stubbed`）
* before(:build) ファクトリが（`FactoryBot.build`や`FactoryBot.create`で）構築される前に呼ばれます
* after(:build) はファクトリが構築された後に（`FactoryBot.build`と`FactoryBot.create`を介して）呼ばれます。
* before(:create) はファクトリが保存される前に（`FactoryBot.create`を介して）呼ばれます。
* after(:create) はファクトリが保存された後に（`FactoryBot.create`を介して）呼ばれます。
* after(:stub) はファクトリがスタブ化された後に（`FactoryBot.build_stubbed`を介して）呼ばれます。
* after(:all) どの戦略が使われたときも、その後に呼ばれます（例：`FactoryBot.build`, `FactoryBot.create`, `FactoryBot.build_stubbed`）

例は以下です。

```ruby
# 構築後にgenerate_hashed_passwordメソッドを呼ぶファクトリを定義
factory :user do
  after(:build) { |user| generate_hashed_password(user) }
end
```

なお、ブロックにはオブジェクトのインスタンスがあります。
こうなっていることで便利なときがあります。
