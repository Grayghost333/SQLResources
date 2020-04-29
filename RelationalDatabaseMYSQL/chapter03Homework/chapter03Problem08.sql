-- File Name:  	chapter03Problem08.sq1
-- Date: 		September 04, 2017
-- Author:		Martin Dwyer
-- Description:	This script selects invoice due date and totals for invoices between $500 and $1000.  
-- 				The script also calculates and returns 10% and 110% of the invoice total.

USE ap;

SELECT 	invoice_due_date as 'Due Date',
		invoice_total as 'Invoice Total',
        (invoice_total*.10) as '10%',
        (invoice_total*1.10) as 'Plus 10%'
		FROM invoices
        WHERE ((invoice_total) >= 500) AND ((invoice_total) <= 1000)
        ORDER BY invoice_due_date DESC;
        
