# 複数のレコードの構築と作成

ファクトリの複数のインスタンスを一括で作成したり構築したりしたいときがあります。

```ruby
built_users   = build_list(:user, 25)
created_users = create_list(:user, 25)
```

これらのメソッドは指定量のファクトリを構築ないし作成し、配列として返します。
各ファクトリに属性を設定する上ではいつも通りハッシュで渡せます。

```ruby
twenty_year_olds = build_list(:user, 25, date_of_birth: 20.years.ago)
```

各ファクトリに異なる属性を設定するためには、これらのメソッドにブロックを渡せます。
そこでファクトリと仮引数として添字を持たせます。

```ruby
twenty_somethings = build_list(:user, 10) do |user, i|
  user.date_of_birth = (20 + i).years.ago
end
```

`create_list`は保存されたインスタンスをブロックに保存します。
インスタンスを変更したらまた保存しなければなりません。

```ruby
twenty_somethings = create_list(:user, 10) do |user, i|
  user.date_of_birth = (20 + i).years.ago
  user.save!
end
```

`build_stubbed_list`では、完全にスタブ化されたインスタンスが得られます。

```ruby
stubbed_users = build_stubbed_list(:user, 25) # スタブ化された利用者の配列
```

2つのレコードを一括で作る`*_pair`メソッドの一式もあります。

```ruby
built_users   = build_pair(:user) # 2つの構築された利用者の配列
created_users = create_pair(:user) # 2つの作成された利用者の配列
```

複数の属性のハッシュが必要なとき、`attributes_for_list`で生成します。

```ruby
users_attrs = attributes_for_list(:user, 25) # 属性ハッシュの配列
```

