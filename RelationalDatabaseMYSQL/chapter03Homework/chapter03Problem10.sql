-- File Name:  	chapter03Problem10.sq1
-- Date: 		September 04, 2017
-- Author:		Martin Dwyer
-- Description:	This script selects invoice number, date, payment and credit information.
-- 				The script calculates and returns balance due for instances where 
-- 				payment date is not known.

USE ap;

SELECT 	invoice_number,
		invoice_date,
        (invoice_total-payment_total-credit_total) as balance_due,
        payment_date
		FROM invoices
        WHERE payment_date IS NULL;
        
