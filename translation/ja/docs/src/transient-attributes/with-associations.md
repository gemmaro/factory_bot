# 関連付き

一過的[関連](../associations/summary.md)はfactory\_botでは対応していません。
一過的ブロック内の関連は通常の一過的でない関連として扱われます。

必要であれば、一般には一過的属性内でファクトリを構築して回避できます。

```ruby
factory :post

factory :user do
  transient do
    post { build(:post) }
  end
end
```
