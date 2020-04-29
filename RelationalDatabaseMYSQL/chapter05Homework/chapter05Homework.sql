/*
File Name: 		chapter05Homework.sq1
Date: 				2017-09-19
Author:				Martin Dwyer
Description:		This file contains solutions to exercises 4,5,6,7,8,9 
						pp. 164-165 from Murach's MySQL, 2nd Edition.
*/

USE ap;

/*
Exercise 4: The following script inserts a record into the invoices table.
*/

INSERT INTO 	invoices
						(	invoice_id,
							vendor_id,
							invoice_number,
							invoice_date,
							invoice_total,
							payment_total,
							credit_total,
							terms_id,
							invoice_due_date,
							payment_date		)

VALUES 		(	DEFAULT,
							32,
							'AX-014-027',
							'2014-08-01',
							434.58,
							0,
							0,
							2,
							'2014-08-31',
							NULL				)
;
            
-- The following SELECT statement verifies the addition of the record, revealing
-- that the invoice_id for the new invoice is 115.

SELECT 
    *
FROM
    invoices;

/*
Exercise 5: The following script inserts line item records for the invoice added
 in #4. The following code was used to determine the invoice_id assigned in #4
*/

INSERT INTO 	invoice_line_items
			(	invoice_id,	
				invoice_sequence, 
	            account_number, 
				line_item_amount, 
				line_item_description	)

VALUES 		(	115,
				1,
				160,
				180.23, 
				'Hard Drive'			),

			(	115,
				2,
				527,
				254.35,
				'Exchange Server update')
;

-- The following SELECT statement was written to verify the additions to
-- the invoice_line_items table.  

SELECT 
    *
FROM
    invoice_line_items
WHERE
    invoice_id = 115;
    
/*
Exercise 6: The following script updates the invoiced added in #4. 
*/

UPDATE invoices 
SET 
    credit_total = invoice_total * 0.10,
    payment_total = invoice_total - credit_total
WHERE
    invoice_id = 115;

-- The following SELECT statement verifies the changes were made.

SELECT 
    invoice_id, credit_total, payment_total, invoice_total
FROM
    invoices
WHERE
    invoice_id = 115;

/*
Exercise 7: The following script updates the vendors table where vendor_id = 44
*/

UPDATE vendors 
SET 
    default_account_number = 403
WHERE
    vendor_id = 44;

-- The update is verified as follows

SELECT 
    vendor_id, default_account_number
FROM
    vendors
WHERE
    vendor_id = 44;

/*
Exercise 8: The following script updates the terms_id in the invoices table to 2
for each invoice thats for a vendor with default_terms_id of 2
*/

UPDATE invoices 
SET 
    terms_id = 2
WHERE
    vendor_id IN 
		(SELECT 
				vendor_id
			FROM
				vendors
			WHERE
				default_terms_id = 2);

-- The following SELECT statement verifies the changes were made

SELECT 			i.invoice_id,
						i.terms_id,
						v.default_terms_id

FROM				invoices i

JOIN 				vendors v

ON					i.vendor_id = v.vendor_id

WHERE			v.default_terms_id = 2;

/*
Exercise 9: Removing the lines we have added in exercise #4 and #5.
*/

DELETE FROM invoice_line_items 
WHERE
    invoice_id = 115;

DELETE FROM invoices 
WHERE
    invoice_id = 115;

-- A SELECT statement is used to verify the removal 

SELECT 
    *
FROM
    invoices
WHERE
    invoice_id = 115;

