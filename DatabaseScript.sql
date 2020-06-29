/* CMP2060M Database Systems Assessment 2 by Gabriella Di Gregorio DIG15624188 */

/* Database Creation: */
CREATE DATABASE LCS;

/* This ensures the right database will be used: */
USE LCS;

/* Table Creation and Modification: */
CREATE TABLE Customers 
(
    email varchar(254) PRIMARY KEY,
    FirstName varchar(35) NOT NULL,
    LastName varchar(35) NOT NULL,
    HouseNumber varchar(35),
    Street varchar(35),
    City varchar(35),
    Postcode varchar(8),
    telephone char(11)
);

CREATE TABLE Staff 
(
    email varchar(254) PRIMARY KEY,
    FirstName varchar(35) NOT NULL,
    LastName varchar(35) NOT NULL,
    HouseNumber varchar(35),
    Street varchar(35),
    City varchar(35),
    Postcode varchar(8),
    telephone char(11)
);

ALTER TABLE Staff /* This adds the 'not null' constraint to various columns in the Staff table */
MODIFY COLUMN HouseNumber varchar(35) NOT NULL,
MODIFY COLUMN Street varchar(35) NOT NULL,
MODIFY COLUMN City varchar(35) NOT NULL,
MODIFY COLUMN Postcode varchar(8) NOT NULL,
MODIFY COLUMN telephone char(11) NOT NULL;

CREATE TABLE Supplier 
(
    email varchar(254) PRIMARY KEY,
    CompanyName varchar(70) NOT NULL,
    Building varchar(35),
    Street varchar(35),
    City varchar(35),
    Postcode varchar(8),
    telephone char(11)
);

CREATE TABLE Services
(
   	ServiceName varchar(50) PRIMARY KEY,
    Price decimal(19,2) NOT NULL,
    ItemRequired varchar(50),
    Description varchar(255)
);

CREATE TABLE Stock
(
    ItemName varchar(50) PRIMARY KEY,
    Price decimal(19,2) NOT NULL,
    Quantity int,
    Description varchar(255)    
);

ALTER TABLE Services /* This adds a foreign key to the ItemRequired field from the Stock table */
ADD FOREIGN KEY (ItemRequired) REFERENCES Stock(ItemName);

CREATE TABLE CustomerOrders
(
    OrderDate DATE PRIMARY KEY,
    OrderTime TIME NOT NULL,
    OrderStatus varchar(25) NOT NULL,
    CustomerName varchar(70) NOT NULL,
    ServiceName varchar(50) NOT NULL,
    Quantity int NOT NULL,
    ServiceLocation varchar(50) NOT NULL,
    CustomerAddress varchar(255),
    BasePrice decimal(19,2) NOT NULL,
    AdditionalCharges decimal(19,2),
    Discount decimal(19,2),
    TotalPrice decimal(19,2),
    
    FOREIGN KEY (ServiceName) REFERENCES Services(ServiceName)
    
);

ALTER TABLE CustomerOrders /* This sets the default value to 0 for a column in the CustomerOrders table */
ALTER AdditionalCharges SET DEFAULT 0; /* This is underlined in red in PHPmyAdmin but it works as intended. */

ALTER TABLE CustomerOrders 
ALTER Discount SET DEFAULT 0;

CREATE TABLE PurchaseOrders
(
    OrderDate DATE PRIMARY KEY,
    OrderTime TIME NOT NULL,
    OrderStatus varchar(25) NOT NULL,
    SupplierName varchar(70) NOT NULL,
    ItemName varchar(50) NOT NULL,
    Quantity int NOT NULL,    
    SupplierAddress varchar(255),
    Cost decimal(19,2) NOT NULL,
    DateReceived DATE
);

ALTER TABLE PurchaseOrders /* This adds a foreign key to the ItemName field from the Stock table */
ADD FOREIGN KEY (ItemName) REFERENCES Stock(ItemName);

/* Inserting data into Customer table: */
INSERT INTO Customers (email, FirstName, LastName, HouseNumber, Street, City, Postcode, telephone)
VALUES ('MeganThorpe@outlook.com', 'Megan', 'Thorpe', '7', 'Wilson Street', 'Lincoln', 'LN1 3HZ', '07706973768');

INSERT INTO Customers (email, FirstName, LastName, HouseNumber, Street, City, Postcode, telephone) 
VALUES ('DylanStewart@hotmail.com', 'Dylan', 'Stewart', '19', 'Pine Close', 'Lincoln', 'LN1 3SB', '07833235720');

INSERT INTO Customers (email, FirstName, LastName, HouseNumber, Street, City, Postcode, telephone)
VALUES ('SofiaSmith@gmail.com', 'Sofia', 'Smith', '85', 'Newark Road', 'Lincoln', 'LN6 8RA', '07707286805');

INSERT INTO Customers (email, FirstName, LastName, HouseNumber, Street, City, Postcode)
VALUES ('MilliePatterson@yahoo.co.uk', 'Millie', 'Patterson', 'Rayment House', 'Moorland Avenue', 'Lincoln', 'LN6 7PB');

INSERT INTO Customers (email, FirstName, LastName, telephone)
VALUES ('HYates@gmail.com', 'Harvey', 'Yates', '07873380679');

/* I decided to make some changes to the Staff table. I decided to add a NINO column and use this for the primary key
rather than email so I first had to drop the current primary key before adding a new primary key. 
I also added a DOB field since it is more realistic that a company would hold more information about their staff than their customers. 
I also decided to make the telephone column not null since it would be essential to be able to get in contact with their staff. */
ALTER TABLE Staff
DROP PRIMARY KEY;

ALTER TABLE Staff
ADD NINO varchar(9) PRIMARY KEY, /* Unfortunately there is no way to rearrange column order using SQL. For better layout, move the NINO column to the begining. */
ADD DOB DATE;

ALTER TABLE Staff
MODIFY COLUMN telephone char(11) NOT NULL,
MODIFY COLUMN email varchar(254) NOT NULL UNIQUE;

/* Inserting data into Staff table: */
INSERT INTO Staff (NINO, email, FirstName, LastName, HouseNumber, Street, City, Postcode, telephone, DOB)
VALUES ('YY012657B', 'SpencerDavison@lcs.co.uk', 'Spencer', 'Davidson', '10', 'Mourn Terrace', 'Lincoln', 'LN5 9AY', '07783727567', '1974-10-28');

INSERT INTO Staff (NINO, email, FirstName, LastName, HouseNumber, Street, City, Postcode, telephone, DOB)
VALUES ('GJ724457', 'ZacharyBennett@lcs.co.uk', 'Zachary', 'Bennett', '232', 'Doddington Road', 'Lincoln', 'LN6 7HF', '07086649341', '1988-12-10');

INSERT INTO Staff (NINO, email, FirstName, LastName, HouseNumber, Street, City, Postcode, telephone, DOB)
VALUES ('RX069170D', 'EdwardSkinner@lcs.co.uk', 'Edward', 'Skinner', '12', 'Sleaford Road', 'Lincoln', 'LN4 2NA', '07834839427', '1990-03-29');

INSERT INTO Staff (NINO, email, FirstName, LastName, HouseNumber, Street, City, Postcode, telephone)
VALUES ('MY532836', 'RubyMarshall@lcs.co.uk', 'Ruby', 'Marshall', '1', 'Olsen Rise', 'Lincoln', 'LN2 4UT', '07712810982');

INSERT INTO Staff (NINO, email, FirstName, LastName, HouseNumber, Street, City, Postcode, telephone, DOB)
VALUES ('ZX472892', 'SeanWade@lcs.co.uk', 'Sean', 'Wade', '2', 'Staffordshire Crescent', 'Lincoln', 'LN6 3LP', '07747575245', '1973-07-05');

/* I decided to add a Department column in the Staff table since it is mentioned in the Scenario. I set the default to Technical because it is the only known/relevant department. */
ALTER TABLE Staff
ADD Department varchar(35) DEFAULT 'Technical';

/* I decided to remove the Price column from the Stock table as it seemed unnecessary since it is subject to change.
The price is covered in the PurchaseOrders table. */
ALTER TABLE Stock
DROP COLUMN Price;

/* Adding data into the Stock and Services Tables: */
INSERT INTO Stock (ItemName, Quantity)
VALUES ('Memory Stick', '12');

INSERT INTO Services (ServiceName, Price, ItemRequired, Description)
VALUES ('Backup', '20', (SELECT ItemName FROM Stock Where ItemName = 'Memory Stick'), 'Copies the customers important files onto a memory stick as backup');

INSERT INTO Stock (ItemName, Quantity)
VALUES ('Antivirus License', '3'),
('Windows Boot', '2'),
('Screwdriver Set', '1');

INSERT INTO Services (ServiceName, Price, ItemRequired, Description)
VALUES ('Virus Removal', '40', (SELECT ItemName FROM Stock Where ItemName = 'Antivirus License'), 'Install an antivirus software on the customers PC and use it to remove any viruses found'),
('Hardware Repairs', '80', (SELECT ItemName FROM Stock Where ItemName = 'Screwdriver Set'), 'Open up the device and fix any hardware issues'),
('System Restore', '35', (SELECT ItemName FROM Stock Where ItemName = 'Windows Boot'), 'Reset device to factory settings and reinstall windows');

INSERT INTO Services (ServiceName, Price, Description)
VALUES ('Software Repairs', '30', 'Fix software errors, usually by re-installing');

/* I decided to change the Primary Key of the Supplier table from email to Company Name since this shoud be unique and is the easiest and most important form of identification. */
ALTER TABLE Supplier
DROP PRIMARY KEY;

ALTER TABLE Supplier
ADD PRIMARY KEY (CompanyName); /* It would make more aesthetical sense to put this column first. */

/* I decided to make some tweaks to the Supplier table. No two compaines should have the same email or telephone so these values have been set to unique. 
The staff and customer telephone may not be unique because they could live together and provide a shared house phone number.
It is important that the company has at least one contact method with their supplier so email is not null, but some companies may be moving away from telephone support and may not provide a phone number. */
ALTER TABLE Supplier
MODIFY COLUMN email varchar(254) NOT NULL UNIQUE,
MODIFY COLUMN telephone char(11) UNIQUE;

/* Adding data into the Supplier table: */
INSERT INTO Supplier (CompanyName, email, building, street, city, postcode, telephone)
VALUES ('OverclockersUK', 'support@overclockers.co.uk', 'Unit 5 Lymedale Cross', 'Lower Milehouse Lane', 'Newcastle-Under-Lyme', 'ST5 9EN', '01782444455');

INSERT INTO Supplier (CompanyName, email, telephone)
VALUES ('Amazon', 'primary@amazon.com', '08004961081');

INSERT INTO supplier (CompanyName, email)
VALUES ('HumbleBundle', 'humblesupport@humblebundle.com');

INSERT INTO Supplier (CompanyName, email, Building, Street, City, Postcode, telephone)
VALUES ('Lincoln Computer Wares', 'enquiries@LCW.co.uk', '1 St Peter At Arches', 'High Street', 'Lincoln', 'LN2 1AJ', '03301235986');

INSERT INTO Supplier (CompanyName, email)
VALUES ('Kinguin', 'PeguinSupport@Kinguin.net');

/* Adds a column for customer feedback in the customerOrders table. */
ALTER TABLE CustomerOrders
ADD CustomerFeedback varchar(255);

/* Before putting data into the CustomerOrders table, I decided to add a few checks and default values. Note that these appear underlined in red in PHPmyAdmin but work as intended without errors. */
ALTER TABLE CustomerOrders
ADD CHECK (OrderStatus IN ('Pending', 'In Progress', 'Complete'));

ALTER TABLE CustomerOrders
ADD CHECK (ServiceLocation IN ('Home', 'Store'));

ALTER TABLE CustomerOrders
ALTER ServiceLocation SET DEFAULT 'Store'; 

ALTER TABLE customerorders
ADD CHECK (OrderDate <= GetDate());

ALTER TABLE CustomerOrders
ALTER Quantity SET DEFAULT 1; 

/* Adding and altering/updating data in the CustomerOrders table: */
INSERT INTO CustomerOrders (OrderDate, OrderTime, OrderStatus, CustomerName, ServiceName, Quantity, ServiceLocation, CustomerAddress, BasePrice, AdditionalCharges, Discount, CustomerFeedback)
VALUES('2018-11-11', '153000', 'Complete', (SELECT CONCAT(FirstName, " ", LastName) FROM Customers WHERE FirstName = 'Millie'), 'Software Repairs', '1', 'Home', (SELECT CONCAT(HouseNumber, " ", Street, " ", City, " ", Postcode) FROM Customers WHERE FirstName = 'Millie'), '30', '10', '0', 'Excellent and speedy service.');

ALTER TABLE CustomerOrders
ADD StaffAppointed varchar(70); /* I decided to add a column to keep record of the staff that deals with the order */

UPDATE CustomerOrders /* This updates the table and adds the staff name to an entry with software repairs as the ServiceName. */
SET StaffAppointed = (SELECT CONCAT(FirstName, " ", LastName) FROM Staff WHERE FirstName = 'Sean')
WHERE ServiceName = 'Software Repairs';

INSERT INTO CustomerOrders (OrderDate, OrderTime, OrderStatus, CustomerName, ServiceName, Quantity, ServiceLocation, CustomerAddress, BasePrice, AdditionalCharges, Discount, StaffAppointed)
VALUES ('2018-12-30', '101543', 'In Progress', (SELECT CONCAT(FirstName, " ", LastName) FROM Customers WHERE FirstName = 'Dylan'), 'Hardware Repairs', '1', 'Store', (SELECT CONCAT(HouseNumber, " ", Street, " ", City, " ", Postcode) FROM Customers WHERE FirstName = 'Dylan'), '80', '00', '5', (SELECT CONCAT(FirstName, " ", LastName) FROM Staff WHERE FirstName = 'Edward'));

INSERT INTO CustomerOrders (OrderDate, OrderTime, OrderStatus, CustomerName, ServiceName, Quantity, ServiceLocation, BasePrice, AdditionalCharges, Discount, StaffAppointed)
VALUES ('2019-01-03', '163305', 'Pending', (SELECT CONCAT(FirstName, " ", LastName) FROM Customers WHERE FirstName = 'Harvey'), 'System Restore', '1', 'Store', '35', '0', '0', (SELECT CONCAT(FirstName, " ", LastName) FROM Staff WHERE FirstName = 'Zachary'));

INSERT INTO CustomerOrders (OrderDate, OrderTime, OrderStatus, CustomerName, ServiceName, Quantity, ServiceLocation, CustomerAddress, BasePrice, AdditionalCharges, Discount, StaffAppointed)
VALUES ('2018-12-05', '114726', 'Complete', (SELECT CONCAT(FirstName, " ", LastName) FROM Customers WHERE FirstName = 'Megan'), 'Virus Removal', '1', 'Home', (SELECT CONCAT(HouseNumber, " ", Street, " ", City, " ", Postcode) FROM Customers WHERE FirstName = 'Megan'), '40', '10', '0', (SELECT CONCAT(FirstName, " ", LastName) FROM Staff WHERE FirstName = 'Sean'));

INSERT INTO CustomerOrders (OrderDate, OrderTime, OrderStatus, CustomerName, ServiceName, Quantity, ServiceLocation, CustomerAddress, BasePrice, AdditionalCharges, Discount, StaffAppointed)
VALUES ('2018-12-18', '135209', 'In Progress', (SELECT CONCAT(FirstName, " ", LastName) FROM Customers WHERE FirstName = 'Sofia'), 'Backup', '1', 'Store', (SELECT CONCAT(HouseNumber, " ", Street, " ", City, " ", Postcode) FROM Customers WHERE FirstName = 'Sofia'), '20', '0', '2', (SELECT CONCAT(FirstName, " ", LastName) FROM Staff WHERE FirstName = 'Ruby'));

UPDATE CustomerOrders
SET CustomerFeedback = 'Disappointed. Files were removed without my permission.' /* CustomerFeedback is likely to be entered by an update since the feedback will be provided later. */
WHERE CustomerName = 'Megan Thorpe';

ALTER TABLE CustomerOrders
DROP COLUMN Quantity; /* I decided to drop the Quantity column in this table due to it not really being necessary and not making much sense. It is unlikely for a customer to require two of the same service at the same, and it would make more sense to simply create a new order entry anyway. */

UPDATE CustomerOrders
SET TotalPrice = (SELECT SUM(BasePrice + AdditionalCharges - Discount)); /* This fills in the TotalPrice column by calculation. */

/* This is an example of 'DELETE' which might be necessary if a member of staff quits or is fired: */
DELETE FROM Staff WHERE FirstName = 'Spencer';

ALTER TABLE customerOrders
ADD OrderID int NOT NULL UNIQUE AUTO_INCREMENT; /* I decided to add an order ID column that increments automatically since it would make sense to have another unique way of identifying the orders besides date and time which may overlap. */

/* I made some similar adjustments to the PurchaseOrders table such as adding checks and an OrderID. */
ALTER TABLE PurchaseOrders
DROP COLUMN Cost; /* I deleted this column because it does not provide enough information, two columns are necessary */

ALTER TABLE PurchaseOrders /* This adds 3 columns to the PurchaseOrders table: ItemPrice, TotalCost, OrderID */
ADD ItemPrice decimal(19,2) NOT NULL,
ADD TotalCost decimal(19,2),
ADD OrderID int NOT NULL UNIQUE AUTO_INCREMENT;

ALTER TABLE PurchaseOrders
ADD CHECK (OrderDate <= GetDate()),
ADD CHECK (DateReceived >= OrderDate),
ADD CHECK (OrderStatus IN ('Pending', 'Dispatched', 'Complete'));

/* Inserting data into the PurchaseOrders table: */
INSERT INTO PurchaseOrders (OrderDate, OrderTime, OrderStatus, SupplierName, ItemName, Quantity, SupplierAddress, DateReceived, ItemPrice)
VALUES ('2018-11-09', '093207', 'Complete', 'Lincoln Computer Wares', (SELECT ItemName FROM Stock Where ItemName = 'Memory Stick'), '5', (SELECT CONCAT(Building, " ", Street, " ", City, " ", Postcode) FROM Supplier WHERE CompanyName = 'Lincoln Computer Wares'), '2018-11-12', '10.92');

INSERT INTO PurchaseOrders (OrderDate, OrderTime, OrderStatus, SupplierName, ItemName, Quantity, ItemPrice)
VALUES ('2019-01-05', '162456', 'Dispatched', 'Amazon', (SELECT ItemName FROM Stock Where ItemName = 'Screwdriver Set'), '2', '12.99');

INSERT INTO PurchaseOrders (OrderDate, OrderTime, OrderStatus, SupplierName, ItemName, Quantity, ItemPrice)
VALUES ('2018-12-08', '141243', 'Complete', 'HumbleBundle', (SELECT ItemName FROM Stock Where ItemName = 'Antivirus License'), '1', '19.99');

INSERT INTO PurchaseOrders (OrderDate, OrderTime, OrderStatus, SupplierName, ItemName, Quantity, DateReceived, ItemPrice)
VALUES ('2018-12-30', '090651', 'Complete', 'Kinguin', (SELECT ItemName FROM Stock Where ItemName = 'Windows Boot'), '1', '2018-12-30', '25.19');

UPDATE PurchaseOrders
SET DateReceived = '2018-12-08'
WHERE OrderDate = '2018-12-08';

UPDATE PurchaseOrders
SET TotalCost = (SELECT SUM(ItemPrice * Quantity));

/* JOINS */

/* INNER JOIN: This displays information regarding when orders were placed with each supplier and their relevant contact information. This may be useful if LCS want to contact the right supplier regarding a specific order. */
SELECT purchaseorders.OrderDate, purchaseorders.OrderTime, purchaseorders.OrderID, purchaseorders.OrderStatus, purchaseorders.SupplierName, purchaseorders.SupplierAddress, supplier.email, supplier.telephone
FROM purchaseorders
INNER JOIN Supplier ON purchaseorders.SupplierName = supplier.CompanyName
ORDER BY purchaseorders.OrderDate;

/* LEFT JOIN: This displays the names of the services and the items required for them, as well as the quantity of that item currently in stock. This might be useful if LCS want to find out how many more of a particular service they can carry out before ordering more stock. */
SELECT services.ServiceName, services.ItemRequired, stock.Quantity
FROM services
LEFT JOIN stock ON Services.ItemRequired = Stock.ItemName;

/* RIGHT JOIN: This joins some contact info (email and telephone) from the Customers table with several pieces of information from the CustomerOrders table. This may be useful if LCS want to contact the relevant customer regarding a specifc order they have placed. */
SELECT customerorders.OrderDate, customerorders.OrderTime, customerorders.OrderID, customerorders.OrderStatus, customerorders.ServiceName, customerorders.TotalPrice, customerorders.CustomerName, customerorders.CustomerAddress, customers.email, customers.telephone
FROM customers
RIGHT JOIN customerorders ON CONCAT(customers.FirstName, " ", customers.LastName) = customerorders.CustomerName
ORDER BY customerorders.OrderDate;

/* UNION: This essentially creates an address book containing all of the known contact details for both the customers and staff. */
SELECT customers.FirstName, customers.LastName, customers.email, customers.telephone, customers.HouseNumber, customers.Street, customers.City, customers.Postcode FROM Customers
UNION
SELECT staff.FirstName, staff.LastName, staff.email, staff.telephone, staff.HouseNumber, staff.Street, staff.City, staff.Postcode FROM Staff
ORDER BY LastName;

/* Creating Copies of all tables: */

CREATE TABLE Copy_Of_Customers LIKE Customers; 
INSERT INTO Copy_Of_Customers SELECT * FROM Customers;

CREATE TABLE Copy_Of_Stock LIKE Stock; 
INSERT INTO Copy_Of_Stock SELECT * FROM Stock;

CREATE TABLE Copy_Of_Services LIKE Services; 
INSERT INTO Copy_Of_Services SELECT * FROM Services;

CREATE TABLE Copy_Of_Staff LIKE Staff; 
INSERT INTO Copy_Of_Staff SELECT * FROM Staff;

CREATE TABLE Copy_Of_Supplier LIKE Supplier; 
INSERT INTO Copy_Of_Supplier SELECT * FROM Supplier;

CREATE TABLE Copy_Of_CustomerOrders LIKE CustomerOrders; 
INSERT INTO Copy_Of_CustomerOrders SELECT * FROM CustomerOrders;

CREATE TABLE Copy_Of_PurchaseOrders LIKE PurchaseOrders; 
INSERT INTO Copy_Of_PurchaseOrders SELECT * FROM PurchaseOrders;

/* Creating a user and editing their permissions: */

CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password'; /* This creates a user with a password */

GRANT ALL PRIVILEGES ON LCS.* TO 'newuser'@'localhost'; /* This grants all privileges to the user for any table in this database only. */

REVOKE DROP ON LCS.* FROM 'newuser'@'localhost'; /* This removes the users permission to DROP tables in LCS, so they can now use everything other than DROP  */

/* If we wanted to set specific permissions such as read-only we could use something such as this (instead of the two statements above)...
GRANT SELECT ON LCS.* TO 'newuser'@'localhost'; This would only allow the user to select data from the tables to read through the database. */

/* Creating and calling a stored procedure: */

/* This procedure returns information regarding all Customer Orders with a status other than Complete (Pending or In Progress). This would be useful if LCS want to see just the Orders they have left to fulfill without ones that have already been completed. */
DELIMITER //
 CREATE PROCEDURE Find_IncompleteOrders()
   BEGIN
   SELECT OrderDate, OrderTime, OrderID, OrderStatus, CustomerName, ServiceName, ServiceLocation, CustomerAddress, BasePrice, AdditionalCharges, Discount, TotalPrice, StaffAppointed FROM CustomerOrders
   WHERE OrderStatus != 'Complete';
   END //
 DELIMITER ;
 
 CALL Find_IncompleteOrders(); /* This calls the stored procedure. */
