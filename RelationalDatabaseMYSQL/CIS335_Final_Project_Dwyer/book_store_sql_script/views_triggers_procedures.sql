/*
CIS 335                   
FINAL PROJECT               
BOOK STORE DATABASE          

Script in this file contains the following for the book_store database:
  >	Three views for 
      (1) Sales by customer (lines 22 - 48)
      (2) Sales by genre (lines 51 - 72)
      (3) Sales by publisher (lines 74 - 100)
  > Two triggers, one for update and one for delete.
      (1) Trigger for updates to book_sales (lines 105 - 168)
      (2) Trigger for deletes from book_sales (lines 170 - 212) 
  > Four stored procedures with error handling
      (1) CREATE records in book_sales (lines 218 258)
      (2) READ periodic sales data from book_sales (lines 260 - 316)
      (3) UPDATE discount applied to sales in book_sales (lines 319 - 360)
      (4) DELECT sales from the book_sales table (lines 363 - 400)
							   
Filename: views_triggers_procedures.sql
Created: December 2, 2017

Author:  Martin Dwyer
/*/

USE book_store;

-- View #1: Sales by customer for the most recent 90 days.
DROP VIEW IF EXISTS sales_by_customer_90_day;
CREATE VIEW sales_by_customer_90_day AS
SELECT 	bs.customer_id AS 'Customer_ID', 
        pe.people_first_name AS 'First_Name',
        pe.people_last_name AS 'Last_Name',
        po.city AS 'Customer_City',
        po.state AS 'Customer_State',
        COUNT(bs.sale_id) AS 'Number_of_Books', 
        SUM(bo.list_price) AS 'Total_$_Sales',
        pe.people_email_address AS 'Customer_Email'
        
		FROM book_sales bs
		JOIN customers cu
			ON bs.customer_id = cu.customer_id
		JOIN books bo
			ON bs.book_id = bo.book_id
		JOIN people pe
			ON cu.people_id = pe.people_id
		JOIN postal po
			ON pe.people_postal_code = po.postal_code
		
		WHERE sale_date >= '2017-06-30' AND sale_date <= '2017-09-30'
		GROUP BY pe.people_id
		ORDER BY Total_$_Sales DESC
;

SELECT * FROM sales_by_customer_90_day;
	
-- The following view ranks sales by genre over the past 90 days
DROP VIEW IF EXISTS sales_by_genre_90_day;
CREATE VIEW sales_by_genre_90_day AS
SELECT 	bg.genre_id AS 'Genre_ID', 
		bg.genre_description AS 'Genre_Description',
        COUNT(bs.sale_id) AS 'Number_of_Books', 
        SUM(bo.list_price) AS 'Total_$_Sales'
        
		FROM book_sales bs
		JOIN customers cu
			ON bs.customer_id = cu.customer_id
		JOIN books bo
			ON bs.book_id = bo.book_id
		JOIN book_genre bg
			ON bg.genre_id = bo.genre_id
		
		WHERE sale_date >= '2017-06-30' AND sale_date <= '2017-09-30'
		GROUP BY bg.genre_id
		ORDER BY Total_$_Sales DESC
;

SELECT * FROM sales_by_genre_90_day;

-- The following view ranks sales by publisher over the past 90 days
DROP VIEW IF EXISTS sales_by_publisher_90_day;
CREATE VIEW sales_by_publisher_90_day AS
SELECT 	pu.publisher_id AS 'Publisher_ID', 
		pu.publisher_name AS 'Publisher Name',
        COUNT(bs.sale_id) AS 'Number_of_Books', 
        SUM(bo.list_price) AS 'Total_$_Sales',
        CONCAT(po.people_first_name," ",po.people_last_name) AS 'Publisher_Contact',
        pu.publisher_phone AS 'Publisher_Phone',
        pu.publisher_email_address AS 'Publisher_Email'
        
		FROM book_sales bs
		JOIN customers cu
			ON bs.customer_id = cu.customer_id
		JOIN books bo
			ON bs.book_id = bo.book_id
		JOIN publishers pu
			ON pu.publisher_id = bo.publisher_id
		JOIN people po
			ON pu.publisher_contact = po.people_id
		
		WHERE sale_date >= '2017-06-30' AND sale_date <= '2017-09-30'
		GROUP BY pu.publisher_id
		ORDER BY Total_$_Sales DESC
;

SELECT * FROM sales_by_publisher_90_day;


-- Trigger for updates of rows in books_sales table begin here
-- Creating audit table if it does not already exist
CREATE TABLE IF NOT EXISTS book_sales_updates
(
	sale_id INT NOT NULL,
	sale_date DATE NOT NULL,
    customer_id INT NOT NULL,
    action_type VARCHAR(50) NOT NULL,
	action_date DATETIME NOT NULL,
    user_name VARCHAR(50) NOT NULL
)
;

-- Creating new trigger for updated records, deleting old one if it exists
DROP TRIGGER IF EXISTS tr_book_sales_updates;

DELIMITER //

CREATE TRIGGER tr_book_sales_updates
	AFTER UPDATE ON book_sales
	FOR EACH ROW
BEGIN
	INSERT INTO book_sales_updates VALUES
    (OLD.sale_id, OLD.sale_date,OLD.customer_id,'UPDATE', NOW(),CURRENT_USER())
	;
END//

DELIMITER ;

-- The following two UPDATE statements will test the trigger
SET SQL_SAFE_UPDATES = 0;

UPDATE book_sales
	SET discount_applied = 0.50
	WHERE sale_date = '2017-07-11'
;

UPDATE book_sales
	SET discount_applied = 0.50
	WHERE sale_date = '2017-06-30'
;

-- There should be a total of 9 records affected by the sale_date discount update
SELECT * 
	FROM book_sales_updates
    ORDER BY action_date
;


-- Two update statements reverse changes made above:
UPDATE book_sales
	SET discount_applied = 0.00
	WHERE sale_date = '2017-07-11'
;

UPDATE book_sales
	SET discount_applied = 0.00
	WHERE sale_date = '2017-06-30'
;

-- Two delete statements remove the records from invoices_audit:
DELETE FROM book_sales_updates WHERE sale_date = '2017-06-30' LIMIT 999;
DELETE FROM book_sales_updates WHERE sale_date = '2017-07-11' LIMIT 999;


-- Trigger For Row Deletes in the book_sales table begins here
-- Creating audit table if it does not already exist
CREATE TABLE IF NOT EXISTS book_sales_deletes
(
	sale_id INT NOT NULL,
	book_id INT NOT NULL,
    sale_date DATE NOT NULL,
    customer_id INT NOT NULL,
    discount_applied DECIMAL(3,2) NOT NULL,
    action_type VARCHAR(50) NOT NULL,
	action_date DATETIME NOT NULL,
    user_name VARCHAR(50) NOT NULL
)
;

-- Creating new trigger for updated records, deleting old one if it exists
DROP TRIGGER IF EXISTS tr_book_sales_deletes;

DELIMITER //

CREATE TRIGGER tr_book_sales_deletes
	AFTER DELETE ON book_sales
	FOR EACH ROW
BEGIN
	INSERT INTO book_sales_deletes VALUES
    (OLD.sale_id, OLD.book_id, OLD.sale_date,OLD.customer_id,OLD.discount_applied,'DELETED', NOW(),CURRENT_USER())
	;
END//

DELIMITER ;

-- The following two UPDATE statements will test the trigger
SET SQL_SAFE_UPDATES = 0;

DELETE FROM book_sales WHERE sale_date = '2017-09-12';
DELETE FROM book_sales WHERE sale_date = '2017-09-21';

-- Six recprds from the original database would be dropped into the delete table
SELECT * 
	FROM book_sales_deletes
    ORDER BY action_date
;

-- Stored prodedure to CREATE new sale records begins here
DROP PROCEDURE IF EXISTS insert_sale;

DELIMITER //

CREATE PROCEDURE insert_sale
(
  sale_date_param DATE,
  book_id_param INT,
  customer_id_param INT,
  discount_applied_param DECIMAL(3,2)
)
BEGIN
  
  -- Validate paramater values
  IF sale_date_param > NOW() THEN
    SIGNAL SQLSTATE '22003'
      SET MESSAGE_TEXT = 'The sale_date is in the future.', 
      MYSQL_ERRNO = 1264;
  END IF;
  
  IF discount_applied_param > 0.50 THEN
    SIGNAL SQLSTATE '22003'
      SET MESSAGE_TEXT = 'That discount applied is beyond your authority.', 
      MYSQL_ERRNO = 1264;
  END IF;
  
  INSERT INTO book_sales
         (sale_date,book_id,customer_id,discount_applied)
  VALUES (sale_date_param,book_id_param,customer_id_param,discount_applied_param);
END//

DELIMITER ;

-- Test call statements
CALL insert_sale('2017-05-15',85,38,0.15);
CALL insert_sale('2016-03-10',15,02,0.35);

-- These statements both produce an error and display the appropriate messsage
-- CALL insert_sale('2018-03-10',15,02,0.35);
-- CALL insert_sale('2016-03-10',15,300,0.75);

-- Stored prodedure to READ sales data for specified time period from the book_sales table
DROP PROCEDURE IF EXISTS period_sales;

DELIMITER //

CREATE PROCEDURE period_sales
(
  beginning_date_param DATE,
  ending_date_param DATE
)
BEGIN
  
  -- Validate paramater values
  IF beginning_date_param > NOW() OR ending_date_param > NOW() THEN
    SIGNAL SQLSTATE '22003'
      SET MESSAGE_TEXT = 'Sales dates entered out of range. Please correct and try again.', 
      MYSQL_ERRNO = 1264;
  END IF;
  
  IF beginning_date_param > ending_date_param THEN
    SIGNAL SQLSTATE '22003'
      SET MESSAGE_TEXT = 'Start date occurs after end date.  Please correct and try again.', 
      MYSQL_ERRNO = 1264;
  END IF;
  
  SELECT 	
		bs.sale_date, 
        pe.people_first_name AS 'First_Name',
        pe.people_last_name AS 'Last_Name',
        po.city AS 'Customer_City',
        po.state AS 'Customer_State',
        bs.sale_id, 
        bo.list_price
        
		FROM book_sales bs
		JOIN customers cu
			ON bs.customer_id = cu.customer_id
		JOIN books bo
			ON bs.book_id = bo.book_id
		JOIN people pe
			ON cu.people_id = pe.people_id
		JOIN postal po
			ON pe.people_postal_code = po.postal_code
		
		WHERE bs.sale_date >= beginning_date_param AND bs.sale_date <= ending_date_param
		ORDER BY bs.sale_date
;
END//

DELIMITER ;

-- Test call statements
CALL period_sales('2017-06-30','2017-07-31');
CALL period_sales('2017-08-15','2017-09-15');

-- These statements both produce an error and display the appropriate messsage
-- CALL period_sales('2017-08-30','2017-07-31');
-- CALL period_sales('2017-06-30','2017-12-31');


-- Stored procedure to UPDATE the discount applied to a sale begins here.
DROP PROCEDURE IF EXISTS update_book_sale_discount;

DELIMITER //

CREATE PROCEDURE update_book_sale_discount
(
  sale_id_param INT,
  discount_applied_param DECIMAL(3,2) 
)
BEGIN
  DECLARE sql_error INT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;  

  UPDATE book_sales
  SET discount_applied = discount_applied_param 
  WHERE sale_id = sale_id_param;

  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;

-- Use the CALL statement
CALL update_book_sale_discount(50,0.35);

SELECT sale_id, discount_applied

	FROM  book_sales
    
    WHERE sale_id = 50;

-- The following CALL statement produces an  error and is not processed
-- CALL update_book_sale_discount(50,100.5);


-- Stored procedure to DELETE sales records.
DROP PROCEDURE IF EXISTS delete_sale;

DELIMITER //

CREATE PROCEDURE delete_sale
(
  sale_id_param INT
)
BEGIN
  DECLARE sql_error INT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;  

  DELETE FROM book_sales
  WHERE sale_id = sale_id_param;

  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;

-- Use the CALL statement
CALL delete_sale(65);

SELECT sale_id, discount_applied

	FROM  book_sales
    
    WHERE sale_id >= 60 and sale_id <= 70
;

