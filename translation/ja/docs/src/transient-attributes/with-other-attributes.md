# 他の属性付き

他の属性から一過的属性を使えます（[依存属性](../dependent-attributes/summary.md)を参照）。

```ruby
factory :user do
  transient do
    rockstar { true }
  end

  name { "John Doe#{" - Rockstar" if rockstar}" }
end

create(:user).name
#=> "John Doe - ROCKSTAR"

create(:user, rockstar: false).name
#=> "John Doe"
```
