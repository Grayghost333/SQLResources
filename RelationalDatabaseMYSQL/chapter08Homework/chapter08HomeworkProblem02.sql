/*
File Name: 		chapter08HomeworkProblem02.sq1
Date: 			2017-10-03
Author:			Martin Dwyer
Description:	This file contains solutions to exercise 2
				p. 239 from Murach's MySQL, 2nd Edition.
*/


/*
Solution 2:
The following script returns the invoice_date column, a column that casts the 
invoice_date column with its full date and time, and a column that casts 
the invoice_date with just the year and month.
**/

USE ap;
SELECT
   invoice_date,
   CAST(invoice_date AS DATETIME) AS 'DATE_CAST',
   CAST(invoice_date AS char(7)) AS 'Year-Month' 
FROM
   invoices ;

