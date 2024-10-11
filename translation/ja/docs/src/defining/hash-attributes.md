# ハッシュ属性

Rubyのブロック構文があるため、（例えば直列化された列やJSONの列用に）属性を`Hash`として定義するには、2対の波括弧が必要です。

```ruby
factory :program do
  configuration { { auto_resolve: false, auto_define: true } }
end
```

代えてお好みで`do`と`end`の構文にすることもできます。

```ruby
factory :program do
  configuration do
    { auto_resolve: false, auto_define: true }
  end
end
```

---

しかし値をハッシュとして定義するとオブジェクトを構築するときにハッシュ内に値を設定するのが複雑になります。
その代わりにfactory\_bot自体を使うようにしてください。

```ruby
factory :program do
  configuration { attributes_for(:configuration) }
end

factory :configuration do
  auto_resolve { false }
  auto_define { true }
end
```

この方法ではより簡単に構築の際に値を設定できます。

```ruby
create(
  :program,
  configuration: attributes_for(
    :configuration,
    auto_resolve: true,
  )
)
```
