-- shop_idも出力
SELECT r1.user_id, r1.shop_id, r2.shop_id, u.name_sei, u.name_mei, u.name_kn_sei, u.name_kn_mei
FROM (SELECT user_id, shop_id FROM sql_tests.reserves WHERE shop_id IN (173)) r1
JOIN (SELECT user_id, shop_id FROM sql_tests.reserves WHERE shop_id IN (1000, 2000, 4000)) r2 ON r1.user_id = r2.user_id
JOIN sql_tests.users u ON r1.user_id = u.id;
                                                                        
-- simple                                                                        
SELECT r1.user_id, u.name_sei, u.name_mei 
FROM (SELECT user_id FROM sql_tests.reserves WHERE shop_id IN (173)) r1
JOIN (SELECT user_id FROM sql_tests.reserves WHERE shop_id IN (1000, 2000, 4000)) r2 ON r1.user_id = r2.user_id
JOIN sql_tests.users u ON r1.user_id = u.id;
