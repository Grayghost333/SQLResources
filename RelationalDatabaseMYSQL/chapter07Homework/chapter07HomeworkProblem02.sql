/*
File Name: 		chapter07HomeworkProblem02.sq1
Date: 			2017-10-03
Author:			Martin Dwyer
Description:	This file contains solutions to exercise 2 
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
   invoice_number,
   invoice_total
FROM
   invoices 
WHERE
   payment_total >
   (
      SELECT
         AVG(payment_total) 
      FROM
         invoices
	  WHERE 
		 payment_total > 0
	)
ORDER BY
   invoice_total DESC ;