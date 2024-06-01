# FactoryBot.define

factory\_botで読み込まれる各ファイルはブロック付きの`FactoryBot.define`で呼ばれることになります。
ブロックは`FactoryBot::Syntax::Default::DSL`のインスタンス内で評価され、`factory`や`sequence`や`trait`など他のメソッドを利用できます。
