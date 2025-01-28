# method_missing

`factory`定義ブロックでは、`add_attribute`や`association`や`sequence`や`trait`を使ってファクトリを定義できます。
また、既定の`method_missing`定義を活かした早道も使えます。

未知のメソッド（例えば`name`や`admin`や`email`や`account`）を呼ぶと、関連や系列やトレイトやファクトリの属性に繋がります。

1. method\_missingにブロックが渡されたとき、常に属性を定義します。
   これにより属性に値を設定できます。

1. method\_missingに実引数としてキー`:factory`を持つハッシュが渡されたとき、常に関連を定義します。
   これにより関連に使うファクトリを上塗りできます。

1. 同名の別のファクトリがあるとき、関連を定義します。

1. 同名の大域系列があると、属性が定義されます。
   系列から値が取り出されます。

1. ファクトリに同名のトレイトがあるとき、このファクトリの全ての構築に対してトレイトを変えます。

`method_missing`を使ってみましょう。
以下の明示的な定義があるとします。

```ruby
FactoryBot.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  factory :account
  factory :organization

  factory :user, traits: [:admin] do
    add_attribute(:name) { "Lord Nikon" }
    add_attribute(:email) { generate(:email) }
    association :account
    association :org, factory: :organization

    trait :admin do
      add_attribute(:admin) { true }
    end
  end
end
```

上記はもっと暗黙な定義にできます。

```ruby
FactoryBot.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  factory :account
  factory :organization

  factory :user do
    name { "Lord Nikon" }      # `add_attribute`なし
    admin                      # :traitsなし
    email                      # `add_attribute`なし
    account                    # `association`なし
    org factory: :organization # `association`なし

    trait :admin do
      admin { true }
    end
  end
end
```
