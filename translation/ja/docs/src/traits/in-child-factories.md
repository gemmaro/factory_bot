# 子のファクトリの内部

子のファクトリの内部でトレイトから与えられる個々の属性を上塗りできます。

```ruby
factory :user do
  name { "Friendly User" }
  login { name }

  trait :active do
    name { "John Doe" }
    status { :active }
    login { "#{name} (M)" }
  end

  factory :brandon do
    active
    name { "Brandon" }
  end
end
```
