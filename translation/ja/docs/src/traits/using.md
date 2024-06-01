# トレイトを使う

factory\_botでインスタンスを構築するとき、トレイトにはSymbolのリストも渡せます。

```ruby
factory :user do
  name { "Friendly User" }

  trait :active do
    name { "John Doe" }
    status { :active }
  end

  trait :admin do
    admin { true }
  end
end

# :active状態で名前が「Jon Snow」の管理者の利用者を作ります。
create(:user, :admin, :active, name: "Jon Snow")
```

この機能は`build`、`build_stubbed`、`attributes_for`、`create`で動きます。

`create_list`メソッドと`build_list`メソッドも対応しています。
2つ目の仮引数に作成・構築するインスタンス数を渡すことをご留意ください。
このファイルの「複数レコードの構築と作成」でドキュメントに書かれている通りです。

```ruby
factory :user do
  name { "Friendly User" }

  trait :admin do
    admin { true }
  end
end

# :active状態を持つ名前が「Jon Snow」の管理者の利用者を3人作ります。
create_list(:user, 3, :admin, :active, name: "Jon Snow")
```
