# ファクトリ名と属性

各ファクトリには名前と属性の一式があります。
名前は既定でオブジェクトのクラスを推測するために使われます。

```ruby
# 以下はUserクラスを推測します。
FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    admin { false }
  end
end
```
