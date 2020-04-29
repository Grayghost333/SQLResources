/*
File Name: 		chapter07HomeworkProblem05.sq1
Date: 			2017-10-03
Author:			Martin Dwyer
Description:	This file contains solutions to exercise 5 
				p. 213 from Murach's MySQL, 2nd Edition.
Note:			Formatting of script completed with help of freeformatter.com
*/
/******************************************************************************/
/*
Solution:
Two selct statements; (1) returns vendor_id and the largest unpaid invoice for 
each vendor, and (2) a select statement that returns the sum of the largest 
unpaid invoices for each vendor. 
*/


/*  Part One */

USE ap;
SELECT
   vendor_id,
   MAX(invoice_total) AS 'max_invoice' 
FROM
   invoices 
WHERE
   (invoice_total - credit_total - payment_total) > 0 
GROUP BY
   vendor_id ;

/*  Part Two  */

SELECT
   SUM(max_invoice) AS 'Total of Max Invoices' 
FROM
   (
      SELECT
         vendor_id,
         MAX(invoice_total) AS 'max_invoice' 
      FROM
         invoices 
      WHERE
         (invoice_total - credit_total - payment_total) > 0 
      GROUP BY
         vendor_id
   ) alias ;


