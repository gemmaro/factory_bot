# メソッド名と予約語の属性

属性が既存のメソッドや予約語（[DefinitionProxy](https://github.com/thoughtbot/factory_bot/blob/main/lib/factory_bot/definition_proxy.rb)内の全メソッド）と競合するとき、`add_attribute`で定義できます。

```ruby
factory :dna do
  add_attribute(:sequence) { 'GATTACA' }
end

factory :payment do
  add_attribute(:method) { 'paypal' }
end
```
