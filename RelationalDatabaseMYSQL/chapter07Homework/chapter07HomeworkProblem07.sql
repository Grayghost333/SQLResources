/*
File Name: 		chapter07HomeworkProblem07.sq1
Date: 			2017-10-03
Author:			Martin Dwyer
Description:	This file contains solutions to exercise 7 
				p. 213 from Murach's MySQL, 2nd Edition.
Note:			Formatting of script completed with help of freeformatter.com
*/
/******************************************************************************/
/*
Solution:
The script below provides one row per vendor, representing the vendor's oldest 
inovice.  Each row includes vendor_name, invoice_number, invoice_date, and 
invoice_total.
*/

USE ap;

SELECT
   v.vendor_name,
   i.invoice_number,
   i.invoice_date,
   i.invoice_total 
FROM
   invoices i 
   JOIN
      vendors v 
      ON i.vendor_id = v.vendor_id 
WHERE
   invoice_date <= 
   (
      SELECT
         MIN(invoice_date) 
      FROM
         invoices 
      WHERE
         vendor_id = i.vendor_id
   )
ORDER By
   invoice_date ;
