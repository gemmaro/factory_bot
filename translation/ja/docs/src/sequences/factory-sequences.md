# ファクトリ系列

また、特定のファクトリでのみ使われる系列を定義することもできます。

```ruby
factory :user do
  sequence(:email) { |n| "person#{n}@example.com" }
end
```

Ruby 2.7の[連番仮引数][numbered parameters]により、行内定義はもっと更に短く書けます。

```ruby
factory :user do
  sequence(:email) { "person#{_1}@example.com" }
end
```

[numbered parameters]: https://ruby-doc.org/core-2.7.1/Proc.html#class-Proc-label-Numbered+parameters
