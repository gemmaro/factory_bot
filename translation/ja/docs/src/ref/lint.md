# FactoryBot.lint

`FactoryBot.lint`メソッドは各ファクトリを試して失敗したときに`FactoryBot::InvalidFactoryError`を投げます。

以下の省略できる実引数を取れます。

- スプラットされるファクトリ名です。
  これは1つのみにリントの対象を制限します。
  既定は全てです。
- `:strategy`は使う[構築戦略][build strategy]です。
  既定は`:create`です。
- `:traits`は各トレイトの構築も試みるかどうかを表します。
  既定は`false`です。
- `:verbose`はエラーでスタックトレースを表示するかどうかです。
  既定は`false`です。

[build strategy]: build-strategies.html

`.lint`をシステムにフックを掛けるお勧めの工夫については、[手引き](../linting-factories/summary.html)で説明されています。
