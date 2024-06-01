# ミックスインとして

トレイトはファクトリの外側で定義し、共有する属性を組み合わせるためにミックスインとして使えます。

```ruby
FactoryBot.define do
  trait :timestamps do
    created_at { 8.days.ago }
    updated_at { 4.days.ago }
  end
  
  factory :user, traits: [:timestamps] do
    username { "john_doe" }
  end
  
  factory :post do
    timestamps
    title { "Traits rock" }
  end
end
```
