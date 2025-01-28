# 系列

factory\_botは2つの水準の系列に対応しています。
大域的なものとファクトリ固有のものです。

## 大域系列

[`Factory.define`]ブロックでは、`sequence`メソッドを使うと、他のファクトリで共有できる大域系列が定義されます。

[`Factory.define`]: define.html

`sequence`メソッドは、名前、省略できる実引数、ブロックを取ります。
名前はSymbolにすることになっています。

対応する実引数は、開始の値を表す数値（既定で`1`）と`:aliases`（既定で`[]`）です。
開始の値は`#next`に応答しなければなりません。

ブロックは値を実引数として取り、結果を返します。

系列の値は大域的に増加します。
複数の場所で`:email_address`系列を使うと、都度値が漸増します。

早道については[method_missing](method_missing.html)を参照してください。

## ファクトリ系列

系列はファクトリブロック内に留めておけます。
構文は大域系列と同じですが、漸増する値のスコープはファクトリ定義に限られます。

加えて`factory`ブロックで`sequence`を使うと、暗黙にその値に`add_attribute`を呼びます。

以下の2つは似ていますが、2つ目の例は大域系列が存在しません。

```ruby
# 大域系列
sequence(:user_factory_email) { |n| "person#{n}@example.com" }

factory :user do
  # 大域系列を使う
  email { generate(:user_factory_email) }
end
```

```ruby
# ファクトリのスコープの系列
factory :user do
  sequence(:email) { |n| "person#{n}@example.com" }
end
```
