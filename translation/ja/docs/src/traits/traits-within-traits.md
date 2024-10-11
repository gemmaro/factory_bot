# トレイト内トレイト

トレイトは他のトレイト内で使い、属性を混ぜることができます。

```ruby
factory :order do
  trait :completed do
    completed_at { 3.days.ago }
  end

  trait :refunded do
    completed
    refunded_at { 1.day.ago }
  end
end
```
