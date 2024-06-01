# 定義ファイルパス

ファクトリはどこでも定義できます。
しかしファクトリが以下の場所のファイルで定義された場合、`FactoryBot.find_definitions`を読んだ後に自動的に読み込まれます。

    test/factories.rb
    spec/factories.rb
    test/factories/*.rb
    spec/factories/*.rb
