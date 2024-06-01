# 別称

factory\_botでは既存のファクトリに別称を定義して簡単に再利用できます。
この機能がしっくりくるのは、例えば、Postオブジェクトに著者の属性があり、実際にはUserクラスのインスタンスを参照しているときです。
通常factory\_botは関連名からファクトリ名を推定できるものの、この場合は著者のファクトリを探して徒労になります。
そのため利用者のファクトリに別称を付ければ別称名で使えます。

```ruby
factory :user, aliases: [:author, :commenter] do
  first_name { "John" }
  last_name { "Doe" }
  date_of_birth { 18.years.ago }
end

factory :post do
  # 別称を使うと以下の代わりに著者で書けます。
  # association :author, factory: :user
  author
  title { "How to read a book effectively" }
  body { "There are five steps involved." }
end

factory :comment do
  # 別称を使うと以下の代わりに評論家で書けます。
  # association :commenter, factory: :user
  commenter
  body { "Great article!" }
end
```
