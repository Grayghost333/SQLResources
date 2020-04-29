/*
********************************************************************************
CIS 335
CHAPTER 15 HOMEWORK

Filename: chapter152Homework.sql
Created: November 16, 2017
Assignment:  Exercises 1 through 4, Murach's MySQL, p. 443.

Author:  Martin Dwyer
/******************************************************************************/
USE ap;

-- Exercise 1
-- Reference:  See format for procedure below on p. 433


DROP PROCEDURE IF EXISTS insert_glaccount;

DELIMITER //

CREATE PROCEDURE insert_glaccount 
(
	account_number_par INT, 
	account_description_par VARCHAR(50)
)
BEGIN

	INSERT INTO general_ledger_accounts
	VALUES 
	(
		account_number_par, 
		account_description_par
	);

END//

-- The procedure correctly identifies the following duplicate account number.
CALL insert_glaccount(632,'Local Taxes');

-- The procedure successfully adds the following record to the table. 
CALL insert_glaccount(633,'Crazy Big Bonus');


/******************************************************************************/

-- Exercise 2
-- Reference:  See general format for procedure below on p. 437.  For the 
-- NOT FOUND continue handler, see pp. 390-397.

use ap;

DELIMITER //

CREATE FUNCTION test_glaccounts_description
(
				testing_account_description
)
RETURNS INT

BEGIN
	DECLARE test_description_result INT DEFAULT 0;
	DECLARE none_found BOOLEAN DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET none_found = TRUE;

SELECT 1
	INTO test_description_result
	FROM general_ledger_accounts
	WHERE testing_account_description = account_description;

RETURN test_description_result;

IF none_found = FALSE THEN
	IF test_description_result = 1 THEN
		RETURN 1;
	ELSE 
		RETURN 0;
	END IF;
END IF;

END;

DELIMITER ;

-- The following SELECT correctly returns a message of "1" for duplicate
-- because 'Sales Tax' is an existing account desciription.
SELECT test_glaccounts_description('Sales Tax') AS message;

-- The following SELECT correctly returns a message of "0" because 
-- 'Pickles' is not an existing account description.
SELECT test_glaccounts_description('Pickles') AS message;


/******************************************************************************/
-- Exercise 3
-- Reference:  See  pp. 422 to 425 for discussion of SIGNAL SQLSTATE and 
-- setting MYSQL_ERRNO.

USE ap;

DROP PROCEDURE IF EXISTS insert_glaccount_with_test;

DELIMITER //

CREATE PROCEDURE insert_glaccount_with_test 
(
	account_number_par INT, 
	account_description_par VARCHAR(50)
)

BEGIN
	IF test_glaccounts_description(account_description_par) = 1 THEN 
		SIGNAL SQLSTATE '23000'
		SET MYSQL_ERRNO = 1062, 
		MESSAGE_TEXT = 'Duplicate account description';
	ELSE
		INSERT INTO general_ledger_accounts
		VALUES 
		(
			account_number_par, 
			account_description_par
		);	
	END IF;

END//

DELIMITER ;

-- The procedure successfully adds the following record to the table. 
CALL insert_glaccount_with_test(633,'Crazy Big Bonus');

-- The procedure correctly identifies the following duplicate account number.
CALL insert_glaccount_with_test(632,'Local Taxes');

/******************************************************************************/
-- Exercise 4. 
 
USE ap;

DROP PROCEDURE IF EXISTS insert_terms;

DELIMITER //

CREATE PROCEDURE insert_terms 
(	
		terms_description_par VARCHAR(50),
		terms_due_days_par INT
)

BEGIN
	DECLARE sql_error BOOLEAN DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
		
	IF terms_description_par IS NULL THEN 
		SET terms_description_par = CONCAT('Net due ',terms_due_days_par,' days');
	END IF;

	INSERT INTO terms
		VALUES 
		(
			default,
			terms_description_par,
            terms_due_days_par
		);

	IF sql_error = FALSE then 
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;

END//

DELIMITER ;

-- The following CALL statements correctly insert the appropriate terms and days
CALL insert_terms('My Cousin Vinnie Style',90);
CALL insert_terms('Corporate America Way',180);
CALL insert_terms('How Uncle Sam Pays',360);
CALL insert_terms(NULL,540);


	
	


