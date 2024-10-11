# 相互接続関連

オブジェクトが相互接続する方法は際限なくあり、factory\_botは常にそうした関係を扱うのに向いていないかもしれません。
factory\_botを使って個々のオブジェクトを構築し、素のRubyで補助メソッドを書いてこうしたオブジェクトを結び付けるのが理に適っている場合があります。

つまり、より複雑で相互接続された関係は、行内関連と構築される`instance`への参照とを使ってfactory\_botで構築できるということです。

モデルが以下のようなものであるとします。
ここで紐付く`Student`と`Profile`は両方とも同じ`School`に属します。

```ruby
class Student < ApplicationRecord
  belongs_to :school
  has_one :profile
end

class Profile < ApplicationRecord
  belongs_to :school
  belongs_to :student
end

class School < ApplicationRecord
  has_many :students
  has_many :profiles
end
```

生徒とプロファイルが相互に接続し、同じ学校にあることを以下のようなファクトリで確かめられます。

```ruby
FactoryBot.define do
  factory :student do
    school
    profile { association :profile, student: instance, school: school }
  end

  factory :profile do
    school
    student { association :student, profile: instance, school: school }
  end

  factory :school
end
```

なおこの方法は`build`や`build_stubbed`や`create`で上手くいきます。
ただし`attributes_for`を使うと紐付けから`nil`が返ります。

また、独自の`initialize_with`内で属性を代入したとき（例えば`initialize_with { new(**attributes)
}`）、これらの属性は`instance`を参照すべきではないことにも注意してください。
`nil`になるからです。
