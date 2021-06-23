<?php

$header = ["店舗ID", "店舗名", "グループ名"];
$data = [
    ["173", "テスト店舗1", "テストグループ1"],
    ["1", "テスト店舗2", "テストグループ2"],
    ["12", "テスト店舗3", "テストグループ3"],
    ["123", "テスト店舗4", "テストグループ4"],
];

$f = fopen("csv/test.csv", "w");
echo "--- start ---\n";

if ($f) {
    fputcsv($f, $header);

    foreach($data as $line){
        fputcsv($f, $line);
    } 
}

echo "--- end ---\n";
fclose($f);
