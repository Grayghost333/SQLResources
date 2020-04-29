/*
CIS 335                   
FINAL PROJECT               
BOOK STORE DATABASE          
							   
Filename: book_store_create.sql
Created: December 2, 2017

Author:  Martin Dwyer
/*/

-- Script to create database book_store
DROP DATABASE IF EXISTS book_store;
CREATE DATABASE IF NOT EXISTS book_store;
USE book_store;

-- Script to create table book_type and insert data
DROP TABLE IF EXISTS book_type;
CREATE TABLE IF NOT EXISTS book_type 
(
	type_id INT NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for type',
	type_description VARCHAR(50) NOT NULL COMMENT 'Description of type (e.g. non-fiction or fiction etc.)',
  
	PRIMARY KEY (type_id)
)
COMMENT = 'Table for book type values eg fiction or nonfiction';

INSERT INTO book_type
	(type_description)
VALUES 
('Fiction'),
('Non-Fiction')
;
SELECT * FROM book_type;

-- Script to create table book_genre and insert data
DROP TABLE IF EXISTS book_genre;
CREATE TABLE IF NOT EXISTS book_genre 
(
	genre_id INT NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for genre',
	genre_description VARCHAR(50) NOT NULL COMMENT 'Description of genre (e.g. sports, science, etc.)',
  
	PRIMARY KEY (genre_id)
)
COMMENT = 'Table to hold book genre information';

INSERT INTO book_genre
	(genre_description)
VALUES 
('Action and Adventure'),
('Anthology'),
('Art'),
('Autobiographies'),
('Biographies'),
('Children'),
('Comics'),
('Cookbooks'),
('Diaries'),
('Dictionaries'),
('Drama'),
('Encyclopedias'),
('Fantasy'),
('Guide'),
('Health'),
('History'),
('Horror'),
('Journals'),
('Math'),
('Mystery'),
('Poetry'),
('Prayer books'),
('Religion and Spirituality'),
('Romance'),
('Satire'),
('Science'),
('Self help'),
('Sports'),
('Travel'),
('Trilogy')
;
SELECT * FROM book_genre;

-- Script to create and insert postal code data
DROP TABLE IF EXISTS postal;
CREATE TABLE IF NOT EXISTS postal 
(
	postal_code INT NOT NULL COMMENT 'Unique identifier for postal code',
	city VARCHAR(50) NOT NULL COMMENT 'City where postal code is located',
	state VARCHAR(50) NOT NULL COMMENT 'State where postal code is located',
  
	PRIMARY KEY (postal_code)
  )
COMMENT = 'Postal Code Data';

INSERT INTO postal
	(postal_code, city, state)
VALUES 
('52401','Cedar Rapids', 'Iowa'),
('52402','Cedar Rapids', 'Iowa'),
('52403','Cedar Rapids', 'Iowa'),
('52404','Cedar Rapids', 'Iowa'),
('52405','Cedar Rapids', 'Iowa'),
('52406','Cedar Rapids', 'Iowa'),
('52407','Cedar Rapids', 'Iowa'),
('52408','Cedar Rapids', 'Iowa'),
('52409','Cedar Rapids', 'Iowa'),
('52410','Cedar Rapids', 'Iowa'),
('52411','Cedar Rapids', 'Iowa'),
('52497','Cedar Rapids', 'Iowa'),
('52498','Cedar Rapids', 'Iowa'),
('52499','Cedar Rapids', 'Iowa'),
('52333','Solon', 'Iowa'),
('52240','Iowa City', 'Iowa'),
('52242','Iowa City', 'Iowa'),
('52243','Iowa City', 'Iowa'),
('52244','Iowa City', 'Iowa'),
('52245','Iowa City', 'Iowa'),
('52246','Iowa City', 'Iowa'),
('52241','Coralville', 'Iowa'),
('52317','North Liberty', 'Iowa'),
('52314','Mount Vernon', 'Iowa'),
('52253','Lisbon', 'Iowa'),
('52306','Mechanicsville', 'Iowa'),
('52772','Tipton', 'Iowa'),
('52302','Marion', 'Iowa'),
('52233','Hiawatha', 'Iowa'),
('52228','Fairfax', 'Iowa'),
('52351','Walford', 'Iowa'),
('52324','Palo', 'Iowa'),
('52206','Atkins', 'Iowa'),
('52328','Robins', 'Iowa'),
('10001','New York','New York'),
('94106','San Francisco','California'),
('75001','Dallas','Texas'),
('30301','Atlanta','Georgia'),
('01841','Boston','Massachusetts')
;
select * from postal;

-- Script to create people table and insert related data
DROP TABLE IF EXISTS people;
CREATE TABLE IF NOT EXISTS people 
(
	people_id INT NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for people',
	people_first_name VARCHAR(50) NOT NULL COMMENT 'Person first name',
	people_last_name VARCHAR(50) NOT NULL COMMENT 'Person last name',
	people_address1 VARCHAR(75) NOT NULL COMMENT 'Street address for person',
	people_address2 VARCHAR(75) NULL COMMENT 'Street address for person',
	people_email_address VARCHAR(75) NULL COMMENT 'Email address for person',
	people_postal_code INT NOT NULL COMMENT 'references postal.postal_code',

	PRIMARY KEY (people_id),

	CONSTRAINT fk_postal_code
		FOREIGN KEY (people_postal_code)
		REFERENCES postal (postal_code)
			ON DELETE RESTRICT
			ON UPDATE CASCADE
)
COMMENT = 'Table to hold people data';

-- People data obtained through generatedata.com
INSERT INTO people
	(people_first_name,people_last_name,people_address1,people_address2,people_email_address,people_postal_code) 
VALUES 
    ("Travis","French","5042 Est. Road","818-9181 Ipsum Street","ante.blandit@dolorelitpellentesque.edu","01841"),
    ("Amanda","Lloyd","P.O. Box 403, 860 Est. Avenue","Ap #413-5401 Malesuada. Rd.","Etiam.laoreet.libero@sedtortor.org","10001"),
    ("Lee","Henry","844-4799 Scelerisque Avenue","588-531 Eu, St.","lectus@pretiumetrutrum.ca","30301"),
    ("Fitzgerald","Bean","Ap #334-6848 Senectus Av.","7060 Tristique Avenue","Lorem.ipsum.dolor@nequeMorbiquis.net","52206"),
    ("Walker","Bullock","P.O. Box 791, 8027 Nibh Avenue","P.O. Box 711, 9770 Nunc Rd.","lectus@vulputateullamcorper.org","52228"),
    ("Nyssa","Rojas","P.O. Box 917, 5852 Imperdiet Av.","Ap #183-9909 Cursus Rd.","orci.quis@ipsumSuspendisse.co.uk","52233"),
    ("Vera","Patton","413-5173 Sagittis Ave","Ap #476-1086 Lectus St.","orci@dictumeuplacerat.org","52240"),
    ("Eagan","Giles","5128 Etiam Rd.","876-2252 Etiam Street","ac.feugiat.non@luctus.co.uk","52241"),
    ("Myles","Sanchez","Ap #578-3986 Sed Road","2360 Dolor. Rd.","est.vitae@egestasa.co.uk","52242"),
    ("Curran","Turner","600-7508 Posuere Ave","5154 Mauris Street","Donec@ipsumprimisin.net","52243"),
	("Cailin","Sims","Ap #621-920 Quam Ave","3045 Luctus Ave","massa@placerat.co.uk","52244"),
    ("Beck","Singleton","128-3562 Metus Street","2401 Penatibus Rd.","lorem@ultricesaauctor.com","52245"),
    ("Walter","Martin","Ap #505-6390 Commodo Rd.","7550 Erat. Avenue","amet.massa@egestas.ca","52246"),
    ("Burton","Alexander","793 Aptent Avenue","Ap #976-181 Adipiscing Avenue","lectus.a@vestibulumnec.ca","52253"),
    ("Lionel","Dunn","4883 Aenean St.","683-7960 Et St.","egestas.ligula.Nullam@ipsum.org","52302"),
    ("Miriam","Randall","P.O. Box 596, 4354 Enim. Ave","P.O. Box 865, 7349 Metus Rd.","egestas@parturient.co.uk","52306"),
    ("Teagan","Mercer","148-4347 Donec Street","3112 Dignissim St.","hendrerit@etmagnis.net","52314"),
    ("Colby","Chan","Ap #177-6470 Consequat Rd.","Ap #587-3755 Blandit Rd.","nisl@pellentesquea.net","52317"),
    ("Erich","Colon","P.O. Box 874, 5388 In, Ave","P.O. Box 829, 6908 Turpis Street","ipsum.Donec@sem.com","52324"),
    ("Dane","Houston","Ap #572-8327 Sed Av.","Ap #229-8371 Mauris Av.","faucibus.Morbi.vehicula@Aliquam.net","52328"),
	("Zoe","Weiss","2266 Donec Avenue","7848 Donec St.","Proin.vel@arcuetpede.edu","52333"),
    ("Fredericka","Hoover","Ap #359-4543 Eleifend Ave","Ap #523-8668 Tellus Rd.","Donec.vitae.erat@Aeneaneuismodmauris.com","52351"),
    ("Ariana","Cohen","1274 Nunc Ave","7285 Fringilla Road","Sed.pharetra.felis@quispedeSuspendisse.ca","52401"),
    ("Ishmael","England","2297 Sed Rd.","P.O. Box 129, 7778 Sed, Ave","Sed.malesuada@sollicitudina.ca","52402"),
    ("Shana","Lindsey","426-195 Nunc. Avenue","Ap #339-3207 Sem, Ave","ipsum.non@sit.co.uk","52403"),
    ("Mollie","Savage","Ap #351-7600 Sociosqu Rd.","748-3175 Odio Rd.","justo.nec.ante@dolorsit.co.uk","52404"),
    ("Lev","England","5467 Donec St.","580-2869 Cursus St.","lacus.Etiam.bibendum@nibhsit.net","52405"),
    ("Rhoda","Pierce","157 Scelerisque Street","4301 Integer Av.","lacus.Aliquam@auctor.edu","52406"),
    ("Lois","Aguirre","P.O. Box 773, 1191 Vel, Road","Ap #954-4518 Amet, St.","elit.pretium.et@odioAliquamvulputate.net","52407"),
    ("Dillon","Sampson","P.O. Box 461, 6590 Bibendum Avenue","P.O. Box 387, 5624 Sed Road","libero.Morbi@eratinconsectetuer.com","52408"),
	("Troy","Reese","290-2096 Nec Ave","P.O. Box 832, 1707 Enim. Rd.","nisi.magna.sed@libero.com","52409"),
    ("Hayden","Scott","Ap #444-882 Cursus. Road","Ap #745-9871 Aliquam Rd.","lectus.pede@lectus.edu","52410"),
    ("Ignatius","Tyler","7709 Eget, Road","171-8998 Cursus. Avenue","blandit.at@diamDuismi.ca","52411"),
    ("Stacey","Mcconnell","P.O. Box 853, 695 Mauris Road","1251 Ornare, Av.","ligula@vestibulum.org","52497"),
    ("Stacy","Parks","Ap #776-6060 Augue St.","653-8773 Lorem, Rd.","sed@nonleoVivamus.co.uk","52498"),
    ("Randall","Wolf","P.O. Box 132, 1489 Turpis Road","2521 Eu St.","eu.dui@dignissimtemporarcu.com","52499"),
    ("Denise","Yates","P.O. Box 104, 7625 Aliquam, Avenue","P.O. Box 969, 5971 Nisi. Avenue","magna.Lorem.ipsum@aauctor.net","52772"),
    ("Devin","Hardin","P.O. Box 959, 9527 Lorem Avenue","435-322 Vulputate, Ave","odio@inaliquet.net","75001"),
    ("Regina","Massey","P.O. Box 387, 5473 Adipiscing Road","524-7797 Nunc St.","pharetra.Quisque@augueeutempor.org","94106"),
    ("Sage","Armstrong","P.O. Box 150, 3983 Primis Av.","2199 Eleifend Road","non@parturient.edu","94106"),
    ("Amal","Mccarty","P.O. Box 862, 5616 Aliquam St.","P.O. Box 492, 1023 Sem. St.","natoque.penatibus.et@aodiosemper.net","52401"),
    ("Carter","Day","P.O. Box 273, 3039 Nibh. Street","278-2941 Risus Avenue","consectetuer@mifringilla.org","52402"),
    ("Harlan","Robinson","Ap #918-9514 Aliquet Road","P.O. Box 501, 4660 Felis. Avenue","eget.ipsum@utquam.edu","52403"),
    ("Portia","Hall","Ap #209-1288 Tellus Av.","Ap #756-688 Tincidunt. Av.","Integer.urna@habitantmorbi.co.uk","52404"),
    ("Stella","Russell","481-6040 Eu, Rd.","976-6058 Massa. St.","eu.tellus.Phasellus@facilisisnonbibendum.com","52405"),
    ("Bruno","Rivers","703-724 Et Street","Ap #225-1874 Tincidunt, Av.","lorem.ut@cursusInteger.com","52404"),
    ("Isaac","Morin","524-6011 Arcu Road","Ap #466-2320 Fusce Rd.","ante.ipsum@sociisnatoquepenatibus.com","52406"),
    ("Dalton","Gentry","7677 Ac Rd.","Ap #107-2143 Rutrum, Street","vel@risusquisdiam.co.uk","52405"),
    ("Grace","Holmes","Ap #356-222 Curae; Street","Ap #757-7643 Sollicitudin Rd.","metus.facilisis@pedeultrices.edu","52404"),
    ("Yetta","Ryan","P.O. Box 687, 1393 Tellus Ave","P.O. Box 949, 156 Consequat St.","mus.Proin.vel@nisl.co.uk","52403")
;
SELECT * FROM people;

-- Script to create phone_type table and data
DROP TABLE IF EXISTS phone_type;
CREATE TABLE IF NOT EXISTS phone_type 
(
	phone_type_id INT NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for phone type',
    phone_type_description VARCHAR(15) NOT NULL COMMENT 'Description of phone type',
    
	PRIMARY KEY (phone_type_id)
)
COMMENT = 'Table for holding phone types';

INSERT INTO phone_type
	(phone_type_description)
VALUES
	("Home"),
    ("Business"),
    ("Cell Business"),
    ("Cell Personal")
;
SELECT * FROM phone_type;


-- Script to create table people_phone and related data
CREATE TABLE IF NOT EXISTS people_phone 
(
	people_id INT NOT NULL COMMENT 'References people.people_id',
	people_phone_number VARCHAR(20) NOT NULL COMMENT 'Person phone number',
	phone_type_id INT NOT NULL COMMENT 'references phone_type.phone_type_id',
	
    PRIMARY KEY (people_id, people_phone_number),

	CONSTRAINT fk_phone_type_lookup
		FOREIGN KEY (phone_type_id)
		REFERENCES phone_type (phone_type_id)
			ON DELETE RESTRICT
			ON UPDATE CASCADE
)
COMMENT = 'Table for people phone data.';

-- Data obtained through generatedata.com
INSERT INTO people_phone
	(people_id, people_phone_number,phone_type_id) 
VALUES 
	(19,"989-424-9251",3),
	(33,"223-348-9966",2),
	(48,"153-116-2011",3),
	(20,"126-406-1165",2),
	(27,"717-857-0971",4),
	(2,"203-475-2703",3),
	(47,"924-754-7766",4),
	(10,"155-631-5980",4),
	(48,"948-512-2301",4),
	(43,"564-514-6189",2),
	(39,"690-855-1585",1),
	(43,"724-638-2465",1),
	(31,"635-119-3781",3),
	(45,"163-470-6394",4),
	(39,"775-202-7886",2),
	(32,"621-341-6452",1),
	(11,"615-128-4121",4),
	(6,"284-811-4721",3),
	(2,"669-137-9302",4),
	(34,"650-645-6241",1),
	(2,"794-426-7450",2),
	(36,"643-119-6751",1),
	(37,"288-100-1365",3),
	(1,"656-886-0525",1),
	(47,"467-557-4784",2),
	(22,"651-818-4737",3),
	(9,"297-196-9525",1),
	(46,"629-223-1151",4),
	(19,"418-571-8888",2),
	(11,"704-833-1612",3),
	(50,"491-415-6185",2),
	(13,"345-399-4687",4),
	(18,"590-980-7806",3),
	(31,"494-399-6244",3),
	(19,"155-438-5456",4),
	(45,"269-175-9366",2),
	(15,"328-902-7395",1),
	(10,"331-167-1068",2),
	(13,"821-828-8291",3),
	(44,"315-963-8826",4),
	(40,"931-536-4171",1),
	(6,"218-307-9283",1),
	(25,"207-806-2012",3),
	(29,"590-961-5752",3),
	(33,"121-850-1007",4),
	(35,"580-218-7065",3),
	(49,"655-971-3030",1),
	(35,"789-648-5893",4),
	(14,"888-495-1647",1),
	(23,"897-342-4285",4),
	(1,"342-568-5305",2),
	(40,"241-426-3263",2),
	(41,"178-418-5448",4),
	(27,"946-228-6896",3),
	(43,"730-792-2740",1),
	(13,"339-982-1488",3),
	(28,"976-499-9445",4),
	(38,"756-822-3958",4),
	(18,"879-991-3659",1),
	(11,"913-173-6898",2),
	(46,"182-848-7888",4),
	(31,"796-651-0535",3),
	(8,"402-994-9461",1),
	(31,"933-477-2338",1),
	(22,"437-203-4421",4),
	(26,"570-140-8431",2),
	(1,"665-766-3801",4),
	(6,"979-361-2863",2),
	(44,"543-675-8374",2),
	(42,"856-429-5815",1),
	(19,"571-402-2757",2),
	(25,"490-233-4755",3),
	(24,"552-332-8955",3),
	(29,"364-676-2491",3),
	(44,"392-775-7599",3),
	(32,"174-432-6929",2),
	(9,"730-998-2933",4),
	(2,"166-381-1998",4),
	(19,"707-410-1362",3),
	(14,"762-108-8270",4),
	(36,"630-968-0443",4),
	(15,"669-220-4350",2),
	(2,"321-198-8261",3),
	(22,"377-803-4574",2),
	(27,"545-637-7154",2),
	(10,"939-633-6796",4),
	(27,"321-690-0832",4),
	(6,"819-586-6301",4),
	(37,"422-518-2817",1),
	(17,"599-761-9261",2),
	(38,"825-810-1024",1),
	(15,"789-487-3260",2),
	(7,"904-198-8991",1),
	(25,"151-369-7228",1),
	(7,"987-969-8157",3),
	(32,"432-221-7019",2),
	(13,"756-522-7387",2),
	(38,"211-139-5913",2),
	(44,"663-199-4362",4),
	(25,"483-275-9687",1)
;
SELECT * FROM people_phone;

-- Script to creat table publishers and related data
DROP TABLE IF EXISTS publishers;
CREATE TABLE IF NOT EXISTS publishers 
(
	publisher_id INT NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for publisher',
	publisher_name VARCHAR(50) NOT NULL COMMENT 'Name of the publisher',
	publisher_address1 VARCHAR(75) NOT NULL COMMENT 'Address1 for the publisher',
	publisher_address2 VARCHAR(75) NULL COMMENT 'Address2 for the publisher',
	publisher_phone VARCHAR(20) NOT NULL COMMENT 'Publisher main phone (\"999-999-9999\")',
	publisher_url VARCHAR(75) NULL COMMENT 'Publisher website location if exists',
	publisher_email_address VARCHAR(75) NULL COMMENT 'Publisher main email address if exists',
	publisher_postal_code INT NULL COMMENT 'References postal_code.postal_code',
	publisher_contact INT NULL COMMENT 'Publisher contact person: references people.people_id',

	PRIMARY KEY (publisher_id),

	CONSTRAINT fk_publisher_contact
		FOREIGN KEY (publisher_contact)
		REFERENCES people (people_id)
			ON DELETE RESTRICT
			ON UPDATE CASCADE,

	CONSTRAINT fk_publisher_postal_code
		FOREIGN KEY (publisher_postal_code)
		REFERENCES postal (postal_code)
			ON DELETE RESTRICT
			ON UPDATE CASCADE
)
COMMENT = 'Table for information related to publishers';

-- Data for business information obtained at generatedata.com
INSERT INTO publishers
	(publisher_name,publisher_address1,publisher_address2,publisher_phone,publisher_url,publisher_email_address,publisher_postal_code,publisher_contact)

VALUES
	("Dignissim Maecenas Ornare LLC","P.O. Box 480, 2806 Parturient Road","716-4322 Id Road","173-723-8049","non,","augue.eu@morbitristiquesenectus.edu",52406,1),
    ("Natoque LLC","501-2061 Aliquam St.","P.O. Box 277, 4309 At St.","401-350-8257","eu","eget.mollis@arcuMorbisit.co.uk",52405,2),
    ("Quam A Felis Ltd","Ap #209-861 Cursus Road","4931 Donec St.","592-646-3587","eros","et.magnis@acfeugiatnon.com",52404,3),
    ("Lobortis Ultrices Institute","5734 Risus. St.","591-973 Aliquet Ave","242-340-6275","justo","Sed@velarcu.ca",52404,4),
    ("Aliquet Molestie Ltd","P.O. Box 928, 8018 Nullam Rd.","P.O. Box 638, 7501 Elit Avenue","925-792-6248","Integer","nulla@quis.co.uk",52404,5),
    ("Donec LLP","981-6417 Placerat, St.","123-3676 Sed St.","217-704-0080","accumsan","penatibus.et@at.ca",52402,6),
    ("Euismod Et Commodo Consulting","P.O. Box 941, 366 Vitae Road","6437 Diam. Rd.","998-546-7292","Proin","placerat.eget@egestasblandit.edu",52402,7),
    ("Suspendisse Aliquet PC","163-4855 Fermentum Rd.","6145 Et Avenue","102-168-1454","malesuada","magna@orciquis.edu",52403,8),
    ("Nibh Enim Institute","913-5782 Dictum Road","681-3664 Nonummy. Rd.","114-461-3552","velit","Class.aptent@elit.org",52401,9),
    ("At LLC","P.O. Box 869, 5100 Id St.","P.O. Box 559, 587 Netus St.","290-501-7076","nulla.","Aenean@est.com",52401,10)
;

SELECT * FROM publishers;

-- Table `book_store`.`books`
DROP TABLE IF EXISTS books;
CREATE TABLE IF NOT EXISTS books 
(
	book_id INT NOT NULL AUTO_INCREMENT COMMENT 'Unique internal identifier for text',
	author VARCHAR(50) NOT NULL COMMENT 'Indicates author of the text',
	title VARCHAR(150) NOT NULL COMMENT 'indicates title of the text',
	type_id INT NOT NULL COMMENT 'References type.type_id',
	genre_id INT NOT NULL COMMENT 'References genre.genre_id',
	ISBN INT NULL COMMENT '13 digit number to uniquely identify text',
	publication_date DATE NULL COMMENT 'Date on which book was published',
	publisher_id INT NULL COMMENT 'References publisher.publisher_id',
	series VARCHAR(50) NULL COMMENT 'Identifies book series of which book is part',
	pages INT NOT NULL COMMENT 'Number of pages in the book',
	list_price DECIMAL(10,2) NOT NULL COMMENT 'Current list price of book',
	
    PRIMARY KEY (book_id),
	
    CONSTRAINT fk_book_type
		FOREIGN KEY (type_id)
		REFERENCES book_type (type_id)
			ON DELETE RESTRICT
			ON UPDATE CASCADE,
	
    CONSTRAINT fk_book_genre
		FOREIGN KEY (genre_id)
		REFERENCES book_genre (genre_id)
			ON DELETE RESTRICT
			ON UPDATE CASCADE,
	
    CONSTRAINT fk_book_publishers
		FOREIGN KEY (publisher_id)
		REFERENCES publishers (publisher_id)
			ON DELETE RESTRICT
			ON UPDATE CASCADE
)
COMMENT = 'Table for collection of book information';

-- Data obtained at generatedata.com
INSERT INTO books
	(author,title,type_id,genre_id,ISBN,publication_date,publisher_id,series,pages,list_price)

VALUES 
	("Eleanor V. Hopkins","Lorem ipsum dolor sit",1,5,980106462,"2015-03-15",3,"auctor.",433,"28.99"),
    ("Jin V. Rowland","Lorem ipsum dolor",1,11,85687353,"2001-05-17",1,"aliquet",546,"42.04"),
    ("Chaim K. Pena","Lorem ipsum",2,24,378696061,"2001-12-04",2,"Suspendisse",607,"31.18"),
    ("Byron J. Britt","Lorem",1,28,432621376,"2010-12-03",1,"orci",715,"12.33"),
    ("Kelsey H. Skinner","Lorem ipsum dolor sit",2,5,361908712,"2007-04-24",3,"velit.",495,"26.60"),
    ("Bianca Z. Huff","Lorem ipsum dolor",2,23,695306384,"2003-08-07",3,"metus.",413,"22.89"),
    ("Elaine G. Berger","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",1,11,690913606,"2015-12-24",5,"Cras",645,"89.02"),
    ("Zachary S. Montgomery","Lorem ipsum",2,30,146613671,"2006-08-06",10,"quis",474,"32.27"),
    ("Riley O. Knox","Lorem ipsum dolor",1,3,91747300,"2006-10-22",3,"consequat,",501,"2.66"),
    ("Callie P. Zamora","Lorem",1,10,637264306,"2005-03-26",6,"nisi",639,"69.59"),
    ("Moses E. Castro","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",2,28,630302979,"2014-03-04",3,"vulputate,",552,"81.62"),
    ("Isaiah Z. Thompson","Lorem ipsum",1,17,729390528,"2005-09-14",9,"per",492,"4.67"),
    ("Lilah A. Weeks","Lorem ipsum dolor sit amet, consectetuer",1,12,623186634,"2015-08-26",5,"id",703,"90.01"),
    ("Chaim R. Gentry","Lorem",2,15,546495472,"2002-05-08",8,"et",526,"47.49"),
    ("Serena K. Scott","Lorem ipsum dolor sit amet,",2,30,776663491,"2017-07-30",10,"erat",603,"90.28"),
    ("Abigail U. Cameron","Lorem ipsum dolor sit amet,",1,26,863166307,"2002-08-21",3,"nibh",500,"88.94"),
    ("Ira H. Underwood","Lorem ipsum dolor sit amet,",2,20,615207602,"2004-09-04",4,"fringilla",567,"84.62"),
    ("Lysandra L. Case","Lorem ipsum dolor sit amet, consectetuer adipiscing",1,29,589519430,"2002-01-11",7,"ultricies",517,"58.94"),
    ("Lee W. Simmons","Lorem ipsum dolor sit amet,",1,12,276540951,"2003-09-24",6,"at",503,"54.31"),
    ("Colorado Q. Schmidt","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",1,16,530817007,"2013-10-12",4,"Nullam",558,"39.06"),
    ("Libby O. Richardson","Lorem ipsum dolor sit amet, consectetuer adipiscing",2,9,558024032,"2009-03-31",9,"amet",594,"24.89"),
    ("Madeson C. Mullins","Lorem ipsum dolor sit",2,28,621794517,"1998-06-20",3,"Maecenas",434,"50.61"),
    ("Richard V. Tyler","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",2,15,572484349,"2005-04-09",5,"commodo",644,"95.55"),
    ("Acton K. Whitfield","Lorem ipsum dolor sit",1,4,936759579,"2012-05-27",2,"mauris.",467,"74.74"),
    ("Keane Q. Carr","Lorem ipsum",1,26,717806874,"2017-01-06",5,"justo",513,"55.28"),
    ("Guinevere B. Knowles","Lorem ipsum",1,24,235615630,"2013-11-21",4,"nunc",511,"17.37"),
    ("Blossom V. Wiley","Lorem ipsum dolor sit amet, consectetuer",1,6,205125882,"2016-06-03",4,"adipiscing",648,"45.91"),
    ("Celeste F. Woodward","Lorem",1,5,354640512,"2014-04-06",3,"odio.",618,"33.20"),
    ("Jenna C. Larsen","Lorem ipsum dolor sit",2,14,467595227,"2013-10-20",3,"dictum",525,"64.47"),
    ("Keith R. Rasmussen","Lorem ipsum dolor sit",2,26,460681633,"2008-10-23",8,"cubilia",712,"41.21"),
    ("Marah Y. Foster","Lorem ipsum dolor sit amet, consectetuer adipiscing",1,3,224168328,"2007-10-21",3,"imperdiet",425,"78.79"),
    ("Chase P. Sweeney","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",2,19,904184636,"2009-01-04",7,"Vestibulum",700,"37.12"),
    ("Ira G. Bennett","Lorem ipsum dolor sit amet, consectetuer",2,10,369882888,"2002-06-22",1,"sapien.",590,"98.17"),
    ("Aladdin N. Shelton","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",2,4,366567235,"2011-02-24",10,"magna.",695,"83.91"),
    ("Brynn T. Lynch","Lorem ipsum dolor sit amet, consectetuer",2,1,837579623,"2000-11-30",4,"metus",500,"7.72"),
    ("Anthony V. Ingram","Lorem ipsum dolor sit amet, consectetuer",1,9,263522602,"2012-11-04",5,"Cras",580,"8.21"),
    ("Giselle R. Sharp","Lorem ipsum dolor sit amet,",1,15,94608220,"2001-05-23",8,"Vivamus",658,"33.24"),
    ("Zia G. Solomon","Lorem ipsum dolor sit amet, consectetuer adipiscing",1,26,169594453,"2014-10-01",7,"lacus.",484,"82.50"),
    ("Matthew T. Keith","Lorem ipsum",1,27,903951052,"2011-06-06",8,"orci,",602,"4.07"),
    ("Gareth E. Mejia","Lorem ipsum dolor sit amet, consectetuer adipiscing",2,20,646353073,"1999-06-20",8,"tempus",612,"29.36"),
    ("Brock A. Todd","Lorem ipsum dolor sit",1,29,706663968,"2002-05-21",3,"lacinia",605,"47.84"),
    ("Demetrius K. Faulkner","Lorem ipsum dolor sit amet,",2,4,508169806,"2016-01-23",1,"morbi",540,"49.06"),
    ("Damon W. Blevins","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",1,5,838255022,"2014-11-06",9,"metus.",424,"84.56"),
    ("Thomas H. Cruz","Lorem ipsum",2,10,65523210,"2008-02-14",5,"quis",422,"85.72"),
    ("Cole X. Giles","Lorem ipsum dolor sit amet, consectetuer adipiscing",1,21,531600212,"2001-11-05",4,"pellentesque",408,"97.32"),
    ("Fletcher X. Brock","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",1,27,272686750,"1999-10-07",2,"non,",586,"33.93"),
    ("Marvin X. Vance","Lorem ipsum",1,24,92332041,"2012-10-18",1,"nunc",740,"12.05"),
    ("Irma H. Mcdaniel","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",2,23,549453065,"2012-09-08",3,"sagittis.",691,"81.20"),
    ("Ross J. Wong","Lorem ipsum dolor sit amet, consectetuer",1,10,833035353,"2007-01-01",4,"quis,",697,"64.72"),
    ("Neville Q. Johnston","Lorem ipsum dolor sit amet,",1,25,137186457,"2010-02-06",6,"Donec",453,"43.13"),
    ("Doris W. Adams","Lorem ipsum dolor sit amet,",1,30,300837395,"2004-09-11",10,"id,",410,"34.33"),
    ("Kelly S. Perez","Lorem",2,16,798117894,"1999-11-12",4,"Suspendisse",387,"23.12"),
    ("Ferdinand O. Holland","Lorem ipsum dolor sit",1,27,73303239,"2012-06-03",2,"neque",557,"99.49"),
    ("Zachery E. Richard","Lorem ipsum",2,3,484308831,"2015-04-20",1,"varius",545,"90.23"),
    ("Lillith Z. Hoover","Lorem ipsum dolor sit amet, consectetuer adipiscing",2,21,546754000,"2004-08-09",3,"egestas",564,"41.42"),
    ("Derek G. Guerra","Lorem ipsum",1,29,973423053,"2011-04-19",7,"dis",573,"54.09"),
    ("Lawrence Y. Zamora","Lorem ipsum dolor sit",2,10,571208740,"2009-08-27",2,"Duis",365,"53.79"),
    ("Xenos H. Todd","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",1,2,301104053,"2007-02-07",10,"fames",632,"47.59"),
    ("Althea X. Knapp","Lorem ipsum dolor sit amet,",2,25,372943773,"1998-02-17",8,"arcu",404,"99.84"),
    ("Rafael X. Gentry","Lorem ipsum dolor sit amet, consectetuer adipiscing",1,30,734213454,"2016-01-11",3,"Cras",620,"15.39"),
    ("Delilah A. Craig","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",2,11,535353454,"2002-10-23",6,"congue",454,"84.27"),
    ("Roth T. Blevins","Lorem ipsum dolor sit",1,16,192672269,"1997-11-13",2,"parturient",539,"30.05"),
    ("Mariko Q. Hood","Lorem ipsum",2,27,882846436,"1998-02-01",7,"Nullam",634,"79.27"),
    ("Grady L. Glenn","Lorem ipsum dolor",2,26,649698279,"2002-01-30",10,"purus,",563,"89.35"),
    ("William W. Whitfield","Lorem ipsum dolor sit amet, consectetuer adipiscing",1,14,641718323,"2004-08-28",2,"vestibulum.",673,"94.51"),
    ("Ursula I. Boyd","Lorem ipsum dolor sit amet, consectetuer",1,20,486078841,"2000-10-20",2,"molestie",356,"72.85"),
    ("Ignatius X. Peters","Lorem ipsum",1,13,893323090,"2009-04-01",3,"dui",623,"98.22"),
    ("Mara O. Hampton","Lorem ipsum dolor sit amet, consectetuer adipiscing",2,29,145289450,"2003-12-20",1,"Integer",635,"87.83"),
    ("Rowan B. Norris","Lorem ipsum dolor sit amet, consectetuer adipiscing",2,9,165386888,"2015-12-11",10,"nascetur",475,"64.84"),
    ("Hollee V. Clay","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",2,1,40376880,"2013-08-23",5,"Praesent",646,"61.79"),
    ("Adrienne V. Guthrie","Lorem ipsum dolor sit",1,11,454058112,"2011-02-12",10,"Nulla",549,"11.22"),
    ("Aladdin R. Holloway","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",1,19,607210663,"2001-06-28",1,"id,",606,"43.48"),
    ("Ariana R. Boyle","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",2,23,114436606,"2014-05-24",5,"sem",586,"57.37"),
    ("Xandra Q. Hood","Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",1,22,429017038,"2016-10-13",7,"faucibus",731,"83.75"),
    ("Gillian R. England","Lorem ipsum dolor",2,11,175224855,"2008-03-24",8,"luctus",537,"21.06"),
    ("Dorothy V. Norman","Lorem ipsum dolor sit amet, consectetuer adipiscing",2,3,524042812,"1998-03-11",7,"ante",655,"65.81"),
    ("Griffith X. Mckee","Lorem",2,19,625831356,"2013-08-12",3,"vulputate",614,"57.03"),
    ("Marah F. Donaldson","Lorem ipsum dolor sit",2,10,117573840,"2005-07-10",6,"vulputate,",355,"20.81"),
    ("Lila G. Zamora","Lorem ipsum dolor sit amet,",2,13,367761802,"2017-07-16",1,"ac,",719,"83.02"),
    ("Kenyon B. Hays","Lorem ipsum",2,8,109789672,"2002-02-07",7,"Nunc",437,"27.83"),
    ("Robin C. Elliott","Lorem ipsum dolor sit amet, consectetuer",2,27,829693404,"2007-06-30",9,"est",395,"48.10"),
    ("Knox V. Mueller","Lorem ipsum dolor sit amet,",2,27,305482786,"1999-12-14",3,"Suspendisse",444,"69.22"),
    ("Jorden W. Everett","Lorem ipsum dolor sit amet,",1,11,178478629,"2016-11-08",1,"sagittis",351,"12.55"),
    ("Gemma G. Cooper","Lorem ipsum dolor sit amet, consectetuer adipiscing",2,22,463776580,"1998-09-11",5,"et",665,"46.56"),
    ("Nora J. Brooks","Lorem ipsum dolor sit",2,28,913875784,"2014-11-24",4,"Donec",671,"67.41"),
    ("Raya F. Deleon","Lorem ipsum dolor sit amet,",2,13,458972591,"1998-10-26",2,"rhoncus.",403,"13.62"),
    ("Kasimir F. Gray","Lorem",2,15,566165282,"2001-05-06",7,"mi.",477,"79.72"),
    ("Mona B. Lynch","Lorem ipsum dolor",1,25,683946366,"1998-04-13",6,"non",415,"96.73"),
    ("Adrian H. Morales","Lorem ipsum dolor sit amet, consectetuer adipiscing",1,9,591233707,"2009-08-02",9,"luctus",691,"19.69"),
    ("Mary V. Meyers","Lorem ipsum dolor sit amet, consectetuer",1,30,343408255,"2007-07-03",1,"tellus,",707,"55.01"),
    ("Jane W. Ortiz","Lorem ipsum dolor",2,19,229395311,"2008-05-28",3,"Nulla",447,"56.27"),
    ("Germane C. Carrillo","Lorem ipsum dolor sit",1,13,157969695,"2016-10-16",9,"natoque",363,"17.80"),    ("Christine C. Bernard","Lorem ipsum dolor",1,21,311306706,"2013-06-15",5,"nascetur",481,"51.78"),
    ("Halla N. Landry","Lorem ipsum",2,20,386599362,"2005-07-23",7,"risus",450,"63.84"),
    ("Jason F. Cotton","Lorem ipsum dolor sit",2,26,380826018,"2005-06-11",2,"mauris,",413,"22.27"),
    ("Craig E. Green","Lorem ipsum dolor sit amet,",1,10,414800317,"1999-06-16",6,"Sed",746,"45.93"),
    ("Chloe E. Durham","Lorem ipsum",2,12,558811412,"2008-03-13",6,"hendrerit",519,"45.25"),
    ("Shafira B. Richmond","Lorem ipsum dolor sit",1,10,270897782,"2014-03-24",8,"ut",577,"42.92"),
    ("Imani R. Craig","Lorem ipsum dolor",1,17,399373335,"2008-10-28",2,"ultrices,",421,"17.77"),
    ("Morgan R. Waller","Lorem ipsum",2,16,320177282,"1999-09-29",10,"et",560,"49.09")
    ;

SELECT * FROM books;

-- Script to create table members and insert data therein
DROP TABLE IF EXISTS members;
CREATE TABLE IF NOT EXISTS members 
(
	member_id INT NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for members',
	people_id INT NOT NULL COMMENT 'References people.people_id',
	date_first_joined DATE NOT NULL COMMENT 'Date membership first established',
	date_last_renewal DATE NOT NULL COMMENT 'Date membership was last renewed',
	date_membership_expires DATE NOT NULL COMMENT 'Date membership expires',
	
    PRIMARY KEY (member_id),
	
    CONSTRAINT fk_members_people_id
        FOREIGN KEY (people_id)
		REFERENCES people (people_id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
)
COMMENT = 'Table for holding book club member data';

-- Data obtained at generatedata.com
INSERT INTO members
	(people_id,date_first_joined,date_last_renewal,date_membership_expires) 

VALUES 
	(32,"2002-06-24","2017-04-09","2018-01-11"),
    (31,"2009-10-02","2017-04-05","2018-04-30"),
    (30,"2001-02-17","2017-03-26","2018-01-06"),
    (29,"2014-03-20","2017-08-10","2018-04-01"),
    (28,"2016-01-01","2016-12-30","2018-07-30"),
    (27,"2015-06-02","2017-09-18","2018-01-10"),
    (26,"2004-05-30","2017-02-23","2018-03-11"),
    (25,"2002-11-15","2016-12-09","2018-05-25"),
    (24,"2011-08-26","2017-06-29","2018-04-10"),
    (23,"2009-01-30","2017-08-07","2018-02-08"),
	(22,"2001-11-24","2017-08-06","2018-07-06"),
    (21,"2009-07-31","2017-09-28","2018-11-03"),
    (20,"2007-04-09","2017-01-11","2018-09-20"),
    (19,"2006-11-30","2017-04-21","2018-10-23"),
    (18,"2011-09-25","2017-01-15","2018-04-22"),
    (17,"2006-02-13","2016-12-30","2018-07-10"),
    (16,"2000-09-13","2017-01-21","2018-02-23"),
    (15,"2015-11-26","2017-01-10","2018-01-05"),
    (14,"2002-03-10","2017-08-26","2018-11-23"),
    (13,"2002-08-02","2017-05-09","2018-11-12"),
	(12,"2010-11-11","2016-11-29","2018-05-04"),
    (11,"2002-04-10","2017-05-03","2018-06-06"),
    (10,"2014-11-19","2017-08-05","2018-11-08"),
    (9,"1999-09-27","2017-01-12","2018-08-13"),
    (8,"2014-10-07","2016-12-21","2017-12-29"),
    (7,"1999-09-05","2016-12-11","2017-12-10"),
    (6,"2003-05-12","2017-02-17","2018-08-16"),
    (5,"2016-05-22","2017-05-17","2017-12-11"),
    (4,"2011-04-09","2016-12-27","2018-01-06"),
    (3,"2015-04-08","2017-10-03","2018-03-22"),
	(2,"2012-12-25","2016-12-27","2018-11-21"),
    (1,"2014-09-23","2017-08-27","2018-01-22")
;

SELECT * FROM members;

-- Script to create table customers and insert data therein
DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers 
(
	customer_id INT NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for customer generated at first point of sale',
	people_id INT NOT NULL COMMENT 'references people.people_id',
	
    PRIMARY KEY (customer_id),
	
    CONSTRAINT fk_customers_people_id
		FOREIGN KEY (people_id)
		REFERENCES people (people_id)
			ON DELETE RESTRICT
			ON UPDATE CASCADE
)
COMMENT = 'Table to track data by customer';

INSERT INTO customers
	(people_id)
VALUES
	(1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10),
    (11),
    (12),
    (13),
    (14),
    (15),
    (16),
    (17),
    (18),
    (19),
    (20), 
    (21),
    (22),
    (23),
    (24),
    (25),
    (26),
    (27),
    (28),
    (29),
    (30),     
    (31),
    (32),
    (33),
    (34),
    (35),
    (36),
    (37),
    (38),
    (39),
    (40),
    (41),
    (42),
    (43)
;

SELECT * FROM customers;

-- Script to create table book_sales and insert data therein
DROP TABLE IF EXISTS book_sales;
CREATE TABLE IF NOT EXISTS book_sales 
(
	sale_id INT NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for book sale',
	sale_date DATE NOT NULL COMMENT 'Date of book sale',
	book_id INT NOT NULL COMMENT 'References books.book_id',
	customer_id INT NOT NULL COMMENT 'References customers.customer_id',
	discount_applied DECIMAL(3,2) NOT NULL COMMENT 'Discount applied at point of sale (20% = .20)',

	PRIMARY KEY (sale_id)
)
COMMENT = 'Table to track book sales';

-- Data obtained at generatedata.com
INSERT INTO book_sales (sale_date,book_id,customer_id,discount_applied) 

VALUES 
	("2017-08-17",33,8,"0.00"),
    ("2017-08-07",9,23,"0.00"),
    ("2017-07-23",66,1,"0.00"),
    ("2017-08-16",9,29,"0.00"),
    ("2017-06-30",70,26,"0.00"),
    ("2017-09-21",84,20,"0.00"),
    ("2017-09-12",55,1,"0.00"),
    ("2017-08-25",42,26,"0.00"),
    ("2017-07-18",53,17,"0.00"),
    ("2017-08-28",66,14,"0.00"),
    ("2017-09-15",89,11,"0.00"),
    ("2017-08-29",63,7,"0.00"),
    ("2017-08-03",38,26,"0.00"),
    ("2017-08-01",19,12,"0.00"),
    ("2017-08-24",42,27,"0.00"),
    ("2017-09-15",97,20,"0.00"),
    ("2017-07-01",22,36,"0.00"),
    ("2017-08-12",58,22,"0.00"),
    ("2017-09-30",43,21,"0.00"),
    ("2017-09-24",74,17,"0.00"),
    ("2017-08-08",12,18,"0.00"),
    ("2017-08-28",3,36,"0.00"),
    ("2017-07-23",44,26,"0.00"),
    ("2017-07-12",50,31,"0.00"),
    ("2017-08-12",2,2,"0.00"),
    ("2017-08-25",24,35,"0.00"),
    ("2017-08-27",79,14,"0.00"),
    ("2017-08-14",61,26,"0.00"),
    ("2017-08-19",77,16,"0.00"),
    ("2017-07-04",10,43,"0.00"),
    ("2017-08-06",66,15,"0.00"),
    ("2017-09-23",49,15,"0.00"),
    ("2017-08-01",53,2,"0.00"),
    ("2017-08-02",56,21,"0.00"),
    ("2017-08-20",100,42,"0.00"),
    ("2017-07-21",75,28,"0.00"),
    ("2017-08-03",5,3,"0.00"),
    ("2017-09-28",20,39,"0.00"),
    ("2017-09-17",86,12,"0.00"),
    ("2017-09-11",73,1,"0.00"),
    ("2017-09-30",34,26,"0.00"),
    ("2017-09-19",27,32,"0.00"),
    ("2017-09-24",87,20,"0.00"),
    ("2017-07-22",37,3,"0.00"),
    ("2017-08-28",48,13,"0.00"),
    ("2017-07-08",81,35,"0.00"),
    ("2017-08-26",57,22,"0.00"),
    ("2017-09-12",44,3,"0.00"),
    ("2017-08-20",60,36,"0.00"),
    ("2017-07-21",2,27,"0.00"),
    ("2017-07-27",58,43,"0.00"),
    ("2017-09-25",62,1,"0.00"),
    ("2017-07-11",80,22,"0.00"),
    ("2017-07-23",63,40,"0.00"),
    ("2017-07-21",78,31,"0.00"),
    ("2017-07-25",66,11,"0.00"),
    ("2017-09-04",28,22,"0.00"),
    ("2017-09-06",100,22,"0.00"),
    ("2017-09-30",94,29,"0.00"),
    ("2017-08-29",60,38,"0.00"),
    ("2017-07-14",44,11,"0.00"),
    ("2017-08-12",28,43,"0.00"),
    ("2017-07-28",97,17,"0.00"),
    ("2017-07-11",81,24,"0.00"),
    ("2017-07-28",95,39,"0.00"),
    ("2017-09-11",59,28,"0.00"),
    ("2017-07-26",67,26,"0.00"),
    ("2017-08-03",40,4,"0.00"),
    ("2017-08-08",8,19,"0.00"),
    ("2017-06-30",64,14,"0.00"),
    ("2017-07-08",21,42,"0.00"),
    ("2017-07-28",68,15,"0.00"),
    ("2017-08-06",91,2,"0.00"),
    ("2017-08-18",81,31,"0.00"),
    ("2017-07-20",94,35,"0.00"),
    ("2017-08-06",54,33,"0.00"),
    ("2017-09-01",15,43,"0.00"),
    ("2017-08-11",44,25,"0.00"),
    ("2017-08-03",3,11,"0.00"),
    ("2017-09-25",9,36,"0.00"),
    ("2017-09-28",94,40,"0.00"),
    ("2017-08-07",10,12,"0.00"),
    ("2017-08-01",89,23,"0.00"),
    ("2017-09-23",63,41,"0.00"),
    ("2017-09-15",90,30,"0.00"),
    ("2017-08-20",68,30,"0.00"),
    ("2017-09-23",99,19,"0.00"),
    ("2017-08-12",34,19,"0.00"),
    ("2017-09-28",35,28,"0.00"),
    ("2017-09-06",97,42,"0.00"),
    ("2017-09-05",64,10,"0.00"),
    ("2017-08-09",17,14,"0.00"),
    ("2017-09-15",70,5,"0.00"),
    ("2017-08-25",83,3,"0.00"),
    ("2017-09-09",87,10,"0.00"),
    ("2017-07-13",27,9,"0.00"),
    ("2017-07-27",99,6,"0.00"),
    ("2017-09-07",70,43,"0.00"),
    ("2017-08-30",36,5,"0.00"),
    ("2017-09-24",3,11,"0.00"),
    ("2017-09-06",84,2,"0.00"),
    ("2017-09-30",54,30,"0.00"),
    ("2017-07-05",49,2,"0.00"),
    ("2017-07-07",19,43,"0.00"),
    ("2017-07-07",100,6,"0.00"),
    ("2017-07-11",4,5,"0.00"),
    ("2017-09-12",27,26,"0.00"),
    ("2017-09-18",73,10,"0.00"),
    ("2017-09-30",5,30,"0.00"),
    ("2017-07-06",60,34,"0.00"),
    ("2017-09-25",80,17,"0.00"),
    ("2017-09-06",27,19,"0.00"),
    ("2017-09-04",46,37,"0.00"),
    ("2017-08-22",38,19,"0.00"),
    ("2017-08-06",57,13,"0.00"),
    ("2017-07-28",83,21,"0.00"),
    ("2017-08-18",62,9,"0.00"),
    ("2017-09-24",1,24,"0.00"),
    ("2017-07-10",70,19,"0.00"),
    ("2017-07-15",64,3,"0.00"),
    ("2017-09-15",69,37,"0.00"),
    ("2017-07-09",15,26,"0.00"),
    ("2017-09-24",1,4,"0.00"),
    ("2017-09-04",38,7,"0.00"),
    ("2017-09-17",20,23,"0.00"),
    ("2017-09-20",4,35,"0.00"),
    ("2017-07-27",15,16,"0.00"),
    ("2017-08-17",60,6,"0.00"),
    ("2017-07-10",63,42,"0.00"),
    ("2017-08-06",62,42,"0.00"),
    ("2017-09-03",81,39,"0.00"),
    ("2017-07-10",73,3,"0.00"),
    ("2017-08-04",95,32,"0.00"),
    ("2017-09-30",52,3,"0.00"),
    ("2017-07-21",61,34,"0.00"),
    ("2017-08-13",72,31,"0.00"),
    ("2017-07-29",65,6,"0.00"),
    ("2017-09-14",40,22,"0.00"),
    ("2017-07-23",36,22,"0.00"),
    ("2017-07-13",84,9,"0.00"),
    ("2017-07-11",91,6,"0.00"),
    ("2017-08-03",90,18,"0.00"),
    ("2017-08-11",56,19,"0.00"),
    ("2017-07-11",87,12,"0.00"),
    ("2017-07-28",12,14,"0.00"),
    ("2017-09-12",37,10,"0.00"),
    ("2017-07-29",99,20,"0.00"),
    ("2017-09-22",85,25,"0.00"),
    ("2017-08-19",91,18,"0.00"),
    ("2017-09-15",82,5,"0.00"),
    ("2017-07-05",95,37,"0.00"),
    ("2017-08-24",94,19,"0.00"),
    ("2017-07-30",90,28,"0.00"),
    ("2017-07-23",7,9,"0.00"),
    ("2017-08-07",55,24,"0.00"),
    ("2017-07-21",97,27,"0.00"),
    ("2017-09-28",20,5,"0.00"),
    ("2017-09-08",43,18,"0.00"),
    ("2017-09-08",77,26,"0.00"),
    ("2017-07-22",59,19,"0.00"),
    ("2017-07-12",12,43,"0.00"),
    ("2017-07-21",29,4,"0.00"),
    ("2017-08-03",74,17,"0.00"),
    ("2017-09-20",13,21,"0.00"),
    ("2017-09-23",38,23,"0.00"),
    ("2017-07-19",38,7,"0.00"),
    ("2017-09-29",37,8,"0.00"),
    ("2017-09-15",9,25,"0.00"),
    ("2017-07-10",25,22,"0.00"),
    ("2017-09-12",32,11,"0.00"),
    ("2017-09-11",37,13,"0.00"),
    ("2017-08-04",62,27,"0.00"),
    ("2017-08-23",53,20,"0.00"),
    ("2017-07-13",73,6,"0.00"),
    ("2017-09-08",66,21,"0.00"),
    ("2017-09-20",29,4,"0.00"),
    ("2017-08-03",73,16,"0.00"),
    ("2017-09-15",81,37,"0.00"),
    ("2017-09-06",13,40,"0.00"),
    ("2017-08-02",75,32,"0.00"),
    ("2017-08-24",56,35,"0.00"),
    ("2017-08-12",42,41,"0.00"),
    ("2017-08-29",17,30,"0.00"),
    ("2017-08-16",95,22,"0.00"),
    ("2017-07-28",53,35,"0.00"),
    ("2017-09-27",84,17,"0.00"),
    ("2017-08-11",23,38,"0.00"),
    ("2017-06-30",42,2,"0.00"),
    ("2017-08-17",16,27,"0.00"),
    ("2017-07-01",13,39,"0.00"),
    ("2017-08-11",35,30,"0.00"),
    ("2017-06-30",76,34,"0.00"),
    ("2017-07-13",66,18,"0.00"),
    ("2017-07-16",74,40,"0.00"),
    ("2017-07-24",56,4,"0.00"),
    ("2017-08-08",35,9,"0.00"),
    ("2017-07-19",64,21,"0.00"),
    ("2017-08-31",8,12,"0.00"),
    ("2017-08-20",40,25,"0.00"),
    ("2017-07-09",20,24,"0.00")
    ;

SELECT * FROM book_sales;