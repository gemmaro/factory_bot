# コールバック

factory\_botでは、6種類のコールバックを作れます。

| コールバック        | 時機                                                                                                                    |
| --------------- | ------------------------------------------------------------------------------------------------------------------------- |
| before(:all)    | 独自の戦略を含めて、どの戦略がオブジェクトの構築に使われたときも、その前に呼ばれます |
| before(:build)  | ファクトリが（`FactoryBot.build`や`FactoryBot.create`で）オブジェクトを構築する前に呼ばれます                                  |
| after(:build)   | ファクトリが（`FactoryBot.build`や`FactoryBot.create`で）オブジェクトを構築した後に呼ばれます                                   |
| before(:create) | ファクトリが（`FactoryBot.create`で）オブジェクトを保存する前に呼ばれます                                                         |
| after(:create)  | ファクトリが（`FactoryBot.create`で）オブジェクトを保存した後に呼ばれます                                                          |
| after(:stub)    | ファクトリが（`FactoryBot.build_stubbed`で）オブジェクトをスタブした後に呼ばれます                                                   |
| after(:all)     | 独自の戦略を含めて、どの戦略が完了したときも、その後に呼ばれます  |


## 例

### 構築後にオブジェクト自体のメソッドを呼ぶ

```ruby
##
# 利用者ファクトリが構築された後に generate_hashed_password
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
