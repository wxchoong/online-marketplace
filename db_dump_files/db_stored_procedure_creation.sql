DELIMITER //
CREATE PROCEDURE `sp_item_by_categoryMain`(categoryTitle varchar(45))
BEGIN
	Select productName,price,imagePath, productID from product_info 
    where isShow = 1 and categoryID IN
    (Select categoryID from category where categoryMain = categoryTitle);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `sp_item_by_categorySub`(categorySubTitle varchar(45))
BEGIN
	Select productName,price,imagePath, productID from product_info 
    where isShow = 1 and categoryID = 
    (Select categoryID from category where categorySub = categorySubTitle);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `search_product`(searchStr VARCHAR(45))
BEGIN
    Select productName,price,imagePath, productID from product_info 
    where productName LIKE searchStr and isShow = 1;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `sp_check_availability`(productIdentifier int)
BEGIN
	Select availableQuantity from product_info 
    where productIdentifier = productID;
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

DELIMITER //
CREATE FUNCTION `check_bookmark_exist`(bProductId int, bEmail VARCHAR(45)) RETURNS INT 
DETERMINISTIC
BEGIN
DECLARE bookmarkCount INT;
SELECT COUNT(bookMarkID) FROM bookmark WHERE productID = bProductId AND userEmail = bEmail INTO bookmarkCount;
RETURN bookmarkCount;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE `get_top_picks`()
BEGIN
	SELECT productName, imagePath, productID FROM product_info
    where soldQuantity < 100
    ORDER BY soldQuantity desc limit 5;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `get_sub_total`(productIdentifier INT, itemQuantity INT) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE subTotal FLOAT;
    select price from product_info where productID = productIdentifier INTO subTotal;
RETURN subTotal*itemQuantity;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `add_order_detail`(productID INT, orderID INT, numOfItems INT)
BEGIN
	SET @subTotal = get_sub_total(productID,numOfItems);
	insert into order_detail VALUES(productID, orderID, numOfItems, @subTotal);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `display_product_by_ID`(productIdentifier INT)
BEGIN
	Select productName, price, productDescription, availableQuantity, imagePath from product_info
    where productIdentifier = productID AND availableQuantity > 0;
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `sort_product_by_ordering`(categorySubTitle varchar(45), ordering varchar(6))
BEGIN
	set @specifiedOrder = ordering;
    IF @specifiedOrder = 'latest' THEN
		Select productName,price,imagePath, productID from product_info 
		where isShow = 1 and categoryID = 
		(Select categoryID from category where categorySub = categorySubTitle)
		order by lastUpdated desc;
	END IF;
	IF @specifiedOrder = 'asc' THEN
		Select productName,price,imagePath, productID from product_info 
		where isShow = 1 and categoryID = 
		(Select categoryID from category where categorySub = categorySubTitle)
		order by price asc;
	END IF;
	IF @specifiedOrder = 'desc' THEN
		Select productName,price,imagePath, productID from product_info 
		where isShow = 1 and categoryID = 
		(Select categoryID from category where categorySub = categorySubTitle)
		order by price desc;
	END IF;
END//
DELIMITER ;

----------------
-- Start userInfo table

DELIMITER //
CREATE PROCEDURE `new_registration`(email VARCHAR(45), fName VARCHAR(64), lName VARCHAR(64), contact INT, pwd VARCHAR(100), addr VARCHAR(100), postal INT)
BEGIN
	insert into user_info 
    VALUES (email, contact, pwd, fName, lName, addr, postal, now(), now(), 0);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `display_userInfo`(email VARCHAR(45))
BEGIN
    SELECT * FROM user_info 
    WHERE userEmail = email;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `update_userInfo`(email VARCHAR(45), phone int, addresses varchar(100), postCode int)
BEGIN
    UPDATE user_info 
    SET 
        userPhone = phone,
        userAddress = addresses,
        userPostalCode = postCode
    WHERE userEmail = email;   
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `update_password`(email VARCHAR(45), pwd VARCHAR(100))
BEGIN
    UPDATE user_info 
    SET 
        userPassword = pwd 
    WHERE userEmail = email;
END //
DELIMITER ;


-- End userInfo table
---------------




---------------- STOP HERE FOR CREATING VIEW !!!!!!
-- Start cart(order-detail) table 

DELIMITER //
CREATE PROCEDURE `update_cart`()
BEGIN
    select orderID, totalPrice, orderStatus from order_info;
END //
DELIMITER ;

-- Endcart(order-detail) table 
---------------- STOP HERE FOR CREATING VIEW !!!!!!


-- 1.product table 
DELIMITER //-- Admin Func
CREATE PROCEDURE `add_product`(categoryID int, pName VARCHAR(100), pDescript VARCHAR(255), pAvaQuantity INT, pPrice FLOAT, pSoldQuan int, imagePath VARCHAR(255))
BEGIN
    insert into product_info 
    VALUES (NULL, categoryID, pName, pDescript, pAvaQuantity, now(), pPrice, pSoldQuan,imagePath,1);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `display_product_all`()
BEGIN
    select productName, price, imagePath, productID
    from product_info where availableQuantity > 0 and isShow = 1;

END //
DELIMITER ;

DELIMITER // -- Admin Func
CREATE PROCEDURE `display_product_filter`(categoryID INT(11), pIsShow BIT(1))
BEGIN
    select productID, productName,category.categorySub, price, availableQuantity, isShow
    from product_info join category
    on product_info.categoryID = category.categoryID
    WHERE isShow = pIsShow AND availableQuantity > 0;
END //
DELIMITER ;

DELIMITER //-- Admin Func
CREATE PROCEDURE `update_product`(productId INT, pCategory int, pName VARCHAR(100), pPrice FLOAT, pQuantity INT, imageLoc VARCHAR(255), pDescript VARCHAR(255))
BEGIN
    UPDATE product_info 
    SET 
        productName = pName,
        categoryID = pCategory,
        price = pPrice,
        availableQuantity = pQuantity,
        imagePath = imageLoc,
        productDescription = pDescript
    WHERE
        productID = productId;
END //
DELIMITER ;

DELIMITER //-- Admin Func
CREATE PROCEDURE `hide_product`(productId INT(11), currentState BIT)
BEGIN
	IF currentState = 1 THEN
		UPDATE product_info 
		SET isShow = 0, lastUpdated = now()
		WHERE productID = productId;
	ELSEIF currentState = 0 THEN
		UPDATE product_info 
		SET isShow = 1, lastUpdated = now()
		WHERE productID = productId;
	END IF;
END //
DELIMITER ;

-- 2. Order Table
DELIMITER //
CREATE PROCEDURE `add_order`(custEmail VARCHAR(45), orderDate DATETIME, receiveName VARCHAR(100), receiveAddr VARCHAR(100), receivePostal INT, 
    receivePhone INT, orderStatus VARCHAR(20), totalPrice FLOAT, deliverDate DATETIME, remark VARCHAR(255), totalQuantity INT,
    cardLordName VARCHAR(100), cardNo INT, paymentIndex INT, expiryDate DATE)
BEGIN
	INSERT INTO order_info VALUES(NULL, custEmail,orderDate,receiveName,receiveAddr,receivePostal,
    receivePhone, orderStatus, totalPrice, deliverDate,remark, totalQuantity, cardLordName, cardNo, paymentIndex, expiryDate);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `display_order_user`(email VARCHAR(45))
BEGIN
    select orderID, totalPrice, orderStatus from order_info where userEmail = email;
END //
DELIMITER ;

DELIMITER //-- Admin Func
CREATE PROCEDURE `display_order_admin`()
BEGIN
    select orderID, totalPrice, orderStatus from order_info;
END //
DELIMITER ;

DELIMITER //-- Admin Func
CREATE PROCEDURE `display_order_filter`(oStatus INT)
BEGIN
    select orderID, totalPrice, orderStatus from order_info WHERE orderStatus = oStatus;
END //
DELIMITER ;

DELIMITER //-- Admin Func
CREATE PROCEDURE `update_order_status`(orderId INT(11), oStatus int)
BEGIN
    UPDATE order_info SET orderStatus = oStatus WHERE orderID = orderId;
END //
DELIMITER ;


--3.Dashboard


--4.Comment Table 

DELIMITER //-- Admin Func
CREATE PROCEDURE `display_comment_not_reply_yet`(productId int, email VARCHAR(45))
BEGIN
    SELECT * FROM user_comment WHERE adminReply = "No Reply Yet" AND productID = productId;
END //
DELIMITER ;

DELIMITER //-- Admin Func
CREATE PROCEDURE `display_comment_replied`(productId int, email VARCHAR(45))
BEGIN
    SELECT * FROM user_comment WHERE adminReply != "No Reply Yet" AND productID = productId;
END //
DELIMITER ;

DELIMITER //-- Admin Func
CREATE PROCEDURE `insert_admin_reply`(commentor varchar(45), commentId int, Reply VARCHAR(100))
BEGIN
 UPDATE user_comment 
 SET adminReply = Reply 
 WHERE commentID = commentId and commentorEmail = commentor;
END //
DELIMITER ;

DELIMITER //-- Admin Func
CREATE PROCEDURE `delete_admin_reply`(commentId int)
BEGIN
    UPDATE user_comment SET adminReply = "No Reply Yet" WHERE commentID = commentId;
END //
DELIMITER ;

-- bookmark table
DELIMITER //
CREATE PROCEDURE `add_bookmark`(productId int, email VARCHAR(45), marked BIT(1))
BEGIN
    INSERT INTO bookmark VALUES(NULL, productId, email, marked);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `update_bookmark`(prodID int,userIdentifier varchar(45), likeOrNo int)
BEGIN
	IF likeOrNo != 0 THEN
		SET @exist = check_bookmark_exist(prodID, userIdentifier);
        IF @exist = 1 THEN
			UPDATE bookmark SET isMarked = 1 WHERE  productID = prodID and userEmail = userIdentifier;
		ELSE 
			CALL add_bookmark(prodID, userIdentifier, likeOrNo);
		END IF;
	END IF; 
    IF likeOrNo = 0 THEN 
		UPDATE bookmark SET isMarked = 0 WHERE productID = prodID and userEmail = userIdentifier;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `display_bookmark_user`(email VARCHAR(45))
BEGIN
    select pi.productName, pi.price, pi.imagePath, pi.productID, bm.isMarked, bm.bookmarkID from product_info pi, bookmark bm where pi.productID = bm.productID and bm.isMarked = 1 and bm.userEmail = email; 
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE `get_top_spending_user`()
BEGIN
	SELECT ui.userEmail, oi.totalItemPrice as Spending FROM user_info ui INNER JOIN order_info oi
    ON ui.userEmail = oi.orderedCustomer
    ORDER BY  Spending desc limit 5;
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `sp_manage_product`()
BEGIN
	select pi.ProductID, pi.ProductName, cat.categorySub, pi.price, pi.availableQuantity, pi.isShow from product_info pi, category cat where pi.categoryID = cat.categoryID;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_manage_order`()
BEGIN
	select orderID, totalItemPrice, orderStatus from order_info;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_manage_comment`()
BEGIN
select uc.commentID, pi.productName, uc.commentDate, uc.commentorEmail, uc.comment, uc.adminReply 
from user_comment uc, product_info pi 
where uc.productID = pi.productID;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `check_user_exist`(Email VARCHAR(45)) RETURNS INT
DETERMINISTIC
BEGIN
DECLARE isUserExist INT;
SELECT COUNT(userEmail) FROM user_info WHERE userEmail = Email INTO isUserExist;
RETURN isUserExist;
END//
DELIMITER ;