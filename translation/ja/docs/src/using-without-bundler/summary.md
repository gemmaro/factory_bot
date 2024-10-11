# Bundler無しで使う

Bundlerを使わないとき、gemがインストールされて呼ばれていることを確認してください。

```ruby
require 'factory_bot'
```

一旦requireされたら、`spec/factories`または`test/factories`のディレクトリ構造があるとして、以下を走らせるだけで済みます。

```ruby
FactoryBot.find_definitions
```

ファクトリ用の個別のディレクトリ構造を使っているとき、定義を見付けようとする前に定義ファイルパスを代えられます。

```ruby
FactoryBot.definition_file_paths = %w(custom_factories_directory)
FactoryBot.find_definitions
```

ファクトリの個別のディレクトリがなく、行内に定義したいときも可能です。

```ruby
require 'factory_bot'

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    date_of_birth { 21.years.ago }
  end
end
```
