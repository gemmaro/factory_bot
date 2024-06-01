# add_attribute

ファクトリの定義の中では、`add_attribute`メソッドでオブジェクトが構築されるときに設定されるキーバリュー対を定義します。

`add_attribute`メソッドは、名前（SymbolまたはString）とブロックの2つの実引数を取ります。
ブロックはこのオブジェクトが構築される度に呼ばれます。
ブロックは属性が構築戦略で上塗りされるときは呼ばれません。

代入はRubyの属性セッターを呼んで行われます。
例えば以下があるとします。

```ruby
FactoryBot.define do
  factory :user do
    add_attribute(:name) { "Acid Burn" }
  end
end
```

これは`#name=`セッターを使います。

```ruby
user = User.new
user.name = "Acid Burn"
```

早道については[method_missing](method_missing.html)も参照してください。
