# idを1から振り直す
SET @i := 0;
UPDATE stock_prices SET id = (@i := @i +1);

# ログインせずにコマンドを実行する（-e オプション）
mysql -u root -e "show databases"

# データベースtestをuseしてクエリを実行
mysql -u root test -e "SELECT * FROM students"

# データベースtestをuseしてクエリを実行し、結果をテキストファイルに出力
mysql -u root test -e "SELECT * FROM students" > result.txt
mysql -u root test -e "SELECT * FROM students" > result.tsv

