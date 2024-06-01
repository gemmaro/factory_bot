# 暗黙属性として

トレイトは暗黙属性として使えます。

```ruby
factory :week_long_published_story_with_title, parent: :story do
  published
  week_long_publishing
  title { "Publishing that was started at #{start_at}" }
end
```

なおトレイトを暗黙属性として定義すると、トレイトと同じ名前のファクトリや系列があるときに、うまくいかなくなります。
