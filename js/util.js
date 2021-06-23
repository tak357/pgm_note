'use stirct'

/**
 * 一括バリデーション
 * @param data
 *  [0] {
 *  'name':   名前                          ex) '指名料'
 *  'type':   チェックしたい型              ex) 'num'
 *  'value':  チェックしたい値              ex) 123
 *  'msg':    アラート文言（オプション）    ex) '指名料を数字で入力してください
 *  ※msgが設定されていたらその文言が優先的に出力される
 *  }
 *  [1] {…}
 * @return boolean
 */
function checkInput(data) {
  let flag = true;

  $(data).each(function(i, val){
    if (val.type == 'empty') {
      if (val.value == '') {
        flag = false;
        alert(val.msg || val.name + "を入力してください");
        return false;
      }
    } else if (val.type == 'num') {
      if (!val.value.match(/[0-9]/)) {
        flag = false;
        alert(val.msg || val.name + "を数字で入力してください");
        return false;
      }
    } else if (val.type == 'kana') {
      // 全角カタカナと全角スペース（文中のみ）を許容
      if (!val.value.match(/^[\u30A0-\u30FF][\u30A0-\u30FF\u3000]*$/)) {
        flag = false;
        alert(val.msg || val.name + "を全角カタカナで入力してください");
        return false;
      }
    } else if (val.type == 'date') {
      if (!isValidDate(val.value)) {
        flag = false;
        alert(val.msg || val.name + "を正しい日付で入力してください");
        return false;
      }
    }
  });

  return flag;
}

/**
 * 日付形式のチェック
 * @param datestr ex)'2021-12-31'
 * @return boolean
 */
function isValidDate(datestr) {
  if (!datestr.match(/^\d{4}-\d{2}-\d{2}$/)) {
    return false;
  }
  // 値のチェック
  const y = datestr.substr(0, 4);
  const m = datestr.substr(5, 2) - 1;
  const d = datestr.substr(8, 2);
  const dt = new Date(y, m, d);
  if (dt.getFullYear() != y || dt.getMonth() != m || dt.getDate() != d) {
    return false;
  }
  return true;
}

/**
 * 二度押し防止機能
 * submitボタンにclass:no2clickを追加する
 */
let click_flag = false;
$(function() {
  $('no2click').on('click', function() {
    if (click_flag == true) {
      return false;
    }
    click_flag = true;
  });
});
