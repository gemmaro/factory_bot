# 一意性

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
