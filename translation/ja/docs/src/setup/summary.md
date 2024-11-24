# 準備

インストール手順は様々です。
もしあれば使っているフレームワークに依りますし、テストフレームワークについても考えられます。

インストール手順が私達の手の届かないコードに基づいて様々であるため、そうしたドキュメントは[ウィキ][our wiki]で更新され続けます。
フレームワークが変わったときにウィキを編集することをお勧めします。

以降では最もよくある準備をドキュメントとして書きます。
**しかし詳細は[ウィキ][our wiki]をあたってください。**

[our wiki]: https://github.com/thoughtbot/factory_bot/wiki/Installation

## Gemfileの更新

Railsを使っている場合は次のようにしてください。

```ruby
gem "factory_bot_rails"
```

Railsを使って*いない*場合は次のようにしてください。

```ruby
gem "factory_bot"
```

詳細については[私達のウィキ][our wiki]を参照してください。

## テストスートの構成

### RSpec

```ruby
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```

### Test::Unit

```ruby
class Test::Unit::TestCase
  include FactoryBot::Syntax::Methods
end
```

詳細については[私達のウィキ][our wiki]を参照してください。
