call sp_item_by_categorySub('Sofa');
call sp_check_availability('1');
call display_product_all('1');
call display_userInfo('superuser@inserted.com');
call update_userInfo('superuser@inserted.com', 97984038, 'Blk 51C Olympia Square #01-01', 111051);
call display_bookmark_user('tpu@inserted.com');
call add_bookmark(1,'superuser@inserted.com', 1);
call add_order('superuser@inserted.com'], now(), 'Mr Aaron Seah', 'BLK 123 NUS SOC #07-11', 999123, 93921111,"Packing", "100", DATE_ADD(now(), INTERVAL 3 DAY), "call upon arrival", 3,'Aaron Seah', '1548', 1, DATE_ADD(CURDATE(), INTERVAL 7 DAY));
call add_order_detail(1,3,2);