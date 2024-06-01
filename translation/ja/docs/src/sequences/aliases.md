# 別称

系列には別称も付けられます。
系列の別称は同じ計数を共有します。

```ruby
factory :user do
  sequence(:email, 1000, aliases: [:sender, :receiver]) { |n| "person#{n}@example.com" }
end

# :emailの計数を漸増させます。:senderと:receiverと共有しています。
generate(:sender)
```

別称を定義して計数に既定値 (1) を使うには以下とします。

```ruby
factory :user do
  sequence(:email, aliases: [:sender, :receiver]) { |n| "person#{n}@example.com" }
end
```

値を設定するには以下です。

```ruby
factory :user do
  sequence(:email, 'a', aliases: [:sender, :receiver]) { |n| "person#{n}@example.com" }
end
```

値には`#next`メソッドへの対応が必要です。
ここでの次の値は「a」で、次に「b」、などとなります。
