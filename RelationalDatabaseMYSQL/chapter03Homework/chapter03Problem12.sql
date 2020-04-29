-- File Name:  	chapter03Problem12.sq1
-- Date: 		September 04, 2017
-- Author:		Martin Dwyer
-- Description:	This script selects principal balance and interest rate;
-- 				calculates and returns principal plus interest.

SELECT 	50000 as starting_principal,
		(50000*0.065) as interest,
        (50000*1.065) as principal_plus_interest;