/*
File Name: 		chapter06Homework.sq1
Date: 			2017-09-05
Author:			Martin Dwyer
Description:	This file contains solutions to exercises 1,3,4,5,6,7, 
				pp. 184-185 from Murach's MySQL, 2nd Edition.
*/

USE ap;

/*
Exercise 1: The following script offers a SELECT statement that 
returns one row for each vendor in the invoices table that contains two 
columns; (1) the vendor_id, and (2) the sum of invoice totals for that 
vendor.
*/

SELECT 	v.vendor_id,
		SUM(i.invoice_total)
		FROM 	vendors v
		JOIN 	invoices i
		ON 		v.vendor_id = i.vendor_id
		GROUP BY v.vendor_id DESC
        ;
          
/*
Exercise 3: The following script provides a SELECT statement that retuns one 
row for each vendor that contains vendor_name, the count of invoices for each 
vendor, and the sum of the invoice totals for each vendor.
*/

SELECT 	v.vendor_id,
		COUNT(i.invoice_total) AS "invoices_count",
		SUM(i.invoice_total) AS "invoices_total"
		FROM 	vendors v
		JOIN 	invoices i
		ON 		v.vendor_id = i.vendor_id
		GROUP BY v.vendor_id
		ORDER BY invoices_count DESC
		;
        
/*
Exercise 4: The following script provides a SELECT statement that retuns one 
row for each general ledger account number, the count and sum of invoice totals
for that account.  
*/

SELECT 	gl.account_description,
		COUNT(i.invoice_id) AS "invoices_count",
		SUM(i.line_item_amount) AS "invoices_total"
		FROM 		general_ledger_accounts gl
		JOIN 		invoice_line_items i
		ON 			gl.account_number = i.account_number
		GROUP BY 	gl.account_number
        HAVING 		invoices_count > 1
        ORDER BY 	invoices_total DESC
		;

/*
Exercise 5: The following script provides a SELECT statement that retuns one 
row for each general ledger account number, the count and sum of invoice totals
for that account, limited to invoices betwen April 1, 2014 and June 30, 2014.  
*/

SELECT 	gl.account_description,
		COUNT(i.invoice_id) AS "invoices_count",
		SUM(i.line_item_amount) AS "invoices_total"
		FROM 		general_ledger_accounts gl
		JOIN 		invoice_line_items i
		ON 			gl.account_number = i.account_number
        JOIN		invoices inv
        ON			i.invoice_id = inv.invoice_id
        WHERE		inv.invoice_date BETWEEN '2014-04-01' AND '2014-06-30'
		GROUP BY 	gl.account_number
        HAVING 		invoices_count > 1
        ORDER BY 	invoices_total DESC
		;
 
/*
Exercise 6: The following script provides a SELECT statement that determines
the total amount invoices for each general ledger account number, and provides
a total of all invoices in the last row.
*/

SELECT 	i.account_number,
		SUM(i.line_item_amount) AS "invoices_total"
		FROM 		invoice_line_items i
        GROUP BY 	i.account_number WITH ROLLUP
		;
        
-- *****************************************************************************

/*
Exercise 7: The following script provides a SELECT statement that retuns the 
identity of vendors who are being paid from more than one account, identifying
also the number of accounts they are being paid from.
*/

SELECT 	v.vendor_name,
		COUNT(DISTINCT li.account_number) AS "accounts_total"
		FROM 		vendors v
        JOIN 		invoices i
        ON			v.vendor_id = i.vendor_id
        JOIN 		invoice_line_items li
        ON			i.invoice_id = li.invoice_id
        GROUP BY 	v.vendor_name
        HAVING 		accounts_total > 1
        ORDER BY 	v.vendor_name 
		;
        
