# association

ファクトリブロック内では、`association`を使うと常にこのオブジェクトに連なる追加のオブジェクトが作られます。
この名前はActiveRecordの文脈で一番意味が通ります。

`association`メソッドは必須の名前と省略できるオプションを取ります。

オプションは0個以上のトレイト名 (Symbol) とそれに続く属性の上塗りのハッシュです。
この関連を構築するとき、factory\_botはトレイトと与えられた属性の上塗りを使います。

早道については[method_missing](method_missing.html)を参照してください。
各構築戦略の関連の扱いについての説明は[構築戦略](build-strategies.html)を参照してください。
