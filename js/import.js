<script>
  function test1() {
    if (confirm('顧客インポートを開始しますか？')) {
      alert("顧客インポートを開始しました。\nインポートログは操作メッセージログに出力されます。");
      console.log($('#subject').val());
      var subject = $('#subject').val();
      $('input[type="text"]').val("");

      $.ajax({
        url: "http://localhost:3001/test.php",
        type: "POST",
        data: {
          "id": 123,
          "subject": subject,
        },
        dataType: "json"
      });
    }
  }

</script>

<form id="myform">
  <button type="button" onclick="test1()">顧客インポートボタン</button>
</form>


<?php

exec('rm tr50*.txt > /dev/null &');
sleep(5);

exec("touch tr50_{$_POST["subject"]}.txt > /dev/null &");

$date = date('YmdHis');
exec("touch tr50_{$date}.txt > /dev/null &");
sleep(5);

$date = date('YmdHis');
exec("touch tr50_{$date}.txt > /dev/null &");
