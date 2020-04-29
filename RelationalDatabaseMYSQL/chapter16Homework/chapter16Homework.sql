/*
CIS 335                   
TRIGGER ASSIGNMENT
Exercise 2, p. 458 (Murach's MySQL)
							   
Filename: chapter16Homework.sql
Created: November 28, 2017

Author:  Martin Dwyer
/*/

USE ap;

-- Preview all items from invoices selecting two for update
-- SELECT * FROM INVOICES;

-- Creating audit table if it does not already exist
CREATE TABLE IF NOT EXISTS invoices_audit
(
	vendor_id INT NOT NULL,
	invoice_number VARCHAR(50) NOT NULL,
	invoice_total DECIMAL(9,2) NOT NULL,
	action_type VARCHAR(50) NOT NULL,
	action_date DATETIME NOT NULL,
    user_name VARCHAR(50) NOT NULL
)
;

-- Creating new trigger for updated records, deleting old one if it exists
DROP TRIGGER IF EXISTS tr_invoices_after_update;

DELIMITER //

CREATE TRIGGER tr_invoices_after_update
	AFTER UPDATE ON invoices
	FOR EACH ROW
BEGIN
	INSERT INTO invoices_audit VALUES
    (OLD.vendor_id, OLD.invoice_number, OLD.invoice_total,'UPDATE', NOW(),CURRENT_USER())
	;
END//

DELIMITER ;

-- The following two UPDATE statements will test the trigger
UPDATE invoices
	SET credit_total = 0.00
	WHERE vendor_id = 121
;

UPDATE invoices
	SET credit_total = 10000.00
	WHERE vendor_id = 123
;

-- The following revealed that 55 rows had been added to the invoices_audit
-- table; 8 rows for vendor_id = 121 and 47 rows for vendor_id = 123.
-- The user_name of root@localhost and current time is recorded for each update.
SELECT * FROM invoices_audit;


-- Two update statements reverse changes made above:
-- UPDATE invoices
-- 	SET credit_total = 200.00
-- 	WHERE vendor_id = 121
-- ;
-- UPDATE invoices
-- 	SET credit_total = 0.00
-- 	WHERE vendor_id = 123
-- ;

-- Two delete statements remove the records from invoices_audit:
-- DELETE FROM invoices_audit WHERE vendor_id = 121 LIMIT 999;
-- DELETE FROM invoices_audit WHERE vendor_id = 123 LIMIT 999;


