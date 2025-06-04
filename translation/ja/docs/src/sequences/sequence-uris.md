# 系列URI

特定の系列を操作したい理由は沢山あります。

- 単一の値を生成：`generate`
- 複数の値を生成：`generate_list`
- `FactoryBot.rewind_sequences`で新しい値に設定
- 巻き戻し：`rewind_sequence`

これを達成するには、所望の系列を参照できる必要があります。
これはその系列の一意なURIで実現できます。

## URI合成

各URIは3つの名前が組み合わさったものです。

| 位置 | 名前           | 必要かどうか                                                             |
| :------: | -------------- | -------------------------------------------------------------------- |
|    1.    | ファクトリ名  | **条件付き** - 系列はファクトリないしファクトリトレイト内で定義されます |
|    2.    | トレイト名    | **条件付き** - 系列はトレイト内で定義されます                      |
|    3.    | 系列名 | **必ず必要**                                                  |

URIは個々のシンボルとして入力されます。

```ruby
generate(:my_factory_name, :my_trait_name, :my_sequence_name)
```

**あるいは** 個々の文字列として入力されます。

```ruby
generate('my_factory_name', 'my_trait_name', 'my_sequence_name')
```

**あるいは** 単一のリソース文字列として入力されます。

```ruby
generate("my_factory_name/my_trait_name/my_sequence_name")
```

## 完全なURIの例

以下の例では詳しく全てのあり得るシナリオを説明しています。
コメントでは、それぞれの系列の値を生成するのに使われるURIを示しています。

```ruby
FactoryBot.define do
  sequence(:sequence) {|n| "global_sequence_#{n}"}
  # generate(:sequence)

  trait :global_trait do
    sequence(:sequence) {|n| "global_trait_sequence_#{n}"}
    # generate(:global_trait, :sequence)
  end

  factory :user do
    sequence(:sequence) {|n| "user_sequence_#{n}"}
    # generate(:user, :sequence)

    trait :user_trait do
      sequence(:sequence) {|n| "user_trait_sequence_#{n}"}
      # generate(:user, :user_trait, :sequence)
    end

    factory :author do
      sequence(:sequence) {|n| "author_sequence_#{n}"}
      # generate(:author, :sequence)

      trait :author_trait do
        sequence(:sequence) {|n| "author_trait_sequence_#{n}"}
        # generate(:author, :author_trait, :sequence)
      end
    end
  end
end
```

## 複数URI

1つの系列に複数のURIを持たせることができます。

ファクトリやトレイトに別称があるとき、系列はそれぞれの別称、また別称の組み合わせ毎に、追加でURIを持ちます。

この例では、同じ系列を4つの異なる方法で参照できます。

```ruby
factory :user, aliases: [:author] do
  trait :user_trait, aliases: [:author_trait] do
    sequence(:sequence) {|n| "author_trait_sequence_#{n}"}
  end
end

# generate(:user,   :user_trait,   :sequence)
# generate(:user,   :author_trait, :sequence)
# generate(:author, :user_trait,   :sequence)
# generate(:author, :author_trait, :sequence)
```

<div class='warning'>

## 重要

- どれだけ深く入れ子になっていても、URIのファクトリ名の構成要素は常に、その系列が定義されているファクトリです。
  決して親ファクトリではありません。

- ファクトリが系列を継承するとき、URIはそれが定義されたファクトリを参照しなくてはなりません。
  使われているファクトリではありません。

</div>
