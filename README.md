これらのシェルスクリプトについて
====

[install.sh](install.sh)
----
シェルスクリプトのインストーラ。<br>
引数にインストールするシェルスクリプトを指定すること。

[colorlist.sh](colorlist.sh)
----
文字色と背景色の一覧を出力する。

[cut_date.sh](cut_date.sh)
----
ファイルの作成日を出力する。

[table_op.sh](table_op.sh)
----
データファイルを加工する。<br>
gnuplotなどのデータファイルを弄る際に用いることを想定。<br>
詳しくは'-help'オプションを参照。

[touch\_type\_practice.sh](touch_type_practice.sh)
[touch\_type\_practice\_left.sh](touch_type_practice_left.sh)
[touch\_type\_practice\_right.sh](touch_type_practice_right.sh)
[touch\_type\_practice\_signiture.sh](touch_type_practice_signiture.sh)
[touch\_type\_practice\_textfile.sh](touch_type_practice_textfile.sh)
----
タッチタイプの練習用<br>
あくまで文字の配置を記憶することが目的であるため、単語ではなく文字単体が出現する<br>
小文字アルファベット＋数字＋記号一文字がランダム出現<br>
正当はスコア+1、ミスはスコア-5<br>
適当なスコアで満足したら終了すること<br>
