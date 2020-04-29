-- File Name: 	problem01Chapter04.sq1
-- Date: 		September 13, 2017
-- Author:		Martin Dwyer
-- Description:	This script returns the vendors table inner-joined with all columns from the invoices table.

USE ap;

SELECT 	*
		FROM vendors
		JOIN invoices
		ON vendors.vendor_id = invoices.vendor_id;  
        
