-- Database Assinment
-- Eugenio Jr Manlapaz 20110013
-- SCRIPT TWO:

-- use the car_dealer database:
USE car_dealer;

-- WHERE....IN: returns all cars with fuelType Hybid and Petrol:
SELECT*
	FROM carsales
	WHERE fuelType IN ('Hybrid','Petrol');
    
-- WHERE....BETWEEN: returns client name and address from client ID 3-7:
SELECT clientID, concat (firstName,' ',lastName) CLIENT, concat (street,'',town,' ',county) Address
	FROM client
	WHERE clientID BETWEEN 3 and 7;
    
-- WHERE....LIKE: returns all DIESEL CARS, used the wildcard % for the LIKE
SELECT concat (modelYear,' ',carMake) Car, engineType, fueltype, carPrice
    FROM carsales
    WHERE fuelType LIKE '%esel';
    
-- DATE FUNCTIONS:
-- returns the completion date of the Repairs, date overdue and orders them by date
SELECT jobOrder, repairType, partName, DATE_FORMAT(completionDate, '%a %D %b %Y %T') as 'Expected date of Completion',  DATEDIFF(curdate(), completionDate) as 'Days OverDue'
	FROM repairs
    ORDER BY completionDate;

-- AGGREGATE FUNCTIONS:
-- count the number of Electronics in the carparts table
SELECT COUNT(partCategory) as 'Electronics in stock'
	FROM carparts
    WHERE partCategory = 'Electronics';
    
-- returns the smallest value in the partPrice
SELECT MIN(partPrice) as 'Cheapest part'
	FROM carparts;
    
-- returns the largest value in partPrice:
SELECT MAX(partPrice) as 'Most expensive part'
	FROM carparts;
  
-- returns the sum of the partPrice column:
SELECT SUM(partPrice) as 'Total price for Electronic parts'
	FROM carparts
	WHERE partCategory = 'Electronics';

-- returns the average price of car parts
SELECT AVG(partPrice) as 'Average price of parts'
	FROM carparts;
    
 -- aggregate functions combined
SELECT COUNT(partCategory) as 'Parts in stock', MIN(partPrice) as 'Cheapest part', MAX(partPrice) as 'Most expensive part', SUM(partPrice) as 'Sum of all items in stock', AVG(partPrice) as 'Average price of parts'
	FROM carparts;
	
-- GROUP BY:
-- returns the number of employee based on Position:
SELECT position, COUNT(employeeNumber) as 'Number of Employees'
	FROM employee
	GROUP BY position;

-- GROUP BY....HAVING:
-- returns the number of employees by position having more than 2 employees:
SELECT position, COUNT(employeeNumber) as 'Number of Employees'
	FROM employee
	GROUP BY position
    HAVING COUNT(employeeNumber) >=2;

-- ORDERBY: returns the LASTNAME in alphabetical order
SELECT clientID, lastName, firstName
	FROM client
	WHERE lastName IN (lastName, firstName)
    ORDER BY lastName;
    
-- ORDERBY: returns the LASTNAME in reverse alphabetical order
    SELECT clientID, lastName, firstName
	FROM client
	WHERE lastName IN (lastName, firstName)
    ORDER BY lastName DESC;
    
-- INNER JOIN
-- joined employee and mechanic table and returns employee name with assigned workstation
SELECT concat(firstName,' ',lastname) as 'Employee Name', workstation, dateEmployed
	FROM employee JOIN mechanic
    ON employee.employeeNumber = mechanic.employeeNumber
    WHERE workStation = 'Engine';
    
-- joined employee and carsales table and returns Sales Agent assigned on the Car
SELECT concat(firstName,' ',lastname) as 'Sales Agent', modelYear as 'Year', carMake as 'Brand', carPrice as 'Price'
	FROM carsales JOIN employee
    ON carsales.employeeNumber = employee.employeeNumber;
    
-- joined employee and repairs table and returns Mechanic assigned on the repairs
SELECT concat(firstName,' ',lastname) as 'Mechanic Assigned', jobOrder, repairType, partName, DATE_FORMAT(completionDate, '%a %D %b %Y %T') as 'Expected date of Completion',  DATEDIFF(curdate(), completionDate) as 'Days OverDue'
	FROM repairs JOIN employee
    ON repairs.employeeNumber = employee.employeeNumber
    ORDER BY completionDate;
    
-- MULTI JOIN
-- joined client, employee and repairs, returns client name, employee name, and repair details
SELECT concat(client.firstName,' ',client.lastname) as 'Client Name',concat(employee.firstName,' ',employee.lastname) as 'Mechanic Assigned',employee.position, jobOrder, repairType, partName, DATE_FORMAT(completionDate, '%a %D %b %Y %T') as 'Expected date of Completion',  DATEDIFF(curdate(), completionDate) as 'Days OverDue'
	FROM repairs JOIN employee
    ON repairs.clientID = employee.clientID
    JOIN client
    ON employee.clientID = client.clientID
    ORDER BY completionDate;

-- OUTER JOINS:
-- LEFT JOIN: joined employee with repairs
SELECT concat(employee.firstName,' ',employee.lastname) as 'Employee Name', position, jobOrder, repairType, partName
	FROM employee LEFT JOIN repairs
    ON employee.employeeNumber = repairs.employeeNumber
    ORDER BY lastName;
    
-- RIGHT JOIN:
SELECT concat(employee.firstName,' ',employee.lastname) as 'Employee Name', position,modelYear, carMAke, carPrice
	FROM employee RIGHT JOIN carsales
    ON employee.employeeNumber = carsales.employeeNumber
    ORDER BY lastName;
    
-- SUB QUERIES
-- equality: returns the employee working on 'radio head units'
SELECT concat(employee.firstName,' ',employee.lastname) as 'Employee Name', position
	FROM employee
    WHERE employeeNumber = 
		(SELECT employeeNumber
        FROM repairs
        WHERE partName = 'Radio Head Units');
        
-- subquery aggregates: min and max
SELECT modelYear as 'Year', carMake, engineType, fuelType, carPrice
	FROM carsales
    WHERE carPrice = 
		(SELECT min(carPrice)
        FROM carsales);
        
SELECT modelYear as 'Year', carMake, engineType, fuelType, carPrice
	FROM carsales
    WHERE carPrice = 
		(SELECT max(carPrice)
        FROM carsales);
		

-- create users and grants appropriate privileges to those users.
-- user account and grants for the OWNER
CREATE USER DealershipOwner IDENTIFIED BY 'owner'; 
grant all on car_dealer.* to DealershipOwner with grant option;

-- user account for the employee
create user SalesAgent identified by 'agent';
grant insert, update, delete, select on carsales to SalesAgent ;
grant select on librabry.* to SalesAgent;

create user CarMechanic identified by 'mechanic';
grant insert, update, delete, select on repairs to CarMechanic;
grant update on carparts to SalesAgent;

-- show grants
show grants for DealershipOwner;
show grants for SalesAgent;
show grants for CarMechanic;

-- END
