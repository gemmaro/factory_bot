# traits_for_enum

`factory`定義ブロックに於いて、`traits_for_enum`メソッドはいくつかの値のうちどれか1つになる属性の任意のオブジェクト用の補助機能です。
元となった着想は[`ActiveRecord::Enum`]ですが、制限された値の集まりのある任意の属性に適用できます。

[`ActiveRecord::Enum`]: https://api.rubyonrails.org/classes/ActiveRecord/Enum.html

このメソッドは各値にトレイトを作ります。

`traits_for_enum`メソッドは必須の属性名と省略できる値の集合を取ります。
値は任意のEnumerableにできます。
例えばArrayやHashです。
既定では値は`nil`です。

値がArrayのとき、このメソッドは配列内の各要素にトレイトを定義します。
トレイト名は配列の要素であり、同じ配列の要素に属性を設定します。

値がHashのとき、このメソッドはキーに基づくトレイトを定義し、属性を値に設定します。
トレイト名はキーであり、属性を値に設定します。

値が何らかのEnumerableのとき、ArrayまたはHashのように扱います。
ここでは`#each`がHashのように対を反復するかどうかに基づきます。

値がnilのとき、複数形になった属性名に因むクラスメソッドを使います。

```ruby
FactoryBot.define do
  factory :article do
    traits_for_enum :visibility, [:public, :private]
    # trait :public do
    #   visibility { :public }
    # end
    # trait :private do
    #   visibility { :private }
    # end

    traits_for_enum :collaborative, draft: 0, shared: 1
    # trait :draft do
    #   collaborative { 0 }
    # end
    # trait :shared do
    #   collaborative { 1 }
    # end

    traits_for_enum :status
    # Article.statuses.each do |key, value|
    #   trait key do
    #     status { value }
    #   end
    # end
  end
end
```
