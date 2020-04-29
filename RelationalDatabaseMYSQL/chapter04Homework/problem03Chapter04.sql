-- File Name: 		problem03Chapter04.sq1
-- Date: 			September 13, 2017
-- Author:			Martin Dwyer
-- Description:		This script selects vendors by name and provides the general ledger 
--             		account number and description.  

USE ap;

SELECT 	v.vendor_name AS 'Vendor Name', 
		v.default_account_number AS 'Account', 
		g.account_description AS 'Description'
		FROM vendors v
		JOIN general_ledger_accounts g
		ON v.default_account_number = g.account_number
		ORDER BY g.account_description;
        
