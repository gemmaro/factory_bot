# 暗黙属性として

もしくは暗黙属性として以下とします。

```ruby
FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

factory :user do
  email # `email { generate(:email) }`と同じです。
end
```

なお系列を暗黙属性として定義すると、ファクトリに系列として同じ名前があるときにうまくいかなくなります。
