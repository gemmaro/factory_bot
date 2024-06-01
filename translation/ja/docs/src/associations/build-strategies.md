# 構築戦略

関連は既定で親オブジェクトと同じ構築戦略を使います。

```ruby
FactoryBot.define do
  factory :author

  factory :post do
    author
  end
end

post = build(:post)
post.new_record?        # => true
post.author.new_record? # => true

post = create(:post)
post.new_record?        # => false
post.author.new_record? # => false
```

これは以前のバージョンのfactory\_botの既定の挙動とは異なります。
関連の戦略は必ずしも親オブジェクトの戦略と合致していませんでした。
古い挙動を使い続けたいときは、`use_parent_strategy`構成オプションを`false`に設定できます。

```ruby
FactoryBot.use_parent_strategy = false

# UserとPostを構築して保存します。
post = create(:post)
post.new_record?        # => false
post.author.new_record? # => false

# Userを構築して保存します。またPostを構築するものの保存はしません。
post = build(:post)
post.new_record?        # => true
post.author.new_record? # => false
```

紐付くオブジェクトを保存しないためには、ファクトリで`strategy: :build`を指定します。

```ruby
FactoryBot.use_parent_strategy = false

factory :post do
  # ...
  association :author, factory: :user, strategy: :build
end

# Userを構築し、Postを構築します。ただし何れも保存しません。
post = build(:post)
post.new_record?        # => true
post.author.new_record? # => true
```

なお`strategy: :build`オプションは`association`の明示的な呼び出しで渡さなければなりません。
暗黙の関連では使えません。

```ruby
factory :post do
  # ...
  author strategy: :build    # <<< これはうまくいき「ません」。author_idがnilになります。
```
