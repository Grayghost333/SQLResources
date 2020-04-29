/*
File Name: 		chapter08Homework01.sq1
Date: 			2017-10-03
Author:			Martin Dwyer
Description:	This file contains solutions to exercises 1
				p. 239 from Murach's MySQL, 2nd Edition.
*/
/*
Solution 1:
The following script offers a SELECT statement that returns the invoice_total
column in its database form, the invoice_total formatted as a decimal with one 
place on the right hand of the decimal point, the invoice_total converted to an 
integer, and invoice total cast as an integer. 
*/

USE ap;
SELECT
   invoice_total,
   FORMAT(invoice_total, 1) AS 'Formatted',
   CONVERT(invoice_total, Signed Int) AS 'Integer_Converted',
   CAST(invoice_total AS Signed Int) AS 'Integer_Cast' 
FROM
   invoices ;

