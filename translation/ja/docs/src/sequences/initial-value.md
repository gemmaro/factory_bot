# 初期値

初期値を上塗りできます。
`#next`メソッドに応答する任意の値で動作します（例えば1、2、3、「a」、「b」、「c」）。

```ruby
factory :user do
  sequence(:email, 1000) { |n| "person#{n}@example.com" }
end
```

初期値は値としてProcを渡して遅延設定することもできます。
このProcは`sequence.next`が最初に呼ばれたときに呼ばれます。

```ruby
factory :user do
  sequence(:email, proc { Person.count + 1 }) { |n| "person#{n}@example.com" }
end
```
