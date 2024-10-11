# 複数コールバック

同じファクトリに複数の種類のコールバックを定義することもできます。

```ruby
factory :user do
  after(:build)  { |user| do_something_to(user) }
  after(:create) { |user| do_something_else_to(user) }
end
```

ファクトリは同じ種類のコールバックをいくらでも定義することもできます。
こうしたコールバックは指定された順番に実行されます。

```ruby
factory :user do
  after(:create) { this_runs_first }
  after(:create) { then_this }
end
```

`create`を呼ぶと`after_build`コールバックと`after_create`コールバックの両方ともが呼ばれます。

また標準的な属性と同様に、子のファクトリは親ファクトリからコールバックを受け継ぎます（また定義もできます）。

複数のコールバックはブロックを走らせて代入できます。
（全ての戦略を通じて共有されるコールバックはないため）同じコードを様々な戦略で構築するときに有用です。

```ruby
factory :user do
  callback(:after_stub, :before_create) { do_something }
  after(:stub, :create) { do_something_else }
  before(:create, :custom) { do_a_third_thing }
end
```
