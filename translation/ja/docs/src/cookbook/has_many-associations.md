# has_many関連

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

    # user_with_postsは利用者が作成された後に記事データを作ります。
    factory :user_with_posts do
      # posts_countは文脈を介してコールバックで使える一過的属性として宣言されています。
      transient do
        posts_count { 5 }
      end

      # after(:create) は利用者インスタンス自体と文脈の2つの値を譲渡します。
      # この文脈には、一過的属性を含むファクトリ由来の全ての値が保管されています。
      # `create_list`の2つ目の実引数は作成されるレコードの数であり、利用者が適切に記事に紐付いていることを確かめています。
      after(:create) do |user, context|
        create_list(:post, context.posts_count, user: user)

        # ここでレコードを再読込する必要があるかもしれません。
        # アプリケーションに依ります。
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
