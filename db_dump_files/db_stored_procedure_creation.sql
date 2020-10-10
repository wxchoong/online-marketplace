DELIMITER //
CREATE PROCEDURE `sp_item_by_categoryMain`(categoryTitle varchar(45))
BEGIN
	Select * from product_info where categoryID = (Select ID from category where categoryMain = categoryTitle);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `sp_item_by_categorySub`(categoryTitle varchar(45), categorySubTitle varchar(45))
BEGIN
	Select * from product_info where categoryID = (Select ID from category where categoryMain = categoryTitle AND categorySub = categorySubTitle);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `sp_check_availability`(productIdentifier int)
BEGIN
	Select availableQuantity from product_info where productIdentifier = productID;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `sp_new_order`(createDate DATETIME, Cname VARCHAR(140), addr VARCHAR(140), ph VARCHAR(140), shipName VARCHAR(140), shipAddr VARCHAR(140), shipPh VARCHAR(140), msg VARCHAR(140), cust_mail VARCHAR(140))
BEGIN
	INSERT INTO tabSales_Order(creation_datetime, customer_name,
	customer_address, customer_phone_no, shipper_name, shipper_address, shipper_phone_no, 
	personalised_msg, customer_email) VALUES (createDate, Cname, addr, ph, shipName, shipAddr, shipPh, msg, cust_mail);
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE `sp_registration`(email VARCHAR(45), fName VARCHAR(64), lName VARCHAR(64), contact INT, pwd VARCHAR(30), addr VARCHAR(100), postal INT)
BEGIN
	insert into user_info VALUES (NULL, email, contact, pwd, fName, lName, addr, postal, now(), now(), 1, "CARD", 0);
END //
DELIMITER ;


DELIMITER //
CREATE FUNCTION `get_total_spending_of_the_month`(email varchar(45),  specificMonth int) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE total INT;
    SELECT 
        SUM(OD.subTotal)
    INTO total
    FROM 
        order_detail
    INNER JOIN 
		order_info USING (orderedCustomer)
    WHERE 
        orderedCustomer = email AND 
        EXTRACT(MONTH FROM orderedDate) = specificMonth;
    RETURN total;
END //
DELIMITER ;