/*
File Name: 		chapter07HomeworkProblem01.sq1
Date: 			2017-10-03
Author:			Martin Dwyer
Description:	This file contains solutions to exercise 1 
				p. 212 from Murach's MySQL, 2nd Edition.
Note:			Formatting of script completed with help of freeformatter.com
*/
/******************************************************************************/
/*
Solution:
The following script offers a SELECT statement that provides alternative for a 
select statement using the JOIN clause.  
*/

USE ap;
SELECT
   vendor_name 
FROM
   vendors 
WHERE
   vendor_id IN 
   (
      SELECT
         vendor_id 
      FROM
         invoices
   )
ORDER BY
   vendor_name ;