# 入れ子のファクトリ

入れ子のファクトリでは、共通する属性を繰り返すことなく、同じクラスに対して複数のファクトリを作れます。

```ruby
factory :post do
  title { "A title" }

  factory :approved_post do
    approved { true }
  end
end

approved_post = create(:approved_post)
approved_post.title    # => "A title"
approved_post.approved # => true
```
