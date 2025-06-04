# 巻き戻し

系列は初めの値に巻き戻すこともできます。

## 全ての系列

`FactoryBot.rewind_sequences`とすると、大域でファクトリである全ての系列が巻き戻ります。

```ruby
FactoryBot.define do
  sequence(:email) {|n| "person#{n}@example.com" }

  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
  end
end

generate(:email) # "person1@example.com"
generate(:email) # "person2@example.com"
generate(:email) # "person3@example.com"

generate(:user, :email) # "user1@example.com"
generate(:user, :email) # "user2@example.com"
generate(:user, :email) # "user3@example.com"

FactoryBot.rewind_sequences

generate(:email)        # "person1@example.com"
generate(:user, :email) # "user1@example.com"
```

## 個々の系列

`FactoryBot.rewind_sequences`に[系列URI](sequence-uris.md)を渡すと、個々の系列を巻き戻せます。

```ruby
FactoryBot.define do
  sequence(:email) {|n| "global_email_#{n}@example.com" }

  factory :user do
    sequence(:email) {|n| "user_email_#{n}@example.com" }
  end
end

FactoryBot.rewind_sequence(:email)
generate(:email)
#=> "global_email_1@example.com"

factoryBot.rewind_sequence(:user, :email)
generate(:user, :email)
#=> "user_email_1@example.com"
```
