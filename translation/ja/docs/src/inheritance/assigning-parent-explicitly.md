# 親を明示的に代入

親を明示的に代入することもできます。

```ruby
factory :post do
  title { "A title" }
end

factory :approved_post, parent: :post do
  approved { true }
end
```
