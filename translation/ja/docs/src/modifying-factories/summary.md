# ファクトリの変更

ファクトリ一式が与えられているものの（gemの開発者からとしましょう）、アプリケーションにもっと合うように代えたいとき、子ファクトリを作ってそこに属性を加える代わりに、ファクトリを変更できます。

gemが以下のようにUserファクトリを与えているとします。

```ruby
FactoryBot.define do
  factory :user do
    full_name { "John Doe" }
    sequence(:username) { |n| "user#{n}" }
    password { "password" }
  end
end
```

追加の属性を加える子ファクトリを作るとすると以下になります。

```ruby
FactoryBot.define do
  factory :application_user, parent: :user do
    full_name { "Jane Doe" }
    date_of_birth { 21.years.ago }
    health { 90 }
  end
end
```

その代わりとしてファクトリを変更できます。

```ruby
FactoryBot.modify do
  factory :user do
    full_name { "Jane Doe" }
    date_of_birth { 21.years.ago }
    health { 90 }
  end
end
```

ファクトリを変更するとき、どんな属性も（コールバックを除いて）お好みで代えられます。

`FactoryBot.modify`は`FactoryBot.define`の外側で呼ばなければなりません。
ファクトリを違った風に操作するからです。

注意点：ファクトリのみ変更でき（系列やトレイトはできません）、コールバックは*通常のものと同様に付属したまま*です。
そのため変更しているファクトリが`after(:create)`コールバックを定義するとき、`after(:create)`を定義しても上塗りされず、その代わりに最初のコールバックの後に走ります。
