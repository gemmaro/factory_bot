# 属性の優先度

同じ属性を定義するトレイトはAttributeDefinitionErrorsを投げません。
最後に属性を定義したトレイトが優先されます。

```ruby
factory :user do
  name { "Friendly User" }
  login { name }

  trait :active do
    name { "John Doe" }
    status { :active }
    login { "#{name} (active)" }
  end

  trait :inactive do
    name { "Jane Doe" }
    status { :inactive }
    login { "#{name} (inactive)" }
  end

  trait :admin do
    admin { true }
    login { "admin-#{name}" }
  end

  factory :active_admin,   traits: [:active, :admin]   # loginは「admin-John Doe」になります。
  factory :inactive_admin, traits: [:admin, :inactive] # loginは「Jane Doe (inactive)」になります。
end
```
