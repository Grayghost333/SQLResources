/*
********************************************************************************
CIS 335
CHAPTER 12 HOMEWORK

Filename: chapter12Homework.sql
Created: November 5, 2017
Assignment:  Exercises 1 through 4, Murach's MySQL, p. 370.

Author:  Martin Dwyer
********************************************************************************
*/

USE ap;

/******************************************************************************/
-- Exercise 1

CREATE OR REPLACE VIEW open_items AS
    SELECT
        vendor_name,
        invoice_number,
        invoice_total,
        (invoice_total - payment_total - credit_total) as 'balance_due'
    FROM
        invoices
            INNER JOIN
        vendors ON invoices.vendor_id = vendors.vendor_id
    WHERE
        (invoice_total - payment_total - credit_total) > 0
    ORDER BY vendor_name
;

/******************************************************************************/
-- Exercise 2

SELECT
    vendor_name, invoice_number, invoice_total, balance_due
FROM
    open_items
WHERE
    balance_due >= 1000
;

/******************************************************************************/
-- Exercise 3

CREATE OR REPLACE VIEW open_item_summary 
as
    SELECT
        vendor_name,
        count(*) as 'open_item_count',
        sum(balance_due) as 'open_item_total'
    FROM
        open_items
    GROUP BY vendor_name
    ORDER BY open_item_total DESC
;

/******************************************************************************/
-- Exercise 4

SELECT
    vendor_name, open_item_count, open_item_total
FROM
    open_item_summary
LIMIT 5
;
