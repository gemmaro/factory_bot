# 行内系列

また特定のファクトリでのみ使われる行内系列を定義することもできます。

```ruby
factory :user do
  sequence(:email) { |n| "person#{n}@example.com" }
end
```

Ruby 2.7の[連番仮引数][numbered parameters]の対応を使うと、行内定義はさらに縮められます。

```ruby
factory :user do
  sequence(:email) { "person#{_1}@example.com" }
end
```

[numbered parameters]: https://ruby-doc.org/core-2.7.1/Proc.html#class-Proc-label-Numbered+parameters
