-- File Name:  	chapter03Problem11.sq1
-- Date: 		September 04, 2017
-- Author:		Martin Dwyer
-- Description:	This script selects and returns the current date; reformats 
-- 				and returns the date in 'mm-dd-yyyy' format.

SELECT 	CURRENT_DATE as 'current_date',
		DATE_FORMAT(CURRENT_DATE,'%m-%d-%Y') as 'mm-dd-yyyy';