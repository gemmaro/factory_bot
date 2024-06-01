# ファクトリのリント

factory\_botは既知のファクトリをリントできます。

```ruby
FactoryBot.lint
```

`FactoryBot.lint`は各ファクトリを作って作成の仮定で投げられた例外を捕えます。
作成されなかったファクトリのリスト（と対応する例外）を持つ`FactoryBot::InvalidFactoryError`が投げられます。

`FactoryBot.lint`のお勧めの使い方はテストスートが実行される前に個別のタスクでこれを走らせることです。
`before(:suite)`で走らせるとテスト単体を走らせるときにテストの効率に直に打撃があります。

Rakeタスクの例は以下です。

```ruby
# lib/tasks/factory_bot.rake
namespace :factory_bot do
  desc "Verify that all FactoryBot factories are valid"
  task lint: :environment do
    if Rails.env.test?
      conn = ActiveRecord::Base.connection
      conn.transaction do
        FactoryBot.lint
        raise ActiveRecord::Rollback
      end
    else
      system("bundle exec rake factory_bot:lint RAILS_ENV='test'")
      fail if $?.exitstatus.nonzero?
    end
  end
end
```

`FactoryBot.lint`を読んだ後、恐らくデータベースを整頓したいことでしょう。
レコードが作成されていることでしょうから。
上で与えられた例ではSQLトランザクションを使ってロールバックし、データベースが綺麗なままにします。

リントしたいファクトリのみを選んで渡してファクトリをリントできます。

```ruby
factories_to_lint = FactoryBot.factories.reject do |factory|
  factory.name =~ /^old_/
end

FactoryBot.lint factories_to_lint
```

こうすると`old_`が接頭辞にない全てのファクトリがリントされます。

トレイトもリントされます。
このオプションは各ファクトリの全トレイトが有効なオブジェクトを生成することを自動で検証します。
これは`lint`メソッドに`traits: true`を渡すと有効になります。

```ruby
FactoryBot.lint traits: true
```

これは他の実引数とも組み合わせられます。

```ruby
FactoryBot.lint factories_to_lint, traits: true
```

リントに使われる戦略を指定することもできます。

```ruby
FactoryBot.lint strategy: :build
```

冗長なリントは各エラーに完全なバックトレースを含めます。
デバッグで役に立つことがあります。

```ruby
FactoryBot.lint verbose: true
```
