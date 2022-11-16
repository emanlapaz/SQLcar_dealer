-- Database Assinment
-- Eugenio Jr Manlapaz 20110013
-- SCRIPT ONE: I have commented out some of the commands I used for testing the database. Feel free to use it for testing

-- creates the database
CREATE SCHEMA IF NOT EXISTS car_dealer;

-- creating the tables
CREATE TABLE IF NOT EXISTS Client(
	clientID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR (50),
    lastName VARCHAR (50),
    street VARCHAR (50),
    town VARCHAR (50),
    county VARCHAR (50),
    eircode VARCHAR (50),
    phoneNumber INT,
    email VARCHAR (30),
    PRIMARY KEY (clientID)
);
    
CREATE TABLE IF NOT EXISTS Employee(
	employeeNumber INT NOT NULL,
    PPSNumber INT,
    firstName VARCHAR (50),
	lastName VARCHAR (50),
    street VARCHAR (50),
    town VARCHAR (50),
    county VARCHAR (50),
    eircode VARCHAR (50),
    phoneNumber INT,
    email VARCHAR (30),
	position VARCHAR (50),
	contract VARCHAR (50),
	salary INT,
	dateEmployed DATE,
	yearsOfExperience int,
    clientID int,
    PRIMARY KEY (employeeNumber),
    FOREIGN KEY (clientID) REFERENCES client(clientID)
    );
    
CREATE TABLE IF NOT EXISTS SalesAgent(
	employeeNumber INT NOT NULL,
    brandSpecialisation VARCHAR (50),
    commission DECIMAL (5,2),
    clientID INT,
    PRIMARY KEY (employeeNumber),
    FOREIGN KEY (employeeNumber) REFERENCES Employee(employeeNumber),
    FOREIGN KEY (clientID) REFERENCES client(clientID)
    );
    
CREATE TABLE IF NOT EXISTS Mechanic(
	employeeNumber INT NOT NULL,
    workStation VARCHAR (50),
    apprenticeship VARCHAR (50),
    clientID INT,
    PRIMARY KEY (employeeNumber),
    FOREIGN KEY (employeeNumber) REFERENCES Employee(employeeNumber),
    FOREIGN KEY (clientID) REFERENCES client(clientID)
    );
    
CREATE TABLE IF NOT EXISTS Repairs(
	jobOrder INT NOT NULL,
    workStation VARCHAR (20) NOT NULL,
    repairType VARCHAR (50),
    partName VARCHAR (20),
    completionDate DATETIME,
    repairInvoice DECIMAL (7,2),
	employeeNumber INT NOT NULL,
    clientID INT, 
    PRIMARY KEY (jobOrder),
    FOREIGN KEY (employeeNumber) REFERENCES employee(employeeNumber),
    FOREIGN KEY (clientID) REFERENCES client(clientID)
    );

CREATE TABLE IF NOT EXISTS CarParts(
	partNumber INT NOT NULL,
    partName VARCHAR (20),
    partCategory VARCHAR (20),
    partPrice DECIMAL (7,2),
    customParts BOOLEAN,
	supplier VARCHAR (20),
    shipmentDate DATE,
    employeeNumber INT,
    PRIMARY KEY (partNumber),
    FOREIGN KEY (employeeNumber) REFERENCES employee(employeeNumber)
    );

CREATE TABLE IF NOT EXISTS Modification(
	modificationOrder INT NOT NULL,
    modificationType VARCHAR (20),
    partsNeeded VARCHAR (255),
    completionDate DATETIME,
    modificationInvoice DECIMAL (7,2),
    clientID INT,
    employeeNumber INT,
    PRIMARY KEY (modificationOrder),
    FOREIGN KEY (employeeNumber) REFERENCES employee(employeeNumber),
    FOREIGN KEY (clientID) REFERENCES client(clientID)
    );

CREATE TABLE IF NOT EXISTS CarSales(
	chassisNumber INT NOT NULL,
    employeeNumber INT NOT NULL,
	modelYear YEAR,
    carMake VARCHAR (50),
    engineType VARCHAR (50),
    fuelType VARCHAR (50),
    carPrice INT,
    clientID INT,
    PRIMARY KEY (chassisNumber),
    FOREIGN KEY (employeeNumber) REFERENCES employee(employeeNumber),
	FOREIGN KEY (clientID) REFERENCES client(clientID)
    );
    
    
-- populating the table
INSERT INTO client (firstName, lastName, street, town, county, eircode, phoneNumber, email)
	VALUES ('Elon', 'Musk', '1 United Street', 'Naas', 'Kildare','w91ff6a', 0831231234, 'elonmusk@telsa.com'),
			('Bernard','Arnault','2 France Street','Newbridge','Kildare','w901234', 0831256222,'bernardarnault@LVMH.com'),
            ('Gautam','Adani','11 India Street','Kildare','Kildare','w1889h8',0894561235,'gautamaadani@infra.com'),
            ('Jeff','Bezos','60 States','Blessington','Wicklow','e129jj8',0874587896,'jeffbezos@amazon.com'),
            ('Larry','Ellison','78 Oracle Street','Arklow','Wickow','e45kk45',0896325569,'larryellison@oracle.com'),
            ('Bill','Gates','67 Softfield','Tramore','Waterford','f34tt56',0874521452,'billgates@micro.com'),
            ('Warren','Buffet','98 Wall Street','Duncannon','Waterford','f67gg77',0801239856,'warrenbuffet@hathaway.com'),
            ('Mukesh','Ambani','82 Telecourt','Curracloe','Wexford','t56yy67', 0803326523,'mukeshambani@divers.com'),
            ('Carlos','Helu','65 Diversfield','Swords','Dublin','d34gg44',0814597896,'carloshelu@tele.com'),
            ('Michael','Bloomberg','80 Stockston','Lucan','Dublin','d33rt55',0896563256,'michaelbloom@stocks.com');
            
INSERT INTO employee (employeeNumber, PPSNumber, firstName, lastName, street, town, county, eircode, phoneNumber, email, position, contract, salary, dateEmployed, yearsOfExperience,clientID)
	VALUES	(100, 124521, 'Larry','Page','49 Google','Naas','Kildare','w90io99', 0877896541, 'larrypage@google.com','Chief Mechanic','Full-time', 60000, '1980-01-01', 30,1),
			(200, 147854, 'Steve','Ballmer','66 Micros','Athy','Kildare','w89ii88', 0895632236, 'steveballmer@micoso.com','Sales Manager','Full-time', 55000, '1989-02-08', 25,2),
            (300, 156325, 'Sergey', 'Brin', '49 Gogle',' Clondalkin', 'Dublin', 'd12ee23', 0893332222, 'sergeybrin@goo.com','Senior Mechanic','Full-time', 40000, '2009-10-11', 20,3),
            (400, 789654, 'Jim','Walton','74 Walmart','Tallaght','Dublin','D1212rr', 0875552632,'jimwalton@mart.com','Senior Sales Agent','Part-time', 20000, '2011-12-01', 10,4),
            (500, 787854, 'Francoise','Meyers','69 Oreal','Dunlavin','Kildare',' w89jj89', 0899996655,'francoise@orel.com','Senior Mechanic','Fulltime', 35000, '2010-10-11', 15,5),
            (600, 456321, 'Charles', 'Koch','87 Industry',' Bray', 'Wicklow', 'k78pp78', 0845245221,'charleskoch@indu.com','Senior Sales Agent','Fulltime', 33000, '2015-05-08', 10,6),
            (700, 478555, 'Amancio', 'Ortega', '86 Zara', 'Gorey', 'Wexford', 'e3474dd', 0899965555, 'amancioorrtge@zara.com', 'Senior Mechanic', 'Part-time', 21000, '2018-09-09', 11,7),
            (800, 889966, 'David', 'Thompson', '65 Media', 'Rosslare', 'Wexford', 'e44rr55', 0870001236, 'davidthompson@media.com', 'Junior Sales Agent', 'Full-time', 33000,'2019-01-06', 5,8),
            (900, 774411, 'Michael', 'Dell', '57 Techo', 'Drogheda', 'Louth', 'l67uu67', 0831201236,'mikedell@tech.com', 'Junior mechanic','Full-time', 29000,'2020-06-03', 2,9),
            (101, 889963, 'Jacqueline', 'Mars', '83 Candy', 'Dundalk',' Louth','l00op90', 0896321452, 'kacmars@candy.com','Junior Sales Agent', 'Part-time', 21500 ,'2020-06-07',2,10);
            
INSERT INTO mechanic (employeeNumber, workStation, apprenticeship, clientID)
	VALUES	(100, 'Engine', 'Marks Garage',1),
			(300, 'Electronics', 'Jeffs Autoshop',3),
            (500, 'Body Shop', 'Marks Garage',5),
            (700, 'Engine', 'Jeffs Autoshop',7),
            (900, 'Body Shop', 'Toms Auto',9);
            
INSERT INTO salesagent (employeeNumber, brandSpecialisation, commission, clientID)
	VALUES	(200, 'Japanese Cars', 2.25,2),
			(400, 'European Cars', 3.00,4),
            (600, 'American Cars', 2.50,6),
            (800, 'Japanese Cars', 2.25,8),
            (101, 'European Cars', 2.75,10);
            
INSERT INTO carparts (partNumber, partName, partCategory, partPrice, customParts, supplier, shipmentDate,employeeNumber)
	VALUES	(10001, 'Pistons', 'Engine',100.25, true,'Irish Auto Parts','2022-04-11',700),
			(52365, 'Cam Shaft', 'Engine', 115.50, true,'Irish Auto Parts','2022-01-02',100),
            (21458, 'Engine Block', 'Engine', 200.99, true, 'Joe Autoshop','2022-11-11',100),
            (78965, 'Car Speakers', 'Electronics', 150.50, True, 'Paddy Electronics','2022-09-03',300),
            (11200, 'Radio Head Units', 'Electronics', 200.99, false, 'Larry Autoelectric','2022-01-09',300),
            (12542, 'Dash Cams', 'Electronics', 300.99, true, 'Larry Autoelectric','2022-09-08',300),
            (11226, 'Body Kits', 'Body Works', 500.55, true, 'Bodyworx','2022-07-09',900),
            (11277, 'Body Shell', 'Body Works', 1000.50, true, 'Bodyworx','2022-02-02',900),
            (10022, 'Bumper Grill', 'Body Works', 200.99, true, 'Bumpshop', '2022-09-08',500);

INSERT INTO carsales (chassisNumber, employeeNumber, modelYear, carMake, engineType, fuelType, carPrice)
	VALUES	(658986523, 400, '2022', 'Peugeot', 'Automatic', 'Diesel', 59000),
			(784512547, 101, '2022', 'Renault', 'Manual', 'Petrol', 57500),
            (236521459, 101, '2022', 'Volvo', 'Automatic','Hybrid', 89000),
            (785231023, 400, '2021', 'BMW', 'Automatic', 'Diesel', 95000),
            (102301254, 600, '2021', 'Ford', 'Manual', 'Petrol', 70000),
            (102369856, 600, '2021', 'Jeep', 'Automatic', 'Diesel', 60000),
            (741258789, 600, '2020', 'Chevrolet', 'Manual', 'Hybrid', 58000),
            (120365986, 200, '2020', 'Honda', 'Automatic', 'Hybrid', 68000),
            (102100236, 800, '2020', 'Mazda', 'Manual', 'Diesel', 78000),
            (512031201, 200,'2019', 'Hyundai', 'Automatic' ,'Petrol', 55500),
            (458930232, 800, '2019', 'Nissan', 'Manual','Diesel', 40000);

INSERT INTO repairs (jobOrder, workStation, repairType, partName, completionDate, repairInvoice, employeeNumber,clientID)
	VALUES	(1010,'Engine', 'Replacement', 'Cam Shaft', '2022-08-07 12:30:00', 1500,100,1),
			(1021,'Engine', 'Replacement','Pistons','2022-08-07 13:45:00', 600,700,7),
            (1033,'Engine','Overhaul', 'Engine Block', '2022-09-01 09:30:00', 2500,100,1),
            (1055,'Electronics', 'Replacement', 'Radio Head Units','2022-11-10 12:45:00', 500,300,3),
            (1458,'Electronics', 'Installation','Dash Cam','2022-04-11 14:00:00', 350,300,3),
            (1102,'Electronics', 'Installation', 'Car Speakers', '2022-08-04 13:50:00', 250,300,3),
            (1485,'Body Shop', 'Paint','','2020-10-11 17:00:00',2000,500,5),
            (2012,'Body Shop', 'Installation', 'Bumper Grill', '2022-09-08 14:25:00', 220,500,5),
            (1011,'Body Shop', 'Replacement', 'Body Kits', '2022-08-01 12:30:00', 3500,900,9),
            (2632,'Body Shop', 'Dent Repair', 'Body Shell', '2022-09-06 10:00:00', 1500,900,9);


INSERT INTO modification (modificationOrder, modificationType, partsNeeded, completionDate, modificationInvoice,clientID,employeeNumber)
	VALUES	(1265, 'Paint Job','Body Shell','2022-08-08 14:50:00', 3500,6,500),
			(1336, 'Tuning','ECU','2022-08-01 13:00:00', 500,1,100),
			(1478, 'Paint Job', 'Fender', '2022-01-02 12:00:00', 300,4,500),
			(1689, 'Tuning', 'Exhaust','2022-08-03 15:00:00', 650,9,300),
			(1268, 'Interiors', 'Seat Covers', '2020-06-01 15:30:00', 500,8,900),
			(1166, 'Installation', 'Spoilers', '2020-09-02 11:30:00', 1500,5,700);
    
    
-- INDEXES --
-- creates indexes
CREATE INDEX partnameind 
	ON carparts(partName);
    
CREATE INDEX carmakeind 
	ON carsales(carMake);
    
CREATE INDEX clientlastnameind 
	ON client(lastName);
    
CREATE INDEX employeePPSind 
	ON employee(PPSNumber);
    
CREATE INDEX modinvoiceind 
	ON modification(modificationInvoice);
    
CREATE INDEX repairinvoiceind 
	ON repairs(repairInvoice);

/* I have commented out the SHOW indexes and DROP commands, can used for testing
-- shows index from the tables
SHOW INDEX FROM carparts;
SHOW INDEX FROM carsales;
SHOW INDEX FROM client;
SHOW INDEX FROM employee;
SHOW INDEX FROM modification;
SHOW INDEX FROM repairs;


-- removes an INDEX
ALTER TABLE carparts 
	DROP INDEX partnameind;
    
ALTER TABLE carsales
	DROP INDEX carmakeind;
    
ALTER TABLE client 
	DROP INDEX clientlastnameind;
    
ALTER TABLE employee
	DROP INDEX employeePPSind;
    
ALTER TABLE modification
	DROP INDEX modinvoiceind;
    
ALTER TABLE repairs
	DROP INDEX repairinvoiceind;
    
    */
-- TRIGGERS--
-- trigger created for the car sales table when updating the car prices--

-- create a table to log in changes

CREATE TABLE carPrice_update (
			chassisNumber INT NOT NULL,
            modelYear YEAR,
            carMake VARCHAR (30),
            carPrice INT,
            newCarPrice INT,
            dateChanged DATETIME,
            action VARCHAR (30),
            PRIMARY KEY (chassisNumber)
            );
            
-- creates a TRIGGER
CREATE TRIGGER before_carSales_update
		BEFORE UPDATE ON carSales
		FOR EACH ROW
	INSERT INTO carprice_update
    SET action = 'price changed',
    chassisNumber = OLD.chassisNumber,
    modelYear = OLD.modelYear,
    carMake = OLD.carMake,
    carPrice = OLD.carPrice,
    newCarPrice = NEW.carPrice,
    dateChanged = NOW();
    
 /* I have commented out some of these commands. Feel free to use this to check the TRIGGER and VIEWS
 
-- shows all triggers;
SHOW TRIGGERS;

-- deletes a TRIGGER example:
DROP TRIGGER before_carSales_update;

-- updates the car price to check TRIGGER:
UPDATE carsales
SET
	carPrice = 787878
WHERE 
	chassisNumber = 512031201;
	*/
    
-- VIEWS;
-- creates or replaces view:
-- example for clientID:
CREATE or REPLACE view clientID AS
	SELECT clientID, concat (firstName,' ',lastName) Name, concat (street,' ',town,' ',county,' ',eircode) address
    FROM client
    WHERE county = 'Kildare';

/*
-- displays the view with the client ID, name, and address:
SELECT* from clientID;

-- deletes the view:
DROP VIEW clientID;

-- example from carsales:

CREATE or REPLACE view carMake AS
	SELECT concat (modelYear,' ',carMake) Car, engineType, carPrice
    FROM carsales
    WHERE fuelType = 'Diesel';
    
-- displays diesel cars:
SELECT* from carMake;
    
-- updating views with price up by 20%
UPDATE carMake
	SET carPrice = carPrice * 2.00;

-- view the carprice_update for the changes in car price:  
SELECT* from carprice_update;
*/
-- end
    
    
    
    
    
	
