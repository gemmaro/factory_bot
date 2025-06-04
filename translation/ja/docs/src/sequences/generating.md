# 系列の生成

直接系列を生成できるようにし、ただしオブジェクトを構築せずにおくと、テストが本当に高速になることがあります。
これは単一の値の`:generate`に[系列URI](sequence-uris.md)を渡したり、系列の値の配列に`:generate_list`を渡したりして実現できます。

```ruby
FactoryBot.define do
  sequence(:char, 'a') {|c| "global_character_#{c}" }

  factory :user do
    sequence(:name, %w[Jane Joe Josh Jayde John].to_enum)

    trait :with_age do
      sequence(:age, 21)
    end
  end
end

##
# 文字
generate(:char) # "global_character_a"
generate_list(:char, 2) # ["global_character_b", "global_character_c"]
generate(:char) # "global_character_d"

##
# 利用者名
generate(:user, :name) # "Jane"
generate_list(:user, :name, 3) # ['Joe', 'Josh', 'Jayde']
generate(:user, :name) # "John"

##
# 利用者の年齢
generate(:user, :with_age, :age) # 21
generate_list(:user, :with_age, :age, 5) # [22, 23, 24, 25, 26]
generate(:user, :with_age, :age) # 27
```

## スコープ

系列のブロックからスコープ内の属性を参照することもあるでしょう。
この場合、スコープを与えなければなりません。
そうしなければ例外が投げられます。

```ruby
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{name}-#{n}@example.com" }
  end
end

generate(:user, :email)
# ArgumentError, Sequence user:email failed to return a value. Perhaps it needs a scope to operate? (scope: <object>)

jester = build(:user, name: "Jester")
jester.email # "Jester-1@example.com"

generate(:user, :email, scope: jester)
# "Jester-2@example.com"

generate_list(:user, :email, 2, scope: jester)
# ["Jester-3@example.com", "Jester-4@example.com"]
```

テストのとき、スコープは参照されている属性に応答する任意のオブジェクトにできます。

```ruby
require 'ostruct'

FactoryBot.define
  factory :user do
    sequence(:info) { |n| "#{name}-#{n}-#{age + n}" }
  end
end

test_scope = OpenStruct.new(name: "Jester", age: 23)

generate_list('user/info', 3, scope: test_scope)
# ["Jester-1-24", "Jester-2-25", "Jester-3-26"]
```
