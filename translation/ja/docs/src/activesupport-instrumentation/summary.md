# ActiveSupportの計装

何のファクトリが作られたか（またどの構築戦略か）把握する目的で、コンパイルされて走るファクトリを購読する方法を提供するために`ActiveSupport::Notifications`がincludeされています。
一例としては実行時間の閾値に基づいてファクトリを把握することです。

```ruby
ActiveSupport::Notifications.subscribe("factory_bot.run_factory") do |name, start, finish, id, payload|
  execution_time_in_seconds = finish - start

  if execution_time_in_seconds >= 0.5
    $stderr.puts "Slow factory: #{payload[:name]} using strategy #{payload[:strategy]}"
  end
end
```

別の例としては全てのファクトリを対象にテストスートを通じてどのように使われたかを追跡するものです。
RSpecを使っているとき、`before(:suite)`と`after(:suite)`を加えるだけです。

```ruby
factory_bot_results = {}
config.before(:suite) do
  ActiveSupport::Notifications.subscribe("factory_bot.run_factory") do |name, start, finish, id, payload|
    factory_name = payload[:name]
    strategy_name = payload[:strategy]
    factory_bot_results[factory_name] ||= {}
    factory_bot_results[factory_name][strategy_name] ||= 0
    factory_bot_results[factory_name][strategy_name] += 1
  end
end

config.after(:suite) do
  puts factory_bot_results
end
```

別の例として、ファクトリが一緒にコンパイルされる属性とトレイトを追跡することが関係します。
RSpecを使っているとき、`before(:suite)`及び`after(:suite)`ブロックを加えて`factory_bot.compile_factory`の通知を購読できます。

```ruby
factory_bot_results = {}
config.before(:suite) do
  ActiveSupport::Notifications.subscribe("factory_bot.compile_factory") do |name, start, finish, id, payload|
    factory_name = payload[:name]
    factory_class = payload[:class]
    attributes = payload[:attributes]
    traits = payload[:traits]
    factory_bot_results[factory_class] ||= {}
    factory_bot_results[factory_class][factory_name] = {
      attributes: attributes.map(&:name)
      traits: traits.map(&:name)
    }
  end
end

config.after(:suite) do
  puts factory_bot_results
end
```
