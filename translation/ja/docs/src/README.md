# factory_bot [![ビルド状態][ci-image]][ci] [![Code Climate][grade-image]][grade] [![Gemのバージョン][version-image]][version]

factory_botはフィクスチャの代わりになるものです。
直感的な定義構文であり、複数の構築戦略（保存されたインスタンス、保存されないインスタンス、属性ハッシュ、スタブ化オブジェクト）、ファクトリ継承を含む同じクラスに対する複数のファクトリ（user、admin_user、など）に対応しています。

Railsでfactory_botを使いたいときは[factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)を参照してください。

_[プロジェクト名の歴史に関心がありますか][NAME]_


### factory\_girlから移行されますか

[手引き](https://github.com/thoughtbot/factory_bot/blob/4-9-0-stable/UPGRADE_FROM_FACTORY_GIRL.md)をご確認ください。


ドキュメント
------

[factory_botの本][the factory_bot book]で網羅的な参照、手引き、レシピを参照してください。

RSpecやRailsといったサードパーティライブラリの統合についての情報は[factory_botのウィキ][the factory_bot
wiki]を参照してください。

[詳細な導入のための映像][a detailed introductory video]もあります。
Upcaseで無料で見られます。

[a detailed introductory video]: https://upcase.com/videos/factory-bot?utm_source=github&utm_medium=open-source&utm_campaign=factory-girl
[the factory_bot book]: https://thoughtbot.github.io/factory_bot
[the factory_bot wiki]: https://github.com/thoughtbot/factory_bot/wiki

インストール
--------

以下を走らせてください。

```ruby
bundle add factory_bot
```

シェルで手動でgemをインストールするには、以下を走らせてください。

```shell
gem install factory_bot
```

対応しているRubyのバージョン
----------------

対応しているRubyのバージョンは[`.github/workflows/build.yml`](https://github.com/thoughtbot/factory_bot/blob/main/.github/workflows/build.yml)に一覧になっています。

その他の情報
------

* [Rubygems](https://rubygems.org/gems/factory_bot)
* [Stack Overflow](https://stackoverflow.com/questions/tagged/factory-bot)
* [イシュー](https://github.com/thoughtbot/factory_bot/issues)
* [GIANT ROBOTS SMASHING INTO OTHER GIANT
  ROBOTS](https://robots.thoughtbot.com/)

[GETTING_STARTED]: https://github.com/thoughtbot/factory_bot/blob/main/GETTING_STARTED.md
[NAME]: https://github.com/thoughtbot/factory_bot/blob/main/NAME.md

有用なツール
------

* [FactoryTrace](https://github.com/djezzzl/factory_trace)は使われていないファクトリやトレイトを見付けるのに役立ちます。

貢献
--

[CONTRIBUTING.md](https://github.com/thoughtbot/factory_bot/blob/main/CONTRIBUTING.md)を参照してください。

factory_botは元はJoe Ferrisにより書かれ、thoughtbotにより保守されています。
多くの向上と不具合の修正が[オープンソースコミュニティ](https://github.com/thoughtbot/factory_bot/graphs/contributors)により貢献されました。

使用許諾
----

factory_bot is Copyright © 2008 Joe Ferris and thoughtbot. It is free
software, and may be redistributed under the terms specified in the
[LICENSE] file.

[LICENSE]: https://github.com/thoughtbot/factory_bot/blob/main/LICENSE

<!-- START /templates/footer.md -->
## thoughtbotについて

![thoughtbot](https://thoughtbot.com/thoughtbot-logo-for-readmes.svg)

このリポジトリはthoughtbot, inc.により保守され、資金提供されています。
thoughtbotの名前とロゴはthoughtbot, inc.の商標です。

私達はオープンソースソフトウェアが大好きです！
[私達の他のプロジェクト][community]を参照してください。
[求人を募集しています][hire]。

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github


<!-- END /templates/footer.md -->

[ci-image]: https://github.com/thoughtbot/factory_bot/actions/workflows/build.yml/badge.svg?branch=main
[ci]: https://github.com/thoughtbot/factory_bot/actions?query=workflow%3ABuild+branch%3Amain
[grade-image]: https://codeclimate.com/github/thoughtbot/factory_bot/badges/gpa.svg
[grade]: https://codeclimate.com/github/thoughtbot/factory_bot
[version-image]: https://badge.fury.io/rb/factory_bot.svg
[version]: https://badge.fury.io/rb/factory_bot
[hound-badge-image]: https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg
[hound]: https://houndci.com
