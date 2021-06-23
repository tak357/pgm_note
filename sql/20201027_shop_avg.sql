-- status=0（非キャンセル）

SELECT route, site_id, 
CASE
  WHEN site_id = 20 THEN SUM(price)
  ELSE SUM(total_price)
END AS prices
FROM sql_tests.reserves
WHERE status = 0
GROUP BY route, site_id;
