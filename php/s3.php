<?php
require '../vendor/autoload.php';
use Aws\S3\S3Client;
use Aws\Credentials\CredentialProvider;

function main() {
    // $ini = './credentials.ini';
    // $iniProvider = CredentialProvider::ini('default', $ini);
    // $iniProvider = CredentialProvider::memoize($iniProvider);
    //認証情報
    $s3 = new S3Client([
        // 'credentials' => $iniProvider,
        'credentials' => [
            'key'    => 'XXX',
            'secret' => 'XXX',
        ],
        'version' => '2006-03-01',
        'region'  => 'us-east-1'
    ]);
    $command = $s3->getCommand('GetObject', array(
        'Bucket' => 'take4packet',
        'Key' => 'a.txt',
    ));
    // 有効期限設定
    $request = $s3->createPresignedRequest($command, '+10 minutes');

    //URL取得
    $url = (string)$request->getUri();
    // ウェブブラウザが独自にMIMEタイプを判断する処理を抑止する
    header('X-Content-Type-Options: nosniff');

    // ダウンロードするべきファイル情報を先に取得して、その内容をそのまま設定
    $filename = 'a.txt';
    $headers = get_headers($url, 1);
    header('Content-Type: ').$headers['Content-Type'];
    header('Content-Length: '.$headers['Content-Length']);
    header("Content-Disposition: attachment; filename=${filename}");

    // readfile()の前に出力バッファリングを無効化する
    // while (ob_get_level()) {
    //     ob_end_clean();
    // }
    // ダウンロード
    readfile($url);
    exit;
}

main();
