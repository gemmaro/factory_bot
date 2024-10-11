# 巻き戻し

系列は`FactoryBot.rewind_sequences`で巻き戻すこともできます。

```ruby
sequence(:email) {|n| "person#{n}@example.com" }

generate(:email) # "person1@example.com"
generate(:email) # "person2@example.com"
generate(:email) # "person3@example.com"

FactoryBot.rewind_sequences

generate(:email) # "person1@example.com"
```

こうすると全ての登録された系列が巻き戻ります。
