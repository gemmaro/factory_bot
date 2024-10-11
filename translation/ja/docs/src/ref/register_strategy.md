# FactoryBot.register_strategy

`FactoryBot.register_strategy`メソッドは[構築戦略](build-strategies.html)の加え方です。

2つの必須の実引数である名前とクラスを取ります。
名前はSymbolで、`FactoryBot::Syntax::Methods`下に現すメソッドを登録します。

クラスはメソッド`association`と`result`を定義しなければなりません。

`association`メソッドは`FactoryRunner`のインスタンスを取ります。
このランナーを`#run`で走らせられます。
このとき戦略名（既定は現在のもの）と省略できるブロックを渡します。
ブロックは関連が構築された後に呼ばれ、構築されたオブジェクトが渡されます。

`result`メソッドは（`initialize_with`を使って）このファクトリで構築されたオブジェクトを取り、この構築戦略用のファクトリの結果を返します。
