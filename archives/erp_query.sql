CREATE DATABASE fmcg_erp;

USE fmcg_erp;

CREATE TABLE tabSales_Order(
	id INT AUTO_INCREMENT NOT NULL,
	order_id VARCHAR(140) NOT NULL UNIQUE,
	creation_datetime DATETIME(6) NOT NULL,
	customer_name VARCHAR(140),
	customer_address VARCHAR(140),
	customer_phone_no VARCHAR(140),
	shipper_name VARCHAR(140),
	shipper_address VARCHAR(140),
	shipper_phone_no VARCHAR(140),
	personalised_msg VARCHAR(140),
	attrib_01 VARCHAR(140),
	
	PRIMARY KEY(id)
);

CREATE TABLE tabSales_Order_Item(
	id INT AUTO_INCREMENT NOT NULL,
	creation_datetime DATETIME(6) NOT NULL,
	parent_id  VARCHAR(140) NOT NULL,
	item_code VARCHAR(140) NOT NULL,
	quantity INT NOT NULL,
	mfr VARCHAR(140),
	
	PRIMARY KEY(id),
	FOREIGN KEY(parent_id) REFERENCES tabSales_Order(order_id)
);

INSERT INTO tabSales_Order(order_id, creation_datetime, customer_name,customer_address,customer_phone_no, shipper_name, shipper_address, shipper_phone_no, personalised_msg, attrib_01) 
VALUES ('Test001', CURRENT_TIMESTAMP, 'Weng Xian', 'Customer-Addr-1', '12345678', 'ARTC', 'ARTC-Addr', '87654321', 'Hello, Welcome', 'WX'), 
('Test002', CURRENT_TIMESTAMP, 'John', 'Customer-Addr-2', '65768165', 'ARTC', 'ARTC-Addr', '87654321', 'This is customer number 2', 'J'), 
('Test003', CURRENT_TIMESTAMP, 'Mary', 'Customer-Addr-3', '23232323', 'ARTC', 'ARTC-Addr', '87654321', 'This is customer number 3', 'M'), 
('Test004', CURRENT_TIMESTAMP, 'Bruce', 'Customer-Addr-4', '47628561', 'ARTC', 'ARTC-Addr', '87654321', 'This is customer number 4', 'B'), 
('Test005', CURRENT_TIMESTAMP, 'Sam', 'Customer-Addr-5', '87687571', 'ARTC', 'ARTC-Addr', '87654321', 'This is customer number 5', 'S'), 
('Test006', CURRENT_TIMESTAMP, 'Chris', 'Customer-Addr-6', '88886666', 'ARTC', 'ARTC-Addr', '87654321', 'This is customer number 6', 'C'), 
('Test007', CURRENT_TIMESTAMP, 'Gina', 'Customer-Addr-7', '45433776', 'ARTC', 'ARTC-Addr', '87654321', 'This is customer number 7', 'G'), 
('Test008', CURRENT_TIMESTAMP, 'Hanson', 'Customer-Addr-8', '56568691', 'ARTC', 'ARTC-Addr', '87654321', 'This is customer number 8', 'H'), 
('Test009', CURRENT_TIMESTAMP, 'Kingston', 'Customer-Addr-9', '75644532', 'ARTC', 'ARTC-Addr', '87654321', 'This is customer number 9', 'K'), 
('Test010', CURRENT_TIMESTAMP, 'Tomato', 'Customer-Addr-10', '15475173', 'ARTC', 'ARTC-Addr', '87654321', 'This is customer number 10', 'T')

INSERT INTO tabSales_Order_Item(creation_datetime, parent_id, item_code, quantity, mfr)
VALUES (CURRENT_TIMESTAMP, 'Test001', 'FMCG_01', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test001', 'FMCG_02', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test001', 'FMCG_03', 1, 'xxxxx'),
(CURRENT_TIMESTAMP, 'Test002', 'FMCG_04', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test002', 'FMCG_05', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test002', 'FMCG_03', 1, 'xxxxx'),
(CURRENT_TIMESTAMP, 'Test003', 'FMCG_01', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test003', 'FMCG_02', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test003', 'FMCG_04', 1, 'xxxxx'),
(CURRENT_TIMESTAMP, 'Test004', 'FMCG_02', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test004', 'FMCG_03', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test004', 'FMCG_04', 1, 'xxxxx'),
(CURRENT_TIMESTAMP, 'Test005', 'FMCG_01', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test005', 'FMCG_02', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test005', 'FMCG_03', 1, 'xxxxx'),
(CURRENT_TIMESTAMP, 'Test006', 'FMCG_03', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test006', 'FMCG_04', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test006', 'FMCG_05', 1, 'xxxxx'),
(CURRENT_TIMESTAMP, 'Test007', 'FMCG_02', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test007', 'FMCG_03', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test007', 'FMCG_04', 1, 'xxxxx'),
(CURRENT_TIMESTAMP, 'Test008', 'FMCG_01', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test008', 'FMCG_03', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test008', 'FMCG_05', 1, 'xxxxx'),
(CURRENT_TIMESTAMP, 'Test009', 'FMCG_01', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test009', 'FMCG_02', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test009', 'FMCG_05', 1, 'xxxxx'),
(CURRENT_TIMESTAMP, 'Test010', 'FMCG_03', 1, 'xxxxx'),(CURRENT_TIMESTAMP, 'Test010', 'FMCG_04', 1, 'xxxxx'), (CURRENT_TIMESTAMP, 'Test010', 'FMCG_05', 1, 'xxxxx')

-----------------------------------------------------------------------------------------------------------------------------------------------------

-- USE bitnami_erpnext;

-- ALTER TABLE `tabSales Order`
-- ADD shipper_name VARCHAR(140),
-- ADD shipper_address VARCHAR(140),
-- ADD shipper_phone_no VARCHAR(140),
-- ADD personalised_msg VARCHAR(140),
-- ADD attrib_01 VARCHAR(140);