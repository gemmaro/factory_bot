# 関連の上塗り

属性の上塗りは紐付くオブジェクトを結び付けるのに使えます。

```ruby
FactoryBot.define do
  factory :author do
    name { 'Taylor' }
  end

  factory :post do
    author
  end
end

eunji = build(:author, name: 'Eunji')
post = build(:post, author: eunji)
```

Ruby 3.1の`Hash`表記での[バリューの省略][omitting
values]対応は属性の上塗りにぴったり馴染む機能で、変数名の繰り返しになるところを削減できます。

```ruby
author = build(:author, name: 'Eunji')

post = build(:post, author:)
```

[omitting values]: https://docs.ruby-lang.org/en/3.1/syntax/literals_rdoc.html#label-Hash+Literals
