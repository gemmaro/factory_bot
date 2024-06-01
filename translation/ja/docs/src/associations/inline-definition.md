# 行内定義

通常の属性内に行内で関連を定義することもできます。
ただし`attributes_for`戦略を使うときは値が`nil`になることに注意してください。

```ruby
factory :post do
  # ...
  author { association :author }
end
```
