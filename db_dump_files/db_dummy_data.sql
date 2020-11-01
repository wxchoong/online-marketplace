--          Dummy Data Generation       --

INSERT INTO `category` VALUES 
(1,'Living Room','Sofa'),
(2,'Living Room','Carpets-and-Rugs'),
(3,'Living Room','Coffee-Table'),
(4,'Living Room','TV-Consoles'),
(5,'Living Room','Arm-Chairs'),
(6,'Bedroom','Bedsets'),
(7,'Bedroom','Night-Stands'),
(8,'Bedroom','Bed-Frames'),
(9,'Bedroom','Mattresses'),
(10,'Bathroom','Bath-Towels'),
(11,'Bathroom','Rugs'),
(12,'Bathroom','Accessories'),
(13,'Dining Room','Dining-Table'),
(14,'Dining Room','Chairs'),
(15,'Dining Room','Plates'),
(16,'Dining Room','Wine-Glasses'),
(17,'Dining Room','Candles'),
(18,'Dining Room','Cutlery'),
(19,'Home Decor','Blinds-and-Curtains'),
(20,'Home Decor','Lights-and-Lamps'),
(21,'Home Decor','Wall-Arts'),
(22,'Home Decor','Mirrors'),
(23,'Home Decor','Cushions-and-Throws'),
(24,'Home Decor','Scent-Products');


INSERT INTO user_info VALUES ('superuser@inserted.com' , 97984038, 'super@123', 'Super', 'User', 'Blk 51C Olympia Square #01-01', '111051', now(), now(), 1);
INSERT INTO user_info VALUES ('JohnDoe@inserted.com' , 90885878, 'JohnDoe123', 'John', 'Doe', 'Blk 32C Jigsaw Ave #07-03', '579032', now()+1, now()+1,0);
INSERT INTO user_info VALUES ('JMary@inserted.com' , 93225231, 'mary01jane', 'Mary', 'Jane', 'Blk 655 Jigsaw Ave #05-02', '579655', now()+2, now()+2,0);
INSERT INTO user_info VALUES ('ZhouJL@inserted.com' , 98775903, 'Jielun@21', 'Jie Lun', 'Zhou', 'Blk 621 Hollywood Ave #22-11', '385621', now()+3, now()+3,0);
INSERT INTO user_info VALUES ('augustine@inserted.com' , 96524788, 'augusth1ng', 'Augustine', 'Seah', 'Blk 638 Hollywood Ave #17-53', '385638', now()+4, now()+4,0);
INSERT INTO user_info VALUES ('sebestian@inserted.com' , 93397071, 'seabass1an', 'Sebestian', 'Au', 'Blk 800 Casear Palace Garden #33-42', '355800', now()+5, now()+5,0);
INSERT INTO user_info VALUES ('tpu@inserted.com' , 82317582, 'tpu@123', 'tian', 'pu', 'Blk 139A Lorong 1A #19-88', '313139', now(), now(), 0);
INSERT INTO user_info VALUES ('ling@inserted.com' , 95631821, 'lingang123', 'gang', 'lin', 'Blk 13 Toh Yi Drive #04-12', '590013', now()+4, now()+3, 0);
INSERT INTO user_info VALUES ('cwx@inserted.com' , 23211523, 'ch12wx', 'Wen', 'Xian', '672 Woodlands Drive 71 #21-11', '730672', now()+3, now()+2,0);
INSERT INTO user_info VALUES ('yangzj@inserted.com' , 90479123, 'yzj@21', 'zijun', 'yang', '316A Ang Mo Kio Street 31 #15-32', '562316', now()+1, now()+2,0);
INSERT INTO user_info VALUES ('fengjy@inserted.com' , 96524788, 'jiayi123', 'jiayi', 'feng', '182 Jln Jurong Kechil #17-53', '596145', now()+4, now()+4,0);
INSERT INTO user_info VALUES ('mystery@inserted.com' , 93397071, 'mystery', 'mystery', 'mr', 'NullSpace in LinearAlgebra', '100000', now()+5, now()+5,0);



INSERT INTO product_info VALUES(NULL,1,'sofa_1','Description_1',55,now(),6.18,20,NULL,1);
INSERT INTO product_info VALUES(NULL,1,'sofa_2','Description_2',35,now(),63.78,20,NULL,1);
INSERT INTO product_info VALUES(NULL,1,'sofa_3','Description_3',44,now(),5.32,20,NULL,1);
INSERT INTO product_info VALUES(NULL,1,'sofa_4','Description_4',50,now(),94.53,20,NULL,1);
INSERT INTO product_info VALUES(NULL,1,'sofa_5','Description_5',9,now(),37.74,20,NULL,1);
INSERT INTO product_info VALUES(NULL,1,'sofa_6','Description_6',26,now(),52.40,20,NULL,1);
INSERT INTO product_info VALUES(NULL,1,'sofa_7','Description_7',6,now(),42.6,20,NULL,1);
INSERT INTO product_info VALUES(NULL,1,'sofa_8','Description_8',94,now(),33.66,20,NULL,1);
INSERT INTO product_info VALUES(NULL,1,'sofa_9','Description_9',19,now(),41.25,20,NULL,1);
INSERT INTO product_info VALUES(NULL,1,'sofa_10','Description_10',78,now(),43.19,20,NULL,1);
INSERT INTO product_info VALUES(NULL,2,'carpet_11','Description_11',44,now(),11.36,20,NULL,1);
INSERT INTO product_info VALUES(NULL,2,'carpet_12','Description_12',80,now(),16.73,20,NULL,1);
INSERT INTO product_info VALUES(NULL,2,'carpet_13','Description_13',38,now(),90.38,20,NULL,1);
INSERT INTO product_info VALUES(NULL,2,'rug_14','Description_14',93,now(),29.61,20,NULL,1);
INSERT INTO product_info VALUES(NULL,2,'rug_15','Description_15',42,now(),8.43,20,NULL,1);
INSERT INTO product_info VALUES(NULL,3,'coffee_table_16','Description_16',88,now(),36.64,20,NULL,1);
INSERT INTO product_info VALUES(NULL,3,'coffee_table_17','Description_17',33,now(),30.5,20,NULL,1);
INSERT INTO product_info VALUES(NULL,3,'coffee_table_18','Description_18',72,now(),76.66,20,NULL,1);
INSERT INTO product_info VALUES(NULL,3,'coffee_table_19','Description_19',59,now(),86.82,20,NULL,1);
INSERT INTO product_info VALUES(NULL,3,'coffee_table_20','Description_20',9,now(),70.13,20,NULL,1);
INSERT INTO product_info VALUES(NULL,3,'coffee_table_21','Description_21',74,now(),80.75,20,NULL,1);
INSERT INTO product_info VALUES(NULL,4,'tv_console_22','Description_22',3,now(),95.27,20,NULL,1);
INSERT INTO product_info VALUES(NULL,4,'tv_console_23','Description_23',58,now(),81.53,20,NULL,1);
INSERT INTO product_info VALUES(NULL,4,'tv_console_24','Description_24',95,now(),25.41,20,NULL,1);
INSERT INTO product_info VALUES(NULL,4,'tv_console_25','Description_25',25,now(),99.85,20,NULL,1);
INSERT INTO product_info VALUES(NULL,4,'tv_console_26','Description_26',37,now(),20.72,20,NULL,1);
INSERT INTO product_info VALUES(NULL,4,'tv_console_27','Description_27',32,now(),23.70,20,NULL,1);
INSERT INTO product_info VALUES(NULL,5,'arm_chairs_28','Description_28',13,now(),67.9,20,NULL,1);
INSERT INTO product_info VALUES(NULL,5,'arm_chairs_29','Description_29',11,now(),84.26,20,NULL,1);
INSERT INTO product_info VALUES(NULL,5,'arm_chairs_30','Description_30',50,now(),96.84,20,NULL,1);
INSERT INTO product_info VALUES(NULL,5,'arm_chairs_31','Description_31',27,now(),93.44,20,NULL,1);
INSERT INTO product_info VALUES(NULL,5,'arm_chairs_32','Description_32',75,now(),34.56,20,NULL,1);
INSERT INTO product_info VALUES(NULL,6,'bedsets_33','Description_33',13,now(),51.34,20,NULL,1);
INSERT INTO product_info VALUES(NULL,6,'bedsets_34','Description_34',81,now(),16.88,20,NULL,1);
INSERT INTO product_info VALUES(NULL,6,'bedsets_35','Description_35',27,now(),45.79,20,NULL,1);
INSERT INTO product_info VALUES(NULL,6,'bedsets_36','Description_36',85,now(),97.58,20,NULL,1);
INSERT INTO product_info VALUES(NULL,6,'bedsets_37','Description_37',24,now(),73.17,20,NULL,1);
INSERT INTO product_info VALUES(NULL,7,'night_stands_38','Description_38',30,now(),28.61,20,NULL,1);
INSERT INTO product_info VALUES(NULL,7,'night_stands_39','Description_39',5,now(),12.34,20,NULL,1);
INSERT INTO product_info VALUES(NULL,7,'night_stands_40','Description_40',75,now(),19.26,20,NULL,1);
INSERT INTO product_info VALUES(NULL,7,'night_stands_41','Description_41',57,now(),80.44,20,NULL,1);
INSERT INTO product_info VALUES(NULL,7,'night_stands_42','Description_42',52,now(),67.53,20,NULL,1);
INSERT INTO product_info VALUES(NULL,8,'bed_frames_43','Description_43',55,now(),25.28,20,NULL,1);
INSERT INTO product_info VALUES(NULL,8,'bed_frames_44','Description_44',73,now(),56.2,20,NULL,1);
INSERT INTO product_info VALUES(NULL,8,'bed_frames_45','Description_45',21,now(),42.35,20,NULL,1);
INSERT INTO product_info VALUES(NULL,8,'bed_frames_46','Description_46',97,now(),49.15,20,NULL,1);
INSERT INTO product_info VALUES(NULL,8,'bed_frames_47','Description_47',0,now(),58.91,20,NULL,1);
INSERT INTO product_info VALUES(NULL,9,'mattresses_48','Description_48',82,now(),67.43,20,NULL,1);
INSERT INTO product_info VALUES(NULL,9,'mattresses_49','Description_49',70,now(),1.60,20,NULL,1);
INSERT INTO product_info VALUES(NULL,9,'mattresses_50','Description_50',87,now(),35.74,20,NULL,1);
INSERT INTO product_info VALUES(NULL,9,'mattresses_51','Description_51',92,now(),91.55,20,NULL,1);
INSERT INTO product_info VALUES(NULL,9,'mattresses_52','Description_52',14,now(),83.74,20,NULL,1);
INSERT INTO product_info VALUES(NULL,10,'bath_towels_53','Description_53',33,now(),92.88,20,NULL,1);
INSERT INTO product_info VALUES(NULL,10,'bath_towels_54','Description_54',91,now(),16.77,20,NULL,1);
INSERT INTO product_info VALUES(NULL,10,'bath_towels_55','Description_55',79,now(),73.88,20,NULL,1);
INSERT INTO product_info VALUES(NULL,10,'bath_towels_56','Description_56',42,now(),4.35,20,NULL,1);
INSERT INTO product_info VALUES(NULL,10,'bath_towels_57','Description_57',0,now(),99.89,20,NULL,1);
INSERT INTO product_info VALUES(NULL,11,'rugs_58','Description_58',28,now(),35.67,20,NULL,1);
INSERT INTO product_info VALUES(NULL,11,'rugs_59','Description_59',26,now(),16.39,20,NULL,1);
INSERT INTO product_info VALUES(NULL,11,'rugs_60','Description_60',73,now(),14.46,20,NULL,1);
INSERT INTO product_info VALUES(NULL,11,'rugs_61','Description_61',1,now(),60.93,20,NULL,1);
INSERT INTO product_info VALUES(NULL,11,'rugs_62','Description_62',7,now(),25.81,20,NULL,1);
INSERT INTO product_info VALUES(NULL,11,'rugs_63','Description_63',94,now(),12.47,20,NULL,1);
INSERT INTO product_info VALUES(NULL,12,'accessories_64','Description_64',87,now(),37.69,20,NULL,1);
INSERT INTO product_info VALUES(NULL,12,'accessories_65','Description_65',7,now(),12.77,20,NULL,1);
INSERT INTO product_info VALUES(NULL,12,'accessories_66','Description_66',65,now(),87.15,20,NULL,1);
INSERT INTO product_info VALUES(NULL,12,'accessories_67','Description_67',86,now(),45.46,20,NULL,1);
INSERT INTO product_info VALUES(NULL,12,'accessories_68','Description_68',24,now(),97.42,20,NULL,1);
INSERT INTO product_info VALUES(NULL,13,'dining_table_69','Description_69',68,now(),71.82,20,NULL,1);
INSERT INTO product_info VALUES(NULL,13,'dining_table_70','Description_70',38,now(),16.49,20,NULL,1);
INSERT INTO product_info VALUES(NULL,13,'dining_table_71','Description_71',76,now(),95.3,20,NULL,1);
INSERT INTO product_info VALUES(NULL,13,'dining_table_72','Description_72',9,now(),60.67,20,NULL,1);
INSERT INTO product_info VALUES(NULL,13,'dining_table_73','Description_73',98,now(),0.21,20,NULL,1);
INSERT INTO product_info VALUES(NULL,14,'chairs_74','Description_74',72,now(),58.40,20,NULL,1);
INSERT INTO product_info VALUES(NULL,14,'chairs_75','Description_75',68,now(),87.23,20,NULL,1);
INSERT INTO product_info VALUES(NULL,14,'chairs_76','Description_76',96,now(),34.95,20,NULL,1);
INSERT INTO product_info VALUES(NULL,14,'chairs_77','Description_77',15,now(),91.47,20,NULL,1);
INSERT INTO product_info VALUES(NULL,14,'chairs_78','Description_78',76,now(),48.73,20,NULL,1);
INSERT INTO product_info VALUES(NULL,15,'plates_79','Description_79',8,now(),31.59,20,NULL,1);
INSERT INTO product_info VALUES(NULL,15,'plates_80','Description_80',47,now(),19.22,20,NULL,1);
INSERT INTO product_info VALUES(NULL,15,'plates_81','Description_81',2,now(),35.42,20,NULL,1);
INSERT INTO product_info VALUES(NULL,15,'plates_82','Description_82',55,now(),70.45,20,NULL,1);
INSERT INTO product_info VALUES(NULL,15,'plates_83','Description_83',71,now(),79.72,20,NULL,1);
INSERT INTO product_info VALUES(NULL,16,'wine_glasses_84','Description_84',72,now(),86.53,20,NULL,1);
INSERT INTO product_info VALUES(NULL,16,'wine_glasses_85','Description_85',20,now(),46.74,20,NULL,1);
INSERT INTO product_info VALUES(NULL,16,'wine_glasses_86','Description_86',63,now(),18.2,20,NULL,1);
INSERT INTO product_info VALUES(NULL,16,'wine_glasses_87','Description_87',83,now(),42.84,20,NULL,1);
INSERT INTO product_info VALUES(NULL,16,'wine_glasses_88','Description_88',18,now(),61.73,20,NULL,1);
INSERT INTO product_info VALUES(NULL,17,'candles_89','Description_89',69,now(),17.6,20,NULL,1);
INSERT INTO product_info VALUES(NULL,17,'candles_90','Description_90',49,now(),82.90,20,NULL,1);
INSERT INTO product_info VALUES(NULL,17,'candles_91','Description_91',63,now(),6.37,20,NULL,1);
INSERT INTO product_info VALUES(NULL,17,'candles_92','Description_92',82,now(),28.44,20,NULL,1);
INSERT INTO product_info VALUES(NULL,17,'candles_93','Description_93',69,now(),34.61,20,NULL,1);
INSERT INTO product_info VALUES(NULL,18,'cutlery_94','Description_94',0,now(),0.41,20,NULL,1);
INSERT INTO product_info VALUES(NULL,18,'cutlery_95','Description_95',46,now(),4.92,20,NULL,1);
INSERT INTO product_info VALUES(NULL,18,'cutlery_96','Description_96',62,now(),47.44,20,NULL,1);
INSERT INTO product_info VALUES(NULL,18,'cutlery_97','Description_97',57,now(),1.58,20,NULL,1);
INSERT INTO product_info VALUES(NULL,18,'cutlery_98','Description_98',84,now(),98.98,20,NULL,1);
INSERT INTO product_info VALUES(NULL,19,'blinds_and_curtains_99','Description_99',8,now(),30.49,20,NULL,1);
INSERT INTO product_info VALUES(NULL,19,'blinds_and_curtains_100','Description_100',63,now(),52.68,20,NULL,1);
INSERT INTO product_info VALUES(NULL,19,'blinds_and_curtains_101','Description_101',86,now(),24.72,20,NULL,1);
INSERT INTO product_info VALUES(NULL,20,'lights_and_lamps_102','Description_102',57,now(),32.7,20,NULL,1);
INSERT INTO product_info VALUES(NULL,20,'lights_and_lamps_103','Description_103',57,now(),45.29,20,NULL,1);
INSERT INTO product_info VALUES(NULL,20,'lights_and_lamps_104','Description_104',39,now(),25.72,20,NULL,1);
INSERT INTO product_info VALUES(NULL,21,'wall_arts_105','Description_105',8,now(),86.0,20,NULL,1);
INSERT INTO product_info VALUES(NULL,21,'wall_arts_106','Description_106',54,now(),44.45,20,NULL,1);
INSERT INTO product_info VALUES(NULL,21,'wall_arts_107','Description_107',80,now(),44.79,20,NULL,1);
INSERT INTO product_info VALUES(NULL,22,'mirrors_108','Description_108',80,now(),21.65,20,NULL,1);
INSERT INTO product_info VALUES(NULL,22,'mirrors_109','Description_109',5,now(),11.90,20,NULL,1);
INSERT INTO product_info VALUES(NULL,22,'mirrors_110','Description_110',91,now(),17.62,20,NULL,1);
INSERT INTO product_info VALUES(NULL,23,'cushions_and_throws_111','Description_111',94,now(),89.39,20,NULL,1);
INSERT INTO product_info VALUES(NULL,23,'cushions_and_throws_112','Description_112',15,now(),64.90,20,NULL,1);
INSERT INTO product_info VALUES(NULL,23,'cushions_and_throws_113','Description_113',42,now(),40.74,20,NULL,1);
INSERT INTO product_info VALUES(NULL,24,'scent_products_114','Description_114',85,now(),92.90,20,NULL,1);
INSERT INTO product_info VALUES(NULL,24,'scent_products_115','Description_115',7,now(),52.23,20,NULL,1);
INSERT INTO product_info VALUES(NULL,24,'scent_products_116','Description_116',45,now(),17.69,20,NULL,1);
update product_info
set soldQuantity = 100 - availableQuantity;
update product_info
set imagePath = '/static/assets/dist/images/Products/living-room/coffee-table/wooden-coffee-table.jpg';

INSERT INTO user_comment VALUES (NULL, 'augustine@inserted.com', 'product was nice!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'cwx@inserted.com', 'delivery was fast!',now(),8,1);
INSERT INTO user_comment VALUES (NULL, 'fengjy@inserted.com', 'nice workmanship!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'JMary@inserted.com', 'definitely gonna buy again!',now(),10,1);
INSERT INTO user_comment VALUES (NULL, 'JohnDoe@inserted.com', 'quality was bad!',now(),2,1);
INSERT INTO user_comment VALUES (NULL, 'ling@inserted.com', 'not what I expected!',now(),3,1);
INSERT INTO user_comment VALUES (NULL, 'mystery@inserted.com', 'product was nice!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'sebestian@inserted.com', 'delivery was fast!',now(),8,1);
INSERT INTO user_comment VALUES (NULL, 'tpu@inserted.com', 'nice workmanship!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'yangzj@inserted.com', 'definitely gonna buy again!',now(),10,1);
INSERT INTO user_comment VALUES (NULL, 'ZhouJL@inserted.com', 'quality was bad!',now(),2,1);
INSERT INTO user_comment VALUES (NULL, 'augustine@inserted.com', 'not what I expected!',now(),3,1);
INSERT INTO user_comment VALUES (NULL, 'cwx@inserted.com', 'product was nice!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'fengjy@inserted.com', 'delivery was fast!',now(),8,1);
INSERT INTO user_comment VALUES (NULL, 'JMary@inserted.com', 'nice workmanship!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'JohnDoe@inserted.com', 'definitely gonna buy again!',now(),10,1);
INSERT INTO user_comment VALUES (NULL, 'ling@inserted.com', 'quality was bad!',now(),2,1);
INSERT INTO user_comment VALUES (NULL, 'mystery@inserted.com', 'not what I expected!',now(),3,1);
INSERT INTO user_comment VALUES (NULL, 'sebestian@inserted.com', 'product was nice!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'tpu@inserted.com', 'delivery was fast!',now(),8,1);
INSERT INTO user_comment VALUES (NULL, 'yangzj@inserted.com', 'nice workmanship!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'ZhouJL@inserted.com', 'definitely gonna buy again!',now(),10,1);
INSERT INTO user_comment VALUES (NULL, 'augustine@inserted.com', 'quality was bad!',now(),2,1);
INSERT INTO user_comment VALUES (NULL, 'cwx@inserted.com', 'not what I expected!',now(),3,1);
INSERT INTO user_comment VALUES (NULL, 'fengjy@inserted.com', 'product was nice!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'JMary@inserted.com', 'delivery was fast!',now(),8,1);
INSERT INTO user_comment VALUES (NULL, 'JohnDoe@inserted.com', 'nice workmanship!',now(),9,1);
INSERT INTO user_comment VALUES (NULL, 'ling@inserted.com', 'definitely gonna buy again!',now(),10,1);
INSERT INTO user_comment VALUES (NULL, 'mystery@inserted.com', 'quality was bad!',now(),2,1);
INSERT INTO user_comment VALUES (NULL, 'sebestian@inserted.com', 'not what I expected!',now(),3,1);
update user_comment
set adminReply = "No Reply Yet";



insert into bookmark VALUES (NULL, 1, 'tpu@inserted.com', 1);
insert into bookmark VALUES (NULL, 1, 'ZhouJL@inserted.com', 1);
insert into bookmark VALUES (NULL, 1, 'ling@inserted.com', 0);
insert into bookmark VALUES (NULL, 2, 'JMary@inserted.com', 1);
insert into bookmark VALUES (NULL, 2, 'sebestian@inserted.com', 1);
insert into bookmark VALUES (NULL, 3, 'sebestian@inserted.com', 1);
insert into bookmark VALUES (NULL, 3, 'tpu@inserted.com', 1);
insert into bookmark VALUES (NULL, 4, 'tpu@inserted.com', 0);
insert into bookmark VALUES (NULL, 4, 'JMary@inserted.com', 0);
insert into bookmark VALUES (NULL, 5, 'augustine@inserted.com', 1);
insert into bookmark VALUES (NULL, 1, 'stanley@gmail.com', 0);
insert into bookmark VALUES (NULL, 2, 'stanley@gmail.com', 1);
insert into bookmark VALUES (NULL, 3, 'stanley@gmail.com', 1);
insert into bookmark VALUES (NULL, 4, 'stanley@gmail.com', 0);
insert into bookmark VALUES (NULL, 5, 'stanley@gmail.com', 1);

INSERT INTO order_info VALUES(NULL,'JohnDoe@inserted.com', DATE_ADD(now(), INTERVAL 3 DAY),'Doe','Blk 32C Jigsaw Ave #07-03','579032',90885878,0,18.54,DATE_ADD( DATE_ADD(now(), INTERVAL 3 DAY), INTERVAL 3 DAY),'Test tes',3,'John',3211,1, DATE_ADD(now(), INTERVAL 60 DAY));
INSERT INTO order_info VALUES(NULL,'JMary@inserted.com', DATE_ADD(now(), INTERVAL 3 DAY),'Mary','Blk 655 Jigsaw Ave #05-0','579655',93225231,0,100.38, DATE_ADD(now(), INTERVAL 3 DAY)+3,'Test mary',3,'Mary',1100,1, DATE_ADD(now(), INTERVAL 60 DAY));
INSERT INTO order_info VALUES(NULL,'ZhouJL@inserted.com', DATE_ADD(now(), INTERVAL 3 DAY),'Jie Lun','Blk 621 Hollywood Ave #22-11','385621',98775903,0,76.66, DATE_ADD(now(), INTERVAL 3 DAY)+3,'Test zhou tes',3,'Jie Lun',9999,1, DATE_ADD(now(), INTERVAL 60 DAY));
INSERT INTO order_info VALUES(NULL,'augustine@inserted.com', DATE_ADD(now(), INTERVAL 3 DAY),'Augustine','Blk 638 Hollywood Ave #17-53','385638',96524788,0,499.25, DATE_ADD(now(), INTERVAL 3 DAY)+3,'Test August~',3,'Augustine',1314,1,DATE_ADD(now(), INTERVAL 60 DAY));
INSERT INTO order_info VALUES(NULL,'sebestian@inserted.com', DATE_ADD(now(), INTERVAL 3 DAY),'Sebestian','Blk 800 Casear Palace Garden #33-42','355800',93397071,0,138.24, DATE_ADD(now(), INTERVAL 3 DAY)+3,'Test seb web',3,'Sebestian',5201,1, DATE_ADD(now(), INTERVAL 60 DAY));
INSERT INTO order_detail VALUES(1,1,3,18.54);
INSERT INTO order_detail VALUES(2,2,6,100.38);
INSERT INTO order_detail VALUES(3,3,1,76.66);
INSERT INTO order_detail VALUES(4,4,5,499.25);
INSERT INTO order_detail VALUES(5,5,4,138.24);


INSERT INTO order_info VALUES（NULL, 'tpu@inserted.com', now(), 'tian', 'Blk 139A Lorong 1A #19-88', '313139',82317582, 0, 18.54, now()+3, 'Test tp', 4, 'tpu', 3676, 1, now());
INSERT INTO order_info VALUES（NULL, 'ling@inserted.com', now(), 'gang', 'Blk 13 Toh Yi Drive #04-12', '590013',95631821, 0, 100.38, now()+3, 'Test lg', 8, 'ling', 0000, 2, now());
INSERT INTO order_info VALUES（NULL, 'cwx@inserted.com', now(), 'Xian', '672 Woodlands Drive 71 #21-11', '730672',23211523, 0, 76.66, now()+3, 'Test yx', 6, 'cwx', 1234, 2, now());
INSERT INTO order_info VALUES（NULL, 'yangzj@inserted.com', now(), 'yang', '316A Ang Mo Kio Street 31 #15-32', '562316',90479123, 0, 499.25, now()+3, 'Test zj~', 2, NULL, NULL, 3, now());
INSERT INTO order_info VALUES（NULL, 'fengjy@inserted.com', now(), 'feng', '182 Jln Jurong Kechil #17-53', '596145',96524788, 0, 138.24, now()+3, 'Test dailao', 10, NULL, NULL, 3, now());
INSERT INTO order_info VALUES（NULL, 'mystery@inserted.com', now(), 'mr', 'NullSpace in LinearAlgebra', '100000',93397071, 0, 138.24, now()+3, 'NO TEST', 1, 'mystery', 4765, 1, now());
INSERT INTO order_detail VALUES (1, 6, 4, 24.72);
INSERT INTO order_detail VALUES (11, 7, 8, 90.88);
INSERT INTO order_detail VALUES (16, 8, 6, 219.84);
INSERT INTO order_detail VALUES (22, 9, 2, 190.54);
INSERT INTO order_detail VALUES (28, 10, 10, 679);
INSERT INTO order_detail VALUES (33, 11, 1, 51.34);


INSERT INTO user_comment values (NULL, 'stanley@gmail.com', 'NIL', now(), 58, 'No Reply Yet!');
INSERT INTO user_comment values (NULL, 'stanley@gmail.com', 'NIL', now(), 75, 'No Reply Yet!');