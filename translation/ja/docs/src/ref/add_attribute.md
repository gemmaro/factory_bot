# add_attribute

ファクトリの定義の中では、`add_attribute`メソッドで、オブジェクトが構築されるときに設定されるキーバリュー対を定義できます。

`add_attribute`メソッドは、名前（SymbolまたはString）とブロックの2つの実引数を取ります。
ブロックはこのオブジェクトが構築される度に呼ばれます。
ブロックは属性が構築戦略で上塗りされるときは呼ばれません。

代入ではRubyの属性セッターを呼びます。
例えば以下があるとします。

```ruby
FactoryBot.define do
  factory :user do
    add_attribute(:name) { "Acid Burn" }
  end
end
```

このとき`#name=`セッターが使われます。

```ruby
user = User.new
user.name = "Acid Burn"
```

早道については[method_missing](method_missing.html)も参照してください。
