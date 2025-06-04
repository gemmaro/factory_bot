# 値の設定

コンソールで試行錯誤するとき、系列を特定の値に設定できると、大変便利です。
これは`FactoryBot.set_sequence`に[系列URI](sequence-uris.md)と新しい値を渡すと実現できます。

## 大域系列

大域系列は系列名と新しい値で設定されます。

```ruby
FactoryBot.define do
  sequence(:char, 'a') {|c| "global_character_#{c}" }

  factory :user do
    sequence(:name, %w[Jane Joe Josh Jayde John].to_enum)

    trait :with_email do
      sequence(:email) {|n| "user_#{n}@example.com" }
    end
  end
end

##
# 文字
generate(:char) # "global_character_a"
FactoryBot.set_sequence(:char, 'z')
generate(:char) # "global_character_z"

##
# 利用者名
generate(:user, :name) # "Jane"
FactoryBot.set_sequence(:user, :name, 'Jayde')
generate(:user, :name) # "Jayde"

##
# 利用者のEメール
generate(:user, :with_email, :email) # "user_1@example.com"
FactoryBot.set_sequence(:user, :with_email, :email, 1_234_567)
generate(:user, :with_email, :email) # "user_1234567@example.com"
```

<div class='warning'>

## 補足

- 新しい値は系列の要素の集合に合致しなければなりません。
  Integerベースの系列にStringを渡すことはできません！

- 整数ベースの系列、例えばレコードIDは、値として任意の正の整数を受け付けます。

- 取り得る要素が決まっている集まりの系列は、その中にある任意の値を取れます。

- 無制限の系列、例えば文字の`sequence(:unlimited,'a')`は、既定の最大の探索時間である3秒内に見つからなければ、時間切れになります。

- 時間制限を構成できます：`FactoryBot.sequence_setting_timeout = 1.5`

</div>
