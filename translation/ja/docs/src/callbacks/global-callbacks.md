# 大域コールバック

全てのファクトリにコールバックを上塗りするには、`FactoryBot.define`ブロック内で定義します。

```ruby
FactoryBot.define do
  after(:build) { |object| puts "Built #{object}" }
  after(:create) { |object| AuditLog.create(attrs: object.attributes) }

  factory :user do
    name { "John Doe" }
  end
end
```
