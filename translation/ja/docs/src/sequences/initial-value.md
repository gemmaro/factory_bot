# 初期値

初期値を上塗りできます。
`#next`メソッドに応答する任意の値で動作します（例えば1、2、3、「a」、「b」、「c」）。

```ruby
factory :user do
  sequence(:email, 1000) { |n| "person#{n}@example.com" }
end
```
