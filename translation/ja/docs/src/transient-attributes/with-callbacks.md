# コールバック付き

factory\_botのコールバックで評価された定義自体を使う必要があるとき、（定義に）2つ目のブロック引数を宣言してそこから一過的属性を使う必要があります。
これは最終的な評価された値を表します。

```ruby
factory :user do
  transient do
    upcased { false }
  end

  name { "John Doe" }

  after(:create) do |user, context|
    user.name.upcase! if context.upcased
  end
end

create(:user).name
#=> "John Doe"

create(:user, upcased: true).name
#=> "JOHN DOE"
```
