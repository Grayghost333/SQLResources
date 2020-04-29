-- File Name: 		problem07Chapter04.sq1
-- Date: 			September 13, 2017
-- Author:			Martin Dwyer
-- Description:		This script selects vendors by name that are in the state of California.
--             		And selects separately all vendors outside of California.  The lists are
-- 					pulled together to identify the vendor State as 'CA' or 'Outside CA'

USE ap;

SELECT 	vendor_name, 
		vendor_state
		FROM 	vendors
		WHERE 	vendor_state = 'CA'

UNION

SELECT 	vendor_name,
		'Outside CA'
		FROM 	vendors
		WHERE 	vendor_state != 'CA'

ORDER BY vendor_name;