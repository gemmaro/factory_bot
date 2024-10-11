# transient

`factory`定義ブロック内では、クラスのインスタンスを構築することが目標です。
factory\_botはこれをするものですが、文脈でのデータの記録をつけています。
データをこの文脈に設定するには`transient`ブロックを使います。

`transient`ブロックは`factory`定義ブロックのように扱います。
しかし設定した属性、関連、トレイト、系列は最終的なオブジェクトに影響しません。

これは[フック](hooks.html)や[to_create](build-and-create.html)との取り合わせで一番有用です。
