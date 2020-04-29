/*
File Name: 		chapter07HomeworkProblem08.sq1
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
   JOIN
      (
         SELECT
            vendor_id,
            MIN(invoice_date) AS 'oldest_invoice' 
         FROM
            invoices 
         GROUP BY
            vendor_id 
      ) dTable 
      ON i.vendor_id = dTable.vendor_id 
      AND i.invoice_date = dTable.oldest_invoice 
ORDER By
   invoice_date ;


