# 一過的属性

一過的属性とは、ファクトリ定義内でのみ使える属性で、オブジェクトが構築されるときには設定されません。
これにより、もっと複雑な仕組みをファクトリ内に書けます。

これらの属性は`transient`ブロック内に定義します。

```ruby
factory :user do
  name { "Zero Cool" }
  birth_date { age&.years.ago }

  transient do
    age { 11 } # 上の`birth_date`に設定するためだけに使われます。
  end
end
```
