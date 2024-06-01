**廃止されました**

[factory_botの本][the factory_bot book]で網羅的な参照、手引き、料理本を参照してください。

RSpecやRailsといったサードパーティライブラリの統合についての情報は[factory_botのwiki][the factory_bot
wiki]を参照してください。

[詳細な導入のための映像][a detailed introductory video]もあります。
Upcaseで無料で見られます。

[a detailed introductory video]: https://upcase.com/videos/factory-bot?utm_source=github&utm_medium=open-source&utm_campaign=factory-girl
[the factory_bot book]: https://thoughtbot.github.io/factory_bot
[the factory_bot wiki]: https://github.com/thoughtbot/factory_bot/wiki

This document is deprecated and preserved for historical use. It may
disappear at any time.

初めの一歩
=====

* [準備](#setup)
  + [Gemfileの更新](#update-your-gemfile)
  + [テストスートの構成](#configure-your-test-suite)
    - [RSpec](#rspec)
    - [Test::Unit](#testunit)
    - [Cucumber](#cucumber)
    - [Spinach](#spinach)
    - [Minitest](#minitest)
    - [Minitest::Spec](#minitestspec)
    - [minitest-rails](#minitest-rails)
* [ファクトリの定義](#defining-factories)
  + [ファクトリ名と属性](#factory-name-and-attributes)
  + [クラスを明示的に指定](#specifying-the-class-explicitly)
  + [ハッシュ属性](#hash-attributes)
  + [ベストプラクティス](#best-practices)
  + [定義ファイルパス](#definition-file-paths)
  + [静的属性](#static-attributes)
* [ファクトリを使う](#using-factories)
  + [構築戦略](#build-strategies)
  + [属性の上塗り](#attribute-overrides)
  + [`build_stubbed`と`Marshal.dump`](#build_stubbed-and-marshaldump)
* [別称](#aliases)
* [依存属性](#dependent-attributes)
* [一過的属性](#transient-attributes)
  + [他の属性付き](#with-other-attributes)
  + [`attributes_for`付き](#with-attributes_for)
  + [コールバック付き](#with-callbacks)
  + [関連付き](#with-associations)
* [メソッド名と予約語の属性](#method-name--reserved-word-attributes)
* [継承](#inheritance)
  + [入れ子のファクトリ](#nested-factories)
  + [明示的な親の代入](#assigning-parent-explicitly)
  + [ベストプラクティス](#best-practices-1)
* [関連](#associations)
  + [暗黙定義](#implicit-definition)
  + [明示定義](#explicit-definition)
  + [行内定義](#inline-definition)
  + [ファクトリの指定](#specifying-the-factory)
  + [属性の上塗り](#overriding-attributes)
  + [関連の上塗り](#association-overrides)
  + [構築戦略](#build-strategies-1)
  + [`has_many`関連](#has_many-associations)
  + [`has_and_belongs_to_many`関連](#has_and_belongs_to_many-associations)
  + [多相関連](#polymorphic-associations)
  + [相互接続関連](#interconnected-associations)
* [系列](#sequences)
  + [大域系列](#global-sequences)
  + [動的属性付き](#with-dynamic-attributes)
  + [暗黙属性付き](#as-implicit-attributes)
  + [行内系列](#inline-sequences)
  + [初期値](#initial-value)
  + [ブロックなし](#without-a-block)
  + [別称](#aliases-1)
  + [巻き戻し](#rewinding)
  + [一意性](#uniqueness)
* [トレイト](#traits)
  + [トレイトの定義](#defining-traits)
  + [暗黙属性として](#as-implicit-attributes-1)
  + [属性の優先度](#attribute-precedence)
  + [子のファクトリで](#in-child-factories)
  + [トレイトを使う](#using-traits)
  + [関連付き](#with-associations-1)
  + [トレイト内トレイト](#traits-within-traits)
  + [一過的続映付き](#with-transient-attributes)
  + [列挙トレイト](#enum-traits)
* [コールバック](#callbacks)
  + [既定のコールバック](#default-callbacks)
  + [複数コールバック](#multiple-callbacks)
  + [大域コールバック](#global-callbacks)
  + [Symbol#to_proc](#symbolto_proc)
* [ファクトリの変更](#modifying-factories)
* [複数のレコードの構築と作成](#building-or-creating-multiple-records)
* [ファクトリのリント](#linting-factories)
* [独自の構築](#custom-construction)
* [独自の戦略](#custom-strategies)
* [独自のコールバック](#custom-callbacks)
* [オブジェクトを永続化する独自メソッド](#custom-methods-to-persist-objects)
* [ActiveSupportの計装](#activesupport-instrumentation)
* [Railsの事前読込器とRSpec](#rails-preloaders-and-rspec)
* [Bundlerなしで使う](#using-without-bundler)

準備
--

### Gemfileの更新

Railsを使っている場合は次のようにしてください。

```ruby
gem "factory_bot_rails"
```

Railsを使って*いない*場合は次のようにしてください。

```ruby
gem "factory_bot"
```

### テストスートの構成

#### RSpec

If you're using Rails, add the following configuration to
`spec/support/factory_bot.rb` and be sure to require that file in
`rails_helper.rb`:

```ruby
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```

Railsを使って*いない*場合は次のようにしてください。

```ruby
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
```

#### Test::Unit

```ruby
class Test::Unit::TestCase
  include FactoryBot::Syntax::Methods
end
```

#### Cucumber

```ruby
# env.rb (Rails example location - RAILS_ROOT/features/support/env.rb)
World(FactoryBot::Syntax::Methods)
```

#### Spinach

```ruby
class Spinach::FeatureSteps
  include FactoryBot::Syntax::Methods
end
```

#### Minitest

```ruby
class Minitest::Unit::TestCase
  include FactoryBot::Syntax::Methods
end
```

#### Minitest::Spec

```ruby
class Minitest::Spec
  include FactoryBot::Syntax::Methods
end
```

#### minitest-rails

```ruby
class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
end
```

If you do not include `FactoryBot::Syntax::Methods` in your test suite, then
all factory\_bot methods will need to be prefaced with `FactoryBot`.

ファクトリの定義
--------

### ファクトリ名と属性

各ファクトリには名前と属性の一式があります。
名前は既定でオブジェクトのクラスを推測するために使われます。

```ruby
# 以下はUserクラスを推測します。
FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    admin { false }
  end
end
```

### クラスを明示的に指定

クラスを明示的に指定することもできます。

```ruby
# 以下はUserクラスを使います（こうしなければAdminが推測されていました）
factory :admin, class: "User"
```

定数が使えるときは定数も渡せます（なおこれは大きいRailsアプリケーションではテストの効率性の問題を引き起こすことがあります。
定数の参照が積極読込を引き起こすためです）。

```ruby
factory :access_token, class: User
```

### ハッシュ属性

Rubyのブロック構文があるため、（例えば直列化された列やJSONの列用に）属性を`Hash`として定義するには、2対の波括弧が必要です。

```ruby
factory :program do
  configuration { { auto_resolve: false, auto_define: true } }
end
```

### ベストプラクティス

お勧めは、各クラスに1つのファクトリがあるようにし、そのクラスのインスタンスを作るのに必要な、最も単純な属性一式を提供することです。
ActiveRecordオブジェクトを作る場合、これが意味するのは検証を通じて求められる属性のみを与え、既定値を持たせないということです。
他のファクトリは各クラスについて共通する筋書を押さえる上で継承を通じて作れます。

同じ名前で複数のファクトリを定義しようとするとエラーが投げられます。

### 定義ファイルパス

ファクトリはどこでも定義できます。
しかしファクトリが以下の場所のファイルで定義された場合、`FactoryBot.find_definitions`を読んだ後に自動的に読み込まれます。

    test/factories.rb
    spec/factories.rb
    test/factories/*.rb
    spec/factories/*.rb

### 静的属性

（ブロックの無い）静的属性はfactory_bot 5では使えなくなりました。
削除する決断についての詳細は[こちらのブログの記事](https://robots.thoughtbot.com/deprecating-static-attributes-in-factory_bot-4-11)をお読みいただけます。


ファクトリを使う
--------

### 構築戦略

factory\_botは複数の異なる構築戦略に対応しています。
`build`、`create`、`attributes_for`、`build_stubbed`です。

```ruby
# Returns a User instance that's not saved
user = build(:user)

# Returns a saved User instance
user = create(:user)

# Returns a hash of attributes that can be used to build a User instance
attrs = attributes_for(:user)

# Integrates with Ruby 3.0's support for pattern matching assignment
attributes_for(:user) => {email:, name:, **attrs}

# Returns an object with all defined attributes stubbed out
stub = build_stubbed(:user)

# Passing a block to any of the methods above will yield the return object
create(:user) do |user|
  user.posts.create(attributes_for(:post))
end
```

### 属性の上塗り

使われた戦略に依らず、Hashを渡して定義された属性を上塗りできます。

```ruby
# Userインスタンスを構築しfirst_name特性を上塗りします
user = build(:user, first_name: "Joe")
user.first_name
# => "Joe"
```

Overriding associations is also supported:

```ruby
account = build(:account, :deluxe)
friends = build_list(:user, 2)

user = build(:user, account: account, friends: friends)
```

Ruby 3.1の`Hash`表記での[バリューの省略][omitting
values]対応は属性の上塗りにぴったり馴染む機能で、変数名の繰り返しになるところを削減できます。

```ruby
account = build(:account, :deluxe)
friends = build_list(:user, 2)

# The keyword arguments correspond to local variable names, so omit their values
user = build(:user, account:, friends:)
```

[omitting values]: https://docs.ruby-lang.org/en/3.1/syntax/literals_rdoc.html#label-Hash+Literals

### `build_stubbed`と`Marshal.dump`

なお`build_stubbed`で作られたオブジェクトは`Marshal.dump`で直列化できません。
factory\_botはこれらのオブジェクトに特異メソッドを定義するからです。

別称
--

factory\_botでは既存のファクトリに別称を定義して簡単に再利用できます。
この機能がしっくりくるのは、例えば、Postオブジェクトに著者の属性があり、実際にはUserクラスのインスタンスを参照しているときです。
通常factory\_botは関連名からファクトリ名を推定できるものの、この場合は著者のファクトリを探して徒労になります。
そのため利用者のファクトリに別称を付ければ別称名で使えます。

```ruby
factory :user, aliases: [:author, :commenter] do
  first_name { "John" }
  last_name { "Doe" }
  date_of_birth { 18.years.ago }
end

factory :post do
  # 別称を使うと以下の代わりに著者で書けます。
  # association :author, factory: :user
  author
  title { "How to read a book effectively" }
  body { "There are five steps involved." }
end

factory :comment do
  # 別称を使うと以下の代わりに評論家で書けます。
  # association :commenter, factory: :user
  commenter
  body { "Great article!" }
end
```

依存属性
----

Attributes can be based on the values of other attributes using the
evaluator that is yielded to dynamic attribute blocks:

```ruby
factory :user do
  first_name { "Joe" }
  last_name  { "Blow" }
  email { "#{first_name}.#{last_name}@example.com".downcase }
end

create(:user, last_name: "Doe").email
# => "joe.doe@example.com"
```

一過的属性
-----
一過的属性とは、ファクトリ定義内でのみ使える属性で、オブジェクトが構築されるときには設定されません。
これにより、もっと複雑な仕組みをファクトリ内に書けます。

### 他の属性付き

There may be times where your code can be DRYed up by passing in transient
attributes to factories. You can access transient attributes within other
attributes (see [Dependent Attributes](#dependent-attributes)):

```ruby
factory :user do
  transient do
    rockstar { true }
  end

  name { "John Doe#{" - Rockstar" if rockstar}" }
end

create(:user).name
#=> "John Doe - ROCKSTAR"

create(:user, rockstar: false).name
#=> "John Doe"
```

### With `attributes_for`

Transient attributes will be ignored within attributes\_for and won't be set
on the model, even if the attribute exists or you attempt to override it.

### コールバック付き

If you need to access the evaluator in a factory\_bot callback, you'll need
to declare a second block argument (for the evaluator) and access transient
attributes from there.

```ruby
factory :user do
  transient do
    upcased { false }
  end

  name { "John Doe" }

  after(:create) do |user, evaluator|
    user.name.upcase! if evaluator.upcased
  end
end

create(:user).name
#=> "John Doe"

create(:user, upcased: true).name
#=> "JOHN DOE"
```

### 関連付き

Transient [associations](#associations) are not supported in factory\_bot.
Associations within the transient block will be treated as regular,
non-transient associations.

必要であれば、一般には一過的属性内でファクトリを構築して回避できます。

```ruby
factory :post

factory :user do
  transient do
    post { build(:post) }
  end
end
```

メソッド名と予約語の属性
-------------------------------

If your attributes conflict with existing methods or reserved words (all
methods in the
[DefinitionProxy](https://github.com/thoughtbot/factory_bot/blob/main/lib/factory_bot/definition_proxy.rb)
class) you can define them with `add_attribute`.

```ruby
factory :dna do
  add_attribute(:sequence) { 'GATTACA' }
end

factory :payment do
  add_attribute(:method) { 'paypal' }
end

```

Inheritance
-----------

### 入れ子のファクトリ

You can easily create multiple factories for the same class without
repeating common attributes by nesting factories:

```ruby
factory :post do
  title { "A title" }

  factory :approved_post do
    approved { true }
  end
end

approved_post = create(:approved_post)
approved_post.title    # => "A title"
approved_post.approved # => true
```

### 親を明示的に代入

親を明示的に代入することもできます。

```ruby
factory :post do
  title { "A title" }
end

factory :approved_post, parent: :post do
  approved { true }
end
```

### ベストプラクティス

As mentioned above, it's good practice to define a basic factory for each
class with only the attributes required to create it. Then, create more
specific factories that inherit from this basic parent. Factory definitions
are still code, so keep them DRY.

Associations
------------

### 暗黙定義

ファクトリ内で関連を設定することができます。
ファクトリ名が関連名と同じとき、ファクトリ名を省けます。

```ruby
factory :post do
  # ...
  author
end
```

### 明示定義

You can define associations explicitly. This can be handy especially when
[Overriding attributes](#overriding-attributes)

```ruby
factory :post do
  # ...
  association :author
end
```

### 行内定義

通常の属性内に行内で関連を定義することもできます。
ただし`attributes_for`戦略を使うときは値が`nil`になることに注意してください。

```ruby
factory :post do
  # ...
  author { association :author }
end
```

### ファクトリの指定

You can specify a different factory (although [Aliases](#aliases) might also
help you out here).

暗黙には以下とします。

```ruby
factory :post do
  # ...
  author factory: :user
end
```

明示的には以下とします。

```ruby
factory :post do
  # ...
  association :author, factory: :user
end
```

行内では以下とします。

```ruby
factory :post do
  # ...
  author { association :user }
end
```

### 属性の上塗り

You can also override attributes.

暗黙には以下とします。

```ruby
factory :post do
  # ...
  author factory: :author, last_name: "Writely"
end
```

明示的には以下とします。


```ruby
factory :post do
  # ...
  association :author, last_name: "Writely"
end
```

もしくはファクトリの属性を使って行内でもできます。

```rb
factory :post do
  # ...
  author_last_name { "Writely" }
  author { association :author, last_name: author_last_name }
end
```

### 関連の上塗り

属性の上塗りは紐付くオブジェクトを結び付けるのに使えます。

```ruby
FactoryBot.define do
  factory :author do
    name { 'Taylor' }
  end

  factory :post do
    author
  end
end

eunji = build(:author, name: 'Eunji')
post = build(:post, author: eunji)
```

### 構築戦略

In factory\_bot 5, associations default to using the same build strategy as
their parent object:

```ruby
FactoryBot.define do
  factory :author

  factory :post do
    author
  end
end

post = build(:post)
post.new_record?        # => true
post.author.new_record? # => true

post = create(:post)
post.new_record?        # => false
post.author.new_record? # => false
```

これは以前のバージョンのfactory\_botの既定の挙動とは異なります。
関連の戦略は必ずしも親オブジェクトの戦略と合致していませんでした。
古い挙動を使い続けたいときは、`use_parent_strategy`構成オプションを`false`に設定できます。

```ruby
FactoryBot.use_parent_strategy = false

# UserとPostを構築して保存します。
post = create(:post)
post.new_record?        # => false
post.author.new_record? # => false

# Userを構築して保存します。またPostを構築するものの保存はしません。
post = build(:post)
post.new_record?        # => true
post.author.new_record? # => false
```

紐付くオブジェクトを保存しないためには、ファクトリで`strategy: :build`を指定します。

```ruby
FactoryBot.use_parent_strategy = false

factory :post do
  # ...
  association :author, factory: :user, strategy: :build
end

# Userを構築し、Postを構築します。ただし何れも保存しません。
post = build(:post)
post.new_record?        # => true
post.author.new_record? # => true
```

Please note that the `strategy: :build` option must be passed to an explicit
call to `association`, and cannot be used with implicit associations:

```ruby
factory :post do
  # ...
  author strategy: :build    # <<< これはうまくいき「ません」。author_idがnilになります。
```

### `has_many` associations

`has_many`の関係でデータを生成するにはいくつか方法があります。
最も単純な方法は素のRubyで補助メソッドを書いて異なるレコードと結び付けることです。

```ruby
FactoryBot.define do
  factory :post do
    title { "Through the Looking Glass" }
    user
  end

  factory :user do
    name { "Rachel Sanchez" }
  end
end

def user_with_posts(posts_count: 5)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:post, posts_count, user: user)
  end
end

create(:user).posts.length # 0
user_with_posts.posts.length # 5
user_with_posts(posts_count: 15).posts.length # 15
```

オブジェクトの作成を完全にfactory\_botに留める方が好みであれば、`after(:create)`コールバック内で記事を構築できます。


```ruby
FactoryBot.define do
  factory :post do
    title { "Through the Looking Glass" }
    user
  end

  factory :user do
    name { "John Doe" }

    # user_with_posts will create post data after the user has been created
    factory :user_with_posts do
      # posts_count is declared as a transient attribute available in the
      # callback via the evaluator
      transient do
        posts_count { 5 }
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)

        # You may need to reload the record here, depending on your application
        user.reload
      end
    end
  end
end

create(:user).posts.length # 0
create(:user_with_posts).posts.length # 5
create(:user_with_posts, posts_count: 15).posts.length # 15
```

もしくは、`build`や`build_stubbed`や`create`で上手くいく（ただし`attributes_for`では上手くいきません）解決策として、行内関連が使えます。

```ruby
FactoryBot.define do
  factory :post do
    title { "Through the Looking Glass" }
    user
  end

  factory :user do
    name { "Taylor Kim" }

    factory :user_with_posts do
      posts { [association(:post)] }
    end
  end
end

create(:user).posts.length # 0
create(:user_with_posts).posts.length # 1
build(:user_with_posts).posts.length # 1
build_stubbed(:user_with_posts).posts.length # 1
```

柔軟性のため、これをコールバックの例の`posts_count`一過的属性と組み合わせられます。

```ruby
FactoryBot.define do
  factory :post do
    title { "Through the Looking Glass" }
    user
  end

  factory :user do
    name { "Adiza Kumato" }

    factory :user_with_posts do
      transient do
        posts_count { 5 }
      end

      posts do
        Array.new(posts_count) { association(:post) }
      end
    end
  end
end

create(:user_with_posts).posts.length # 5
create(:user_with_posts, posts_count: 15).posts.length # 15
build(:user_with_posts, posts_count: 15).posts.length # 15
build_stubbed(:user_with_posts, posts_count: 15).posts.length # 15
```

### `has_and_belongs_to_many` associations

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

  after(:create) do |profile, evaluator|
    create_list(:language, evaluator.languages_count, profiles: [profile])
    profile.reload
  end
end
```

あるいは行内関連の兵法では以下です（なおここでの`instance`の利用は、構築されるプロファイルへの参照です）。

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

### 多相関連

多相関連はトレイトで制御できます。

```ruby
FactoryBot.define do
  factory :video
  factory :photo

  factory :comment do
    for_photo # 何も指定されなければ既定で:for_photoトレイトです。

    trait :for_video do
      association :commentable, factory: :video
    end

    trait :for_photo do
      association :commentable, factory: :photo
    end
  end
end
```

こうして以下とできます。

```ruby
create(:comment)
create(:comment, :for_video)
create(:comment, :for_photo)
```

### 相互接続関連

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

Sequences
---------

### 大域系列

特定の形式（例えばEメールアドレス）の一意な値は系列を使って生成できます。
系列は定義ブロックで`sequence`を読んで定義されます。
系列の値は`generate`を読んで生成されます。

```ruby
# 新しい系列を定義します。
FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

generate :email
# => "person1@example.com"

generate :email
# => "person2@example.com"
```

### 動的属性付き

系列は動的属性で使えます。

```ruby
factory :invite do
  invitee { generate(:email) }
end
```

### 暗黙属性として

もしくは暗黙属性として以下とします。

```ruby
factory :user do
  email # Same as `email { generate(:email) }`
end
```

なお系列を暗黙属性として定義すると、ファクトリに系列として同じ名前があるときにうまくいかなくなります。

### 行内系列

また特定のファクトリでのみ使われる行内系列を定義することもできます。

```ruby
factory :user do
  sequence(:email) { |n| "person#{n}@example.com" }
end
```

Ruby 2.7の[連番仮引数][numbered parameters]の対応を使うと、行内定義はさらに縮められます。

```ruby
factory :user do
  sequence(:email) { "person#{_1}@example.com" }
end
```

[numbered parameters]: https://ruby-doc.org/core-2.7.1/Proc.html#class-Proc-label-Numbered+parameters

### 初期値

初期値を上塗りできます。
`#next`メソッドに応答する任意の値で動作します（例えば1、2、3、「a」、「b」、「c」）。

```ruby
factory :user do
  sequence(:email, 1000) { |n| "person#{n}@example.com" }
end
```

### ブロック無し

ブロック無しでは値はそれ自身を漸増させ、初期値から始めていきます。

```ruby
factory :post do
  sequence(:position)
end
```

Please note, that the value for the sequence could be any Enumerable
instance, as long as it responds to `#next`:

```ruby
factory :task do
  sequence :priority, %i[low medium high urgent].cycle
end
```

### 別称

系列には別称も付けられます。
系列の別称は同じ計数を共有します。

```ruby
factory :user do
  sequence(:email, 1000, aliases: [:sender, :receiver]) { |n| "person#{n}@example.com" }
end

# :emailの計数を漸増させます。:senderと:receiverと共有しています。
generate(:sender)
```

別称を定義して計数に既定値 (1) を使うには以下とします。

```ruby
factory :user do
  sequence(:email, aliases: [:sender, :receiver]) { |n| "person#{n}@example.com" }
end
```

値を設定するには以下です。

```ruby
factory :user do
  sequence(:email, 'a', aliases: [:sender, :receiver]) { |n| "person#{n}@example.com" }
end
```

The value just needs to support the `#next` method. Here the next value will
be 'a', then 'b', etc.

### 巻き戻し

系列は`FactoryBot.rewind_sequences`で巻き戻すこともできます。

```ruby
sequence(:email) {|n| "person#{n}@example.com" }

generate(:email) # "person1@example.com"
generate(:email) # "person2@example.com"
generate(:email) # "person3@example.com"

FactoryBot.rewind_sequences

generate(:email) # "person1@example.com"
```

こうすると全ての登録された系列が巻き戻ります。

### 一意性

一意性制約に取り組むときは、生成される系列値と競合する値を渡して上塗りしないようにご注意ください。

以下の例ではEメールが両方の利用者で同じになります。
Eメールが一意でなければならないとき、このコードはエラーになります。

```rb
factory :user do
  sequence(:email) { |n| "person#{n}@example.com" }
end

FactoryBot.create(:user, email: "person1@example.com")
FactoryBot.create(:user)
```


トレイト
----

### Defining traits

トレイトでは属性をグループに纏めて任意のファクトリに適用できます。

```ruby
factory :user, aliases: [:author]

factory :story do
  title { "My awesome story" }
  author

  trait :published do
    published { true }
  end

  trait :unpublished do
    published { false }
  end

  trait :week_long_publishing do
    start_at { 1.week.ago }
    end_at { Time.now }
  end

  trait :month_long_publishing do
    start_at { 1.month.ago }
    end_at { Time.now }
  end

  factory :week_long_published_story,    traits: [:published, :week_long_publishing]
  factory :month_long_published_story,   traits: [:published, :month_long_publishing]
  factory :week_long_unpublished_story,  traits: [:unpublished, :week_long_publishing]
  factory :month_long_unpublished_story, traits: [:unpublished, :month_long_publishing]
end
```

### 暗黙属性として

トレイトは暗黙属性として使えます。

```ruby
factory :week_long_published_story_with_title, parent: :story do
  published
  week_long_publishing
  title { "Publishing that was started at #{start_at}" }
end
```

なおトレイトを暗黙属性として定義すると、トレイトと同じ名前のファクトリや系列があるときに、うまくいかなくなります。

### 属性の優先度

Traits that define the same attributes won't raise
AttributeDefinitionErrors; the trait that defines the attribute latest gets
precedence.

```ruby
factory :user do
  name { "Friendly User" }
  login { name }

  trait :active do
    name { "John Doe" }
    status { :active }
    login { "#{name} (active)" }
  end

  trait :inactive do
    name { "Jane Doe" }
    status { :inactive }
    login { "#{name} (inactive)" }
  end

  trait :admin do
    admin { true }
    login { "admin-#{name}" }
  end

  factory :active_admin,   traits: [:active, :admin]   # loginは「admin-John Doe」になります。
  factory :inactive_admin, traits: [:admin, :inactive] # loginは「Jane Doe (inactive)」になります。
end
```

### 子のファクトリの内部

子のファクトリの内部でトレイトから与えられる個々の属性を上塗りできます。

```ruby
factory :user do
  name { "Friendly User" }
  login { name }

  trait :active do
    name { "John Doe" }
    status { :active }
    login { "#{name} (M)" }
  end

  factory :brandon do
    active
    name { "Brandon" }
  end
end
```

### ミックスインとして

Traits can be defined outside of factories and used as mixins to compose
shared attributes

```ruby
FactoryBot.define do
  trait :timestamps do
    created_at { 8.days.ago }
    updated_at { 4.days.ago }
  end

  factory :user, traits: [:timestamps] do
    username { "john_doe" }
  end

  factory :post do
    timestamps
    title { "Traits rock" }
  end
end
```

### トレイトを使う

Traits can also be passed in as a list of symbols when you construct an
instance from factory\_bot.

```ruby
factory :user do
  name { "Friendly User" }

  trait :active do
    name { "John Doe" }
    status { :active }
  end

  trait :admin do
    admin { true }
  end
end

# :active状態で名前が「Jon Snow」の管理者の利用者を作ります。
create(:user, :admin, :active, name: "Jon Snow")
```

この機能は`build`、`build_stubbed`、`attributes_for`、`create`で動きます。

`create_list` and `build_list` methods are supported as well. Just remember
to pass the number of instances to create/build as second parameter, as
documented in the "Building or Creating Multiple Records" section of this
file.

```ruby
factory :user do
  name { "Friendly User" }

  trait :admin do
    admin { true }
  end
end

# :active状態を持つ名前が「Jon Snow」の管理者の利用者を3人作ります。
create_list(:user, 3, :admin, :active, name: "Jon Snow")
```

### 関連付き

トレイトは関連とも簡単に使えます。

```ruby
factory :user do
  name { "Friendly User" }

  trait :admin do
    admin { true }
  end
end

factory :post do
  association :user, :admin, name: 'John Doe'
end

# 名前が「John Doe」の管理者の利用者を作ります。
create(:post).user
```

When you're using association names that're different than the factory:

```ruby
factory :user do
  name { "Friendly User" }

  trait :admin do
    admin { true }
  end
end

factory :post do
  association :author, :admin, factory: :user, name: 'John Doe'
  # もしくは以下です。
  association :author, factory: [:user, :admin], name: 'John Doe'
end

# 名前が「John Doe」の管理者の利用者を作ります。
create(:post).author
```

### トレイト内トレイト

トレイトは他のトレイト内で使い、属性を混ぜることができます。

```ruby
factory :order do
  trait :completed do
    completed_at { 3.days.ago }
  end

  trait :refunded do
    completed
    refunded_at { 1.day.ago }
  end
end
```

### 一過的属性付き

Finally, traits can accept transient attributes.

```ruby
factory :invoice do
  trait :with_amount do
    transient do
      amount { 1 }
    end

    after(:create) do |invoice, evaluator|
      create :line_item, invoice: invoice, amount: evaluator.amount
    end
  end
end

create :invoice, :with_amount, amount: 2
```

### 列挙トレイト

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

コールバック
------

### Default callbacks

factory\_bot makes available four callbacks for injecting some code:

* after(:build) はファクトリが構築された後に（`FactoryBot.build`と`FactoryBot.create`を介して）呼ばれます。
* before(:create) はファクトリが保存される前に（`FactoryBot.create`を介して）呼ばれます。
* after(:create) はファクトリが保存された後に（`FactoryBot.create`を介して）呼ばれます。
* after(:stub) はファクトリがスタブ化された後に（`FactoryBot.build_stubbed`を介して）呼ばれます。

例は以下です。

```ruby
# Define a factory that calls the generate_hashed_password method after it is built
factory :user do
  after(:build) { |user| generate_hashed_password(user) }
end
```

Note that you'll have an instance of the user in the block. This can be
useful.

### 複数コールバック

同じファクトリに複数の種類のコールバックを定義することもできます。

```ruby
factory :user do
  after(:build)  { |user| do_something_to(user) }
  after(:create) { |user| do_something_else_to(user) }
end
```

ファクトリは同じ種類のコールバックをいくらでも定義することもできます。
こうしたコールバックは指定された順番に実行されます。

```ruby
factory :user do
  after(:create) { this_runs_first }
  after(:create) { then_this }
end
```

`create`を呼ぶと`after_build`コールバックと`after_create`コールバックの両方ともが呼ばれます。

また標準的な属性と同様に、子のファクトリは親ファクトリからコールバックを受け継ぎます（また定義もできます）。

複数のコールバックはブロックを走らせて代入できます。
（全ての戦略を通じて共有されるコールバックはないため）同じコードを様々な戦略で構築するときに有用です。

```ruby
factory :user do
  callback(:after_stub, :before_create) { do_something }
  after(:stub, :create) { do_something_else }
  before(:create, :custom) { do_a_third_thing }
end
```

### 大域コールバック

全てのファクトリにコールバックを上塗りするには、`FactoryBot.define`ブロック内で定義します。

```ruby
FactoryBot.define do
  after(:build) { |object| puts "Built #{object}" }
  after(:create) { |object| AuditLog.create(attrs: object.attributes) }

  factory :user do
    name { "John Doe" }
  end
end
```

### Symbol#to_proc

`Symbol#to_proc`に頼るコールバックを呼べます。

```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  def confirm!
    # 利用者アカウントを確かめます。
  end
end

# spec/factories.rb
FactoryBot.define do
  factory :user do
    after :create, &:confirm!
  end
end

create(:user) # 利用者を作成して確かめます。
```

ファクトリの変更
--------

ファクトリ一式が与えられているものの（gemの開発者からとしましょう）、アプリケーションにもっと合うように代えたいとき、子ファクトリを作ってそこに属性を加える代わりに、ファクトリを変更できます。

gemが以下のようにUserファクトリを与えているとします。

```ruby
FactoryBot.define do
  factory :user do
    full_name { "John Doe" }
    sequence(:username) { |n| "user#{n}" }
    password { "password" }
  end
end
```

追加の属性を加える子ファクトリを作るとすると以下になります。

```ruby
FactoryBot.define do
  factory :application_user, parent: :user do
    full_name { "Jane Doe" }
    date_of_birth { 21.years.ago }
    health { 90 }
  end
end
```

その代わりとしてファクトリを変更できます。

```ruby
FactoryBot.modify do
  factory :user do
    full_name { "Jane Doe" }
    date_of_birth { 21.years.ago }
    health { 90 }
  end
end
```

ファクトリを変更するとき、どんな属性も（コールバックを除いて）お好みで代えられます。

`FactoryBot.modify`は`FactoryBot.define`の外側で呼ばなければなりません。
ファクトリを違った風に操作するからです。

A caveat: you can only modify factories (not sequences or traits) and
callbacks *still compound as they normally would*. So, if the factory you're
modifying defines an `after(:create)` callback, you defining an
`after(:create)` won't override it, it'll just get run after the first
callback.

複数のレコードの構築と作成
-------------

ファクトリの複数のインスタンスを一括で作成したり構築したりしたいときがあります。

```ruby
built_users   = build_list(:user, 25)
created_users = create_list(:user, 25)
```

These methods will build or create a specific amount of factories and return
them as an array.  To set the attributes for each of the factories, you can
pass in a hash as you normally would.

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

ファクトリのリント
---------

factory\_botは既知のファクトリをリントできます。

```ruby
FactoryBot.lint
```

`FactoryBot.lint`は各ファクトリを作って作成の仮定で投げられた例外を捕えます。
作成されなかったファクトリのリスト（と対応する例外）を持つ`FactoryBot::InvalidFactoryError`が投げられます。

Recommended usage of `FactoryBot.lint` is to run this in a task before your
test suite is executed.  Running it in a `before(:suite)`, will negatively
impact the performance of your tests when running single tests.

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

After calling `FactoryBot.lint`, you'll likely want to clear out the
database, as records will most likely be created. The provided example above
uses an sql transaction and rollback to leave the database clean.

リントしたいファクトリのみを選んで渡してファクトリをリントできます。

```ruby
factories_to_lint = FactoryBot.factories.reject do |factory|
  factory.name =~ /^old_/
end

FactoryBot.lint factories_to_lint
```

こうすると`old_`が接頭辞にない全てのファクトリがリントされます。

Traits can also be linted. This option verifies that each and every trait of
a factory generates a valid object on its own.  This is turned on by passing
`traits: true` to the `lint` method:

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

独自の構築
-----

factory\_botを使って、`initialize`に渡される属性があるオブジェクトを構築したいときや、クラスを構築する上で単に`new`を呼ぶ以上のことをしたいときは、ファクトリに`initialize_with`を定義して既定の挙動を上塗りできます。
例えば以下です。

```ruby
# user.rb
class User
  attr_accessor :name, :email

  def initialize(name)
    @name = name
  end
end

# factories.rb
sequence(:email) { |n| "person#{n}@example.com" }

factory :user do
  name { "Jane Doe" }
  email

  initialize_with { new(name) }
end

build(:user).name # Jane Doe
```

factory\_botはActiveRecordで飛び抜けて上手く書けるようになっていますが、どんなRubyクラスでも動作できます。
ActiveRecordと最大限の互換性があるよう、既定の初期化器はクラスを構築するのに実引数なしで`new`を読んで全てのインスタンスを構築します。
それから属性の書込みメソッドを呼んで全ての属性値を代入します。
ActiveRecordでは上手く動きますが、他のRubyのクラスのほとんどは実際にはうまくいきません。

以下の目的で初期化器を上塗りできます。

* `initialize`に実引数が必須の非ActiveRecordオブジェクトを構築する。
* `new`ではないメソッドを使ってインスタンスをインスタンス化する。
* 構築された後にインスタンスを修飾するような雑なことをする。

`initialize_with`を使うとき、`new`を呼ぶときにクラス自体を宣言する必要はありません。
しかし呼びたいその他のクラスメソッドは明示的にクラスに対して呼ばなければなりません。

例は以下です。

```ruby
factory :user do
  name { "John Doe" }

  initialize_with { User.build_with_name(name) }
end
```

`attributes`を呼んで`initialize_with`ブロック内で全ての公の属性を使うこともできます。

```ruby
factory :user do
  transient do
    comments_count { 5 }
  end

  name "John Doe"

  initialize_with { new(**attributes) }
end
```

こうすると`new`に渡される全ての属性のハッシュを構築します。
一過的属性は含まれませんが、ファクトリで定義されたその他全て（関連、評価された系列など）が渡されます。

`FactoryBot.define`ブロック内に含めると全てのファクトリに`initialize_with`を定義できます。

```ruby
FactoryBot.define do
  initialize_with { new("Awesome first argument") }
end
```

`initialize_with`を使うとき、`initialize_with`ブロック内で使う属性は構築子で*のみ*代入されます。
これは以下のコードと大まかに同じです。

```ruby
FactoryBot.define do
  factory :user do
    initialize_with { new(name) }

    name { 'value' }
  end
end

build(:user)
# ……とすると以下が走ります。
User.new('value')
```

これは重複する代入を防止しています。
4.0より前のfactory\_botでは以下が走っていました。

```ruby
FactoryBot.define do
  factory :user do
    initialize_with { new(name) }

    name { 'value' }
  end
end

build(:user)
# ……は以下が走ります。
user = User.new('value')
user.name = 'value'
```

独自の戦略
-----

独自の構築の戦略を加えてfactory\_botの挙動を拡張したいときがあります。

戦略は2つのメソッド`association`及び`result`を定義します。
`association`は`FactoryBot::FactoryRunner`インスタンスを受け取ります。
このインスタンスは`run`を呼んでお好みで戦略を上塗りできます。
2つ目のメソッド`result`は`FactoryBot::Evaluation`インスタンスを受け取ります。
コールバック、`object`、`hash`（結果のインスタンスやファクトリで定義された属性に基づくハッシュを得るためのもの）、`create`のきっかけとなる手段を（`notify`で）を提供します。
`create`はファクトリで定義された`to_create`コールバックを実行します。

To understand how factory\_bot uses strategies internally, it's probably
easiest to just view the source for each of the four default strategies.

以下は`FactoryBot::Strategy::Create`を使ってモデルにJSON表現を構築する戦略を組む例です。

```ruby
class JsonStrategy
  def initialize
    @strategy = FactoryBot.strategy_by_name(:create).new
  end

  delegate :association, to: :@strategy

  def result(evaluation)
    @strategy.result(evaluation).to_json
  end

  def to_sym
    :json
  end
end
```

factory\_botに新しい戦略を認識させるために、その戦略を登録できます。

```ruby
FactoryBot.register_strategy(:json, JsonStrategy)
```

こうして呼べるようになります。

```ruby
FactoryBot.json(:user)
```

最後に、戦略の代わりに新しいオブジェクトと登録することによってfactory\_bot独自の戦略を上塗りできます。

独自コールバック
--------

独自の戦略を使いたいとき、独自コールバックを定義できます。

```ruby
class JsonStrategy
  def initialize
    @strategy = FactoryBot.strategy_by_name(:create).new
  end

  delegate :association, to: :@strategy

  def result(evaluation)
    result = @strategy.result(evaluation)
    evaluation.notify(:before_json, result)

    result.to_json.tap do |json|
      evaluation.notify(:after_json, json)
      evaluation.notify(:make_json_awesome, json)
    end
  end

  def to_sym
    :json
  end
end

FactoryBot.register_strategy(:json, JsonStrategy)

FactoryBot.define do
  factory :user do
    before(:json)                { |user| do_something_to(user) }
    after(:json)                 { |user_json| do_something_to(user_json) }
    callback(:make_json_awesome) { |user_json| do_something_to(user_json) }
  end
end
```

オブジェクトを永続化するための独自メソッド
---------------------

既定で、レコードを作成するとインスタンスに`save!`を呼びます。
これは常に最適ではないことがあるため、ファクトリに`to_create`を定義して挙動を上塗りできます。

```ruby
factory :different_orm_model do
  to_create { |instance| instance.persist! }
end
```

作成で永続化のメソッドも一緒に無効化するには、ファクトリで`skip_create`することができます。

```ruby
factory :user_without_database do
  skip_create
end
```

全てのファクトリで`to_create`を上塗りするには`FactoryBot.define`ブロック内で定義します。

```ruby
FactoryBot.define do
  to_create { |instance| instance.persist! }


  factory :user do
    name { "John Doe" }
  end
end
```

ActiveSupportの計装
----------------

何のファクトリが作られたか（またどの構築戦略か）把握する目的で、コンパイルされて走るファクトリを購読する方法を提供するために`ActiveSupport::Notifications`がincludeされています。
一例としては実行時間の閾値に基づいてファクトリを把握することです。

```ruby
ActiveSupport::Notifications.subscribe("factory_bot.run_factory") do |name, start, finish, id, payload|
  execution_time_in_seconds = finish - start

  if execution_time_in_seconds >= 0.5
    $stderr.puts "Slow factory: #{payload[:name]} using strategy #{payload[:strategy]}"
  end
end
```

別の例としては全てのファクトリを対象にテストスートを通じてどのように使われたかを追跡するものです。
RSpecを使っているとき、`before(:suite)`と`after(:suite)`を加えるだけです。

```ruby
factory_bot_results = {}
config.before(:suite) do
  ActiveSupport::Notifications.subscribe("factory_bot.run_factory") do |name, start, finish, id, payload|
    factory_name = payload[:name]
    strategy_name = payload[:strategy]
    factory_bot_results[factory_name] ||= {}
    factory_bot_results[factory_name][strategy_name] ||= 0
    factory_bot_results[factory_name][strategy_name] += 1
  end
end

config.after(:suite) do
  puts factory_bot_results
end
```

別の例として、ファクトリが一緒にコンパイルされる属性とトレイトを追跡することが関係します。
RSpecを使っているとき、`before(:suite)`及び`after(:suite)`ブロックを加えて`factory_bot.compile_factory`の通知を購読できます。

```ruby
factory_bot_results = {}
config.before(:suite) do
  ActiveSupport::Notifications.subscribe("factory_bot.compile_factory") do |name, start, finish, id, payload|
    factory_name = payload[:name]
    factory_class = payload[:class]
    attributes = payload[:attributes]
    traits = payload[:traits]
    factory_bot_results[factory_class] ||= {}
    factory_bot_results[factory_class][factory_name] = {
      attributes: attributes.map(&:name)
      traits: traits.map(&:name)
    }
  end
end

config.after(:suite) do
  puts factory_bot_results
end
```

Railsの事前読込器とRSpec
-----------------

RSpecを`spring`や`zeus`といったRailsの事前読込器付きで走らせるとき、関連付きのファクトリを作るときに`ActiveRecord::AssociationTypeMismatch`エラーに遭うかもしれません。
以下のような感じです。

```ruby
FactoryBot.define do
  factory :united_states, class: "Location" do
    name { 'United States' }
    association :location_group, factory: :north_america
  end

  factory :north_america, class: "LocationGroup" do
    name { 'North America' }
  end
end
```

エラーはテストスートを走らせるときに起こります。

```
Failure/Error: united_states = create(:united_states)
ActiveRecord::AssociationTypeMismatch:
  LocationGroup(#70251250797320) expected, got LocationGroup(#70251200725840)
```

2つの解決策が考えられます。
1つはテストスートを事前読込器無しで走らせることです。
もう1つはRSpecの構成に`FactoryBot.reload`を追加することです。
以下のような感じです。

```ruby
RSpec.configure do |config|
  config.before(:suite) { FactoryBot.reload }
end
```

Bundler無しで使う
------------

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
