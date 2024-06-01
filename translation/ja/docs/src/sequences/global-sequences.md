# 大域系列

特定の形式（例えばEメールアドレス）の一意な値は系列を使って生成できます。
系列は定義ブロックで`sequence`を読んで定義されます。
系列の値は`generate`を読んで生成されます。

```ruby
# 新しい系列を定義します。
FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

generate :email
# => "person1@example.com"

generate :email
# => "person2@example.com"
```
