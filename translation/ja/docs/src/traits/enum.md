# 列挙トレイト

列挙属性を持つActive Recordがあるとします。

```rb
class Task < ActiveRecord::Base
  enum status: {queued: 0, started: 1, finished: 2}
end

```

factory\_botは列挙体の取り得る値それぞれについて自動的にトレイトを定義します。

```rb
FactoryBot.define do
  factory :task
end

FactoryBot.build(:task, :queued)
FactoryBot.build(:task, :started)
FactoryBot.build(:task, :finished)
```

手でトレイトを書くのは億劫であり、必要ありません。

```rb
FactoryBot.define do
  factory :task do
    trait :queued do
      status { :queued }
    end

    trait :started do
      status { :started }
    end

    trait :finished do
      status { :finished }
    end
  end
end
```

全てのファクトリで列挙属性にトレイトを自動的に定義することが望ましくなければ、この機能を`FactoryBot.automatically_define_enum_traits
= false`で無効にできます。

その場合でも特定のファクトリで列挙属性にトレイトを明示的に定義できます。

```rb
FactoryBot.automatically_define_enum_traits = false

FactoryBot.define do
  factory :task do
    traits_for_enum(:status)
  end
end
```

他の列挙できる値にこの機能を使うこともできます。
特別にActive Recordの列挙属性に結び付いているわけではありません。

配列の場合は以下です。

```rb
class Task
  attr_accessor :status
end

FactoryBot.define do
  factory :task do
    traits_for_enum(:status, ["queued", "started", "finished"])
  end
end
```

あるいはハッシュの場合は以下です。

```rb
class Task
  attr_accessor :status
end

FactoryBot.define do
  factory :task do
    traits_for_enum(:status, { queued: 0, started: 1, finished: 2 })
  end
end
```
