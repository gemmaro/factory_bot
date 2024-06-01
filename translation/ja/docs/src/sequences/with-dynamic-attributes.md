# 動的属性付き

系列は動的属性で使えます。

```ruby
FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

factory :invite do
  invitee { generate(:email) }
end
```
