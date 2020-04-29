-- File Name: 		problem05Chapter04.sq1
-- Date: 			September 13, 2017
-- Author:			Martin Dwyer
-- Description:		This script selects vendors by name and contact name. The contact
--             		name is provided a full name (first and last).  One row is provided for
-- 					each vendor whose contact has a same last name as another vendor's 
-- 					contact.

USE ap;

SELECT 	v1.vendor_id,
		v1.vendor_name, 
        CONCAT(v1.vendor_contact_first_name, " ", v1.vendor_contact_last_name) AS 'contact_name' 
		FROM 	vendors v1
		JOIN 	vendors v2
		ON 		v1.vendor_contact_last_name = v2.vendor_contact_last_name AND
                v1.vendor_id != v2.vendor_id
		ORDER BY v1.vendor_contact_last_name
		;
          