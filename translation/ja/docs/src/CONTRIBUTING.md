# Factory Botへの貢献

どなたでもプルリクエストを歓迎します。
このプロジェクトに参加することで、thoughtbotの[行動規範][code of conduct]に従うことに同意したものとします。

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

以下は*あなた*が貢献できる方法です。

* アルファ、ベータ、プレリリースのバージョンを使う
* 不具合を報告する
* 新機能を提案する
* ドキュメントを書いたり編集したりする
* 仕様を書く
* コードを書く（**どんなパッチも些細ではありません**。誤植修正やコメントの追加などもそうです）
* コードを改修する
* [イシュー][issues]を閉じる
* パッチをレビューする

[issues]: https://github.com/thoughtbot/factory_bot/issues

## イシューを送る

* [GitHubのイシュートラッカー][issues]を使って不具合と機能と把握しています。
* 不具合報告や機能の要望を送る前に、既に送られていないか必ずお確かめください。
* 不具合報告を送るとき、[再現スクリプト][reproduction
  script]とその不具合を再現するのに必要かもしれないその他の詳細を含めてください。
  これにはgemのバージョン、Rubyのバージョン、オペレーティングシステムが含まれます。

## イシューを整頓する

* 送信者から反応がないイシューは30日以降に閉じられます。
* イシューは修正されたり回答されたと思われたときに閉じられます。
  メンテナが間違っていたときは再び開くことがあります。
* イシューが間違って閉じられたときはイシューを理解して説明してください。
  喜んでイシューを再度開きます。

## プルリクエストを送る

1. [公式リポジトリ][repo]を[フォーク][fork]します。
1. [トピックブランチを作ります][branch]。
1. 機能や不具合修正を実装します。
1. 変更を加え、コミットし、プッシュします。
1. [プルリクエストを送る][pr]。

### 補足

* コードを変えたときはテストを加えてください。
  テストのない貢献は受け付けられません。
* テストの加え方が分からなければ、PRを作って手助けを求めるコメントを残してください。
  喜んでお手伝いします！
* gemのバージョンを更新しないでください。

## 準備

```sh
bundle install
```

## テストスートを走らせる

規定のrakeタスクは完全なテストスートと[standard]を走らせます。

```sh
bundle exec rake
```

1グループのテスト（単体、スペック、機能）を走らせることもできます。

```sh
bundle exec rake spec:unit
bundle exec rake spec:acceptance
bundle exec rake features
```

個別のrspecのテストを走らせるため、パスと行番号を与えられます。

```sh
bundle exec rspec spec/path/to/spec.rb:123
```

[appraisal]で特定のバージョンのrailsでテストを走らせられます。
Rails 6に対して規定のrakeタスクを走らせる例は以下です。

```sh
bundle exec appraisal 6.0 rake
```

## 整形

自動でコードを整形するには[standard]を使ってください。

```sh
bundle exec rake standard:fix
```

[repo]: https://github.com/thoughtbot/factory_bot/tree/main
[fork]: https://help.github.com/articles/fork-a-repo/
[branch]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/
[pr]: https://help.github.com/articles/using-pull-requests/
[standard]: https://github.com/testdouble/standard
[appraisal]: https://github.com/thoughtbot/appraisal
[reproduction script]: https://github.com/thoughtbot/factory_bot/blob/main/.github/REPRODUCTION_SCRIPT.rb

https://github.com/middleman/middleman-heroku/blob/master/CONTRIBUTING.md
から着想を得ました。
