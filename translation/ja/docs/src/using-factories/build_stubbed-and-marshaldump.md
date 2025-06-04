# build_stubbedとMarshal.dump

なお`build_stubbed`で作られたオブジェクトは`Marshal.dump`で直列化できません。
factory\_botはこれらのオブジェクトに特異メソッドを定義するからです。
