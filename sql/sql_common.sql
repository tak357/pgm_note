-- 2020/10/01 cron

// 1:まず時間で絞る
$group_stamps = $this->db->fetchall("
  SELECT * FROM group_stamps
  WHERE grant_hour = ?
  AND not_add = 0",
  DATE("G")
);

foreach($group_stamps as $group_stamp) {

  $date = $today - strtotime("-" . $group_stamp['grant_day'] . "day");

  // 2:次に日にちで絞る
  $shop_id_user_ids = $this->db->fetchall("
    SELECT shop_id, user_id FROM reserves AS r
    JOIN groups AS g ON r.group_id = g.id
    WHERE date = ?
    AND option_stamp = 1",
    $date
  );

  foreach ($shop_id_user_ids as $shop_id_user_id) {
    // 3:group_stamp_usersにレコードが存在するか確認
    $group_stamp_users = $this->db->fetchall("
      SELECT id FROM group_stamp_users AS gsu
      WHERE shop_id = ?
      AND user_id = ?",
      array($shop_id_user_id['shop_id'], $shop_id_user_id['user_id'])
    );

    // 4:group_stamp_usersテーブルの更新
    foreach ($group_stamp_users as $group_stamp_user) {
      // idが存在したらupdate、なかったらinsert
      if($group_stamp_user['id']) {
        // update
      } else {
        // insert
      }
    }
  }
}

-- 2020/10/01
SELECT
    gs.id, gs.name, gs.coupon_name, COUNT(gss.shop_id) AS cnt
FROM
    group_stamps gs
LEFT JOIN
    group_stamp_shops gss
ON
    gs.id = gss.group_stamp_id
AND
    gs.group_id = gss.group_id
GROUP BY
    gs.id

-- 2020/09/29
-- 一回大きく取得する
SELECT r.date, r.user_id, r.shop_id, gss.group_stamp_id, g.option_stamp, gs.grant_day, gs.grant_hour, gs.not_add, gs.max_count, gs.max_count_flag FROM reserves AS r
JOIN group_stamp_shops AS gss ON r.shop_id = gss.shop_id
JOIN groups AS g ON gss.group_id = g.id
JOIN group_stamps AS gs ON gss.group_stamp_id = gs.id
JOIN group_stamp_users AS gsu ON r.user_id = gsu.user_id
WHERE g.option_stamp = 1

-- 2020/09/29
SELECT
    gs.id,
    gs.group_id,
    gs.grant_day,
    gs.grant_hour,
    gs.not_add,
    gs.max_count,
    gs.max_count_flag
FROM
    group_stamps AS gs
JOIN
    groups AS g
ON
    gs.group_id = g.id
WHERE
    g.option_stamp = 1
AND
    gs.not_add = 0


-- 2020/09/22
-- 0件表示する方法（左外部結合とCOALESCEを使って処理）
-- 書き直し版

SELECT
    id,
    name,
    coupon_name,
    COALESCE(a._cnt, 0) AS cnt
FROM
    group_stamps AS gs
LEFT JOIN (
    SELECT
        group_stamp_id,
        count(group_stamp_id) AS _cnt
    FROM
        group_stamp_shops
    GROUP BY group_stamp_id
) AS a
ON
    gs.id = a.group_stamp_id
WHERE
    group_id = 100;

-- xxxに開始したいIDを入力
ALTER TABLE `apps` auto_increment = xxx;

-- トークンとかapp_idとかapp_key抜き出すSQL
SELECT users.login_id, users.android_message_id, users.iphone_message_id, users.group_id, shops.app_id, apps.name, apps.app_key
FROM users
JOIN shops
ON users.group_id = shops.group_id
JOIN apps
ON shops.app_id = apps.id
where login_id = 'demo@demo.demo'
limit 30;
