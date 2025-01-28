# 独自の戦略

独自の構築の戦略を加えてfactory\_botの挙動を拡張したいときがあります。

戦略は2つのメソッド`association`及び`result`を定義します。
`association`は`FactoryBot::FactoryRunner`インスタンスを受け取ります。
このインスタンスは`run`を呼んでお好みで戦略を上塗りできます。
2つ目のメソッド`result`は`FactoryBot::Evaluation`インスタンスを受け取ります。
コールバック、`object`、`hash`（結果のインスタンスやファクトリで定義された属性に基づくハッシュを得るためのもの）、`create`のきっかけとなる手段を（`notify`で）を提供します。
`create`はファクトリで定義された`to_create`コールバックを実行します。

factory\_botで、戦略が内部で使われる仕組みを理解するには、4つの既定の戦略それぞれのソースを眺めるのが、恐らく一番簡単です。

以下は`FactoryBot::Strategy::Create`を使ってモデルにJSON表現を構築する戦略を組む例です。

```ruby
class JsonStrategy
  def initialize
    @strategy = FactoryBot.strategy_by_name(:create).new
  end

  delegate :association, to: :@strategy

  def result(evaluation)
    @strategy.result(evaluation).to_json
  end

  def to_sym
    :json
  end
end
```

factory\_botに新しい戦略を認識させるために、その戦略を登録できます。

```ruby
FactoryBot.register_strategy(:json, JsonStrategy)
```

こうして呼べるようになります。

```ruby
FactoryBot.json(:user)
```

最後に、戦略の代わりに新しいオブジェクトと登録することによってfactory\_bot独自の戦略を上塗りできます。
