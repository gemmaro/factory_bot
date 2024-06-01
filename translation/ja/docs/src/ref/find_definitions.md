# FactoryBot.find_definitions

`FactoryBot.find_definitions`メソッドはプロジェクトに亙る全てのfactory\_botの定義を読み込みます。

読込順は`FactoryBot.definition_file_paths`属性で制御します。
既定の読込順は以下の通りです。

1. `factories.rb`
1. `test/factories.rb`
1. `test/factories/**/*.rb`
1. `spec/factories.rb`
1. `spec/factories/**/*.rb`

## Rails

`.find_definitions`メソッドは初期化後に`factory_bot_rails`により自動的に呼ばれます。
初期化時に（`config/initializers`などで）`.definition_file_paths`を設定したり、`Rails.application.config.factory_bot.definition_file_paths`で設定したりできます。
