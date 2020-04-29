/*
File Name: 		chapter07HomeworkProblem04.sq1
Date: 			2017-10-03
Author:			Martin Dwyer
Description:	This file contains solutions to exercise 4 
				p. 212 from Murach's MySQL, 2nd Edition.
Note:			Formatting of script completed with help of freeformatter.com
*/
/******************************************************************************/
/*
Solution:
The following script offers a SELECT statement answers the question of which 
invoices have a payment total that's greater than the average payment total 
for all invoices with a payment total greater than zero. 
*/


USE ap;
SELECT
   v.vendor_name,
   i.invoice_id,
   l.invoice_sequence,
   l.line_item_amount 
FROM
   vendors v 
   JOIN
      invoices i 
      ON v.vendor_id = i.vendor_id 
   JOIN
      invoice_line_items l 
      ON l.invoice_id = i.invoice_id 
WHERE
   i.invoice_id IN 
   (
      SELECT DISTINCT
         l1.invoice_id 
      FROM
         invoice_line_items l1 
      WHERE
         l1.invoice_sequence > 1 
   )
ORDER BY
   vendor_name ;

