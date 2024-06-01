# 属性の上塗り

関連で属性の上塗りもできます。

暗黙には以下とします。

```ruby
factory :post do
  # ...
  author factory: :author, last_name: "Writely"
end
```

明示的には以下とします。


```ruby
factory :post do
  # ...
  association :author, last_name: "Writely"
end
```

もしくはファクトリの属性を使って行内でもできます。

```rb
factory :post do
  # ...
  author_last_name { "Writely" }
  author { association :author, last_name: author_last_name }
end
```
