/*
********************************************************************************
CIS 335
CHAPTER 11 HOMEWORK

Filename: chapter11Homework.sql
Created: November 2, 2017
Assignment:  Exercises 1 through 5, Murach's MySQL, p. 351.

Author:  Martin Dwyer

Problem #1: Write a script that adds an index to the AP database for the 
zip code field in the Vendors table. 
********************************************************************************
*/

USE ap;

CREATE INDEX vendors_vendor_zip_code_ix 
	ON vendors (vendor_zip_code);
    
-- see p. 329 of text for index syntax

/*
********************************************************************************
Problem #2: Write script that contains the CREATE TABLE statements needed to 
implement the structure outlined for the members, members_groups and groups 
tables in the EX database.
********************************************************************************
*/
USE ex;

DROP TABLE IF EXISTS members;
CREATE TABLE members 
(member_id INT PRIMARY KEY AUTO_INCREMENT COMMENT  'Unique identifier for members'
,first_name VARCHAR(30) NOT NULL COMMENT 'First name of member'
,last_name VARCHAR(30) NOT NULL COMMENT 'Last name of member'
,address VARCHAR(75) NOT NULL COMMENT 'Street address for member'
,city VARCHAR(75) NOT NULL COMMENT 'City of residence'
,state CHAR(2) COMMENT 'Two letter State abbreviation'
,phone VARCHAR(12) COMMENT 'Phone number entered as xxx-xxx-xxxx'
); 

DROP TABLE IF EXISTS groups;
CREATE TABLE groups 
(group_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'unique identifier for group'
,group_name VARCHAR(100) NOT NULL COMMENT 'Full name of group'
);

DROP TABLE IF EXISTS members_groups;
CREATE TABLE members_groups
(member_id INT NOT NULL COMMENT 'References members.member_id'
,group_id INT NOT NULL COMMENT 'References groups.group_id',
  CONSTRAINT pk_members_groups 
	PRIMARY KEY (member_id,group_id),
  CONSTRAINT fk_member_id 
	FOREIGN KEY (member_id) REFERENCES members (member_id), 
  CONSTRAINT fk_group_id 
	FOREIGN KEY (group_id) REFERENCES groups (group_id)
-- Each foreign key constraint applies back to the table where the data point
-- serves as primary key. 
);

/*
********************************************************************************
Problem #3: Write INSERT statements to add rows to the tables that were created
in exercise 2.
********************************************************************************
*/
USE ex;

INSERT INTO members
	(first_name,last_name,address,city,state,phone)
VALUES 
	('Fred','Flintstone','758 Rockingham','Bedrock','NM','748-520-4692')
	,('Barney','Rubble','756 Rockingham','Bedrock','NM','748-561-3255')
;

SELECT * FROM members;

INSERT INTO groups
	(group_name)
VALUES 
	('Loyal Order of the Water Buffalo')
	,('Bedrock Bowling League')
;

SELECT * FROM groups;

INSERT INTO members_groups
	(member_id,group_id)
VALUES
	(1,2)
	,(2,1)
	,(2,2)
	,(1,1)
;

SELECT * FROM members_groups;

SELECT 	groups.group_name AS 'Group_Name'
		,members.last_name AS 'Last_Name'
        ,members.first_name AS 'First_Name'
FROM members
	JOIN members_groups
		ON members.member_id = members_groups.member_id
	JOIN groups
		ON members_groups.group_id = groups.group_id
ORDER BY Group_Name, Last_Name, First_Name
;
/*
********************************************************************************
Problem #4: Write and ALTER TABLE statement that adds two new columns to the 
members table created in exercise 2.
********************************************************************************
*/
ALTER TABLE members
  ADD annual_dues DECIMAL(5,2) DEFAULT 52.50 COMMENT 'Annual membership dues'
  ,ADD payment_date DATE COMMENT 'Date membership dues last paid'
;

SELECT * FROM members;
/*
********************************************************************************
Problem #5: Write ALTER TABLE statement that modifies the groups table created 
in exercise 2 so the group name in each row has to be unique.  Then us an INSERT
statement to attemtp to insert a duplicate name, which should fail.
********************************************************************************
*/
ALTER TABLE groups
	MODIFY group_name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Full group name'
;

INSERT INTO groups 
	(group_name)
VALUES 
	('Bedrock Bowling League')
;

