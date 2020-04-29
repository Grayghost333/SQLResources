-- File Name:  	chapter03Problem06.sq1
-- Date: 		September 04, 2017
-- Author:		Martin Dwyer
-- Description:	This script returns three columns from the vendors table and orders them by last name and first name.

USE ap;

SELECT 	vendor_name, 
		vendor_contact_last_name, 
		vendor_contact_first_name 
		FROM vendors
        ORDER BY vendor_contact_last_name,vendor_contact_first_name;
        
