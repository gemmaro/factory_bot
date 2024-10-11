# 多相関連

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
