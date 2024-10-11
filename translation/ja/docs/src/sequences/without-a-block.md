# ブロック無し

ブロック無しでは値はそれ自身を漸増させ、初期値から始めていきます。

```ruby
factory :post do
  sequence(:position)
end
```

なお系列用の値は、`#next`に応答する限り、任意のEnumerableインスタンスにできます。

```ruby
factory :task do
  sequence :priority, %i[low medium high urgent].cycle
end
```
