# コールバック

factory\_botでは、6種類のコールバックを作れます。

| コールバック        | 時機                                                                                                                    |
| --------------- | ------------------------------------------------------------------------------------------------------------------------- |
| before(:all)    | ファクトリがオブジェクトを構築する前に（`FactoryBot.build`や`FactoryBot.create`や`FactoryBot.build_stubbed`を介して）呼ばれます |
| after(:build)   | ファクトリがオブジェクトを構築した後に（`FactoryBot.build`や`FactoryBot.create`を介して）呼ばれます                                   |
| before(:create) | ファクトリがオブジェクトを保存する前に（`FactoryBot.create`を介して）呼ばれます                                                         |
| after(:create)  | ファクトリがオブジェクトを保存した後に（`FactoryBot.create`を介して）呼ばれます                                                          |
| after(:stub)    | ファクトリがオブジェクトをスタブした後に（`FactoryBot.build_stubbed`を介して）呼ばれます                                                   |
| after(:all)     | ファクトリがオブジェクトを構築した後に（`FactoryBot.build`や`FactoryBot.create`や`FactoryBot.build_stubbed`を介して）呼ばれます  |


## 例

### 構築後にオブジェクト自体のメソッドを呼ぶ

```ruby
##
# 利用者ファクトリが構築された後にgenerate_hashed_password
# メソッドを呼ぶファクトリを定義します。
#
# なお、ブロックにはオブジェクトのインスタンスがあります。
#
factory :user do
  after(:build) { |user, context| generate_hashed_password(user) }
end
```

### オブジェクト自体の :after_create コールバックを飛ばす

```ruby
##
# モデル自体の :after_create コールバックを無効にします。
# このコールバックは作成時にEメールを送るものです。
# それから作成後に再び有効にします。
#
factory :user do
  before(:all){ User.skip_callback(:create, :after, :send_welcome_email) }
  after(:all){ User.set_callback(:create, :after, :send_welcome_email) }
end
```