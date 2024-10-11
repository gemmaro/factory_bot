# Symbol#to_proc

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
