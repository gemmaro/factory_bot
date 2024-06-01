# 明示定義

関連を明示的に定義できます。
[属性を上塗りする](overriding-attributes.md)ときに特にしっくりくることがあります。

```ruby
factory :post do
  # ...
  association :author
end
```
