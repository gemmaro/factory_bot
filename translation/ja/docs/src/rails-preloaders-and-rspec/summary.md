# Railsの事前読込器とRSpec

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

エラーは、テストスートを走らせるときに起こります。

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
