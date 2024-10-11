# 構築戦略

factory\_botは複数の異なる構築戦略に対応しています。
`build`、`create`、`attributes_for`、`build_stubbed`です。

```ruby
# 保存されないUserインスタンスを返します。
user = build(:user)

# 保存されたUserインスタンスを返します。
user = create(:user)

# 属性のハッシュを返します。例えばUserインスタンスを構築するのに使えます。
attrs = attributes_for(:user)

# Ruby 3.0のパターン合致代入の対応と統合します。
attributes_for(:user) => {email:, name:, **attrs}

# 全ての定義された属性をスタブ化したオブジェクトを返します。
stub = build_stubbed(:user)

# 上記のどのメソッドにも、ブロックを渡せば返却されたオブジェクトがもたらされます。
create(:user) do |user|
  user.posts.create(attributes_for(:post))
end
```

# build_stubbedとMarshal.dump

なお`build_stubbed`で作られたオブジェクトは`Marshal.dump`で直列化できません。
factory\_botはこれらのオブジェクトに特異メソッドを定義するからです。
