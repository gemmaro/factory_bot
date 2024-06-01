# 属性の上塗り

使われた戦略に依らず、ハッシュを渡して定義された属性を上塗りできます。

```ruby
# Userインスタンスを構築しfirst_name特性を上塗りします
user = build(:user, first_name: "Joe")
user.first_name
# => "Joe"
```

Ruby 3.1の`Hash`表記での[バリューの省略][omitting
values]対応は属性の上塗りにぴったり馴染む機能で、変数名の繰り返しになるところを削減できます。

```ruby
first_name = "Joe"

# Userインスタンスを構築しfirst_name特性を上塗りします
user = build(:user, first_name:)
user.first_name
# => "Joe"
```

[omitting values]: https://docs.ruby-lang.org/en/3.1/syntax/literals_rdoc.html#label-Hash+Literals
