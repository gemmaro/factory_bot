# フック

`factory`定義ブロックや`FactoryBot.define`ブロック内部では、`after`メソッドや`before`メソッドや`callback`メソッドが使えます。
これにより[構築戦略][build strategies]の一部にフックを掛けられます。

[build strategies]: build-strategies.html

`factory`定義ブロック内では、これらのコールバックはそのファクトリのみのスコープとなります。
`FactoryBot.define`ブロック内では、全てのファクトリに対して大域的になります。

## `callback`

`callback`メソッドは任意のfactory\_botコールバックを名前でフックを掛けられます。
[構築戦略][build
strategies]の便覧に見られる通り、予め定義された名前は`after_build`と`before_create`と`after_create`と`after_stub`です。

このメソッドはスプラットされる名前とブロックを取ります。
名前のどれかが活性になる度にブロックが呼ばれます。
ブロックは`#to_proc`に応答する任意のものにできます。

このブロックは2つの実引数を取ります。
1つはファクトリのインスタンスで、もう1つはfactory\_botの文脈です。
文脈は[transient](transient.html)属性を持ちます。

同じコールバック名を複数回フックに掛けられます。
全てのブロックが定義された順に走ります。
コールバックは親から継承します。
親のコールバックが最初に走ります。

## `after`メソッドと`before`メソッド

`after`メソッドと`before`メソッドは`callback`にいい感じの構文を加えています。

```ruby
after(:create) do |user, context|
  user.post_first_article(context.article)
end

callback(:after_create) do |user, context|
  user.post_first_article(context.article)
end
```
