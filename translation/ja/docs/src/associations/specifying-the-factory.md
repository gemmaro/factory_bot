# ファクトリの指定

異なるファクトリを指定することもできます（[別称](../aliases/summary.md)も役立つかもしれませんが）。

暗黙には以下とします。

```ruby
factory :post do
  # ...
  author factory: :user
end
```

明示的には以下とします。

```ruby
factory :post do
  # ...
  association :author, factory: :user
end
```

行内では以下とします。

```ruby
factory :post do
  # ...
  author { association :user }
end
```
