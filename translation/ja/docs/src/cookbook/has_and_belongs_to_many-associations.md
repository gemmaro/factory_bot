# has_and_belongs_to_many関連

`has_and_belongs_to_many`の関係でデータを生成するのは前述の`has_many`の関係とよく似ています。
属性名の単数形のバージョンへの単一のオブジェクトではなく、モデルの複数形の属性名にオブジェクトの配列を渡す必要があります。


```ruby
def profile_with_languages(languages_count: 2)
  FactoryBot.create(:profile) do |profile|
    FactoryBot.create_list(:language, languages_count, profiles: [profile])
  end
end
```

もしくはコールバックの方法では以下となります。

```ruby
factory :profile_with_languages do
  transient do
    languages_count { 2 }
  end

  after(:create) do |profile, context|
    create_list(:language, context.languages_count, profiles: [profile])
    profile.reload
  end
end
```

あるいは行内関連の方法では以下です（なおここでの`instance`の利用は、構築されるプロファイルへの参照です）。

```ruby
factory :profile_with_languages do
  transient do
    languages_count { 2 }
  end

  languages do
    Array.new(languages_count) do
      association(:language, profiles: [instance])
    end
  end
end
```
