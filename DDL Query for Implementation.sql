-- syntax of this code is that for column names we write as if one word
-- primary keys and foreign keys are described with table name, however instead of t value, it is abbreviation of key
DROP TABLE IF EXISTS equipmentestimate_t;
DROP TABLE IF EXISTS equipmentutilized_t;
DROP TABLE IF EXISTS skillestimate_t;
DROP TABLE IF EXISTS partsestimate_t;
DROP TABLE IF EXISTS partutilized_t;
DROP TABLE IF EXISTS repair_t;
DROP TABLE IF EXISTS repairestimate_t;
DROP TABLE IF EXISTS automobile_t;
DROP TABLE IF EXISTS customer_t;
DROP TABLE IF EXISTS manager_t;
DROP TABLE IF EXISTS employee_t;
DROP TABLE IF EXISTS part_t;
DROP TABLE IF EXISTS skill_t;
DROP TABLE IF EXISTS equipment_t;
DROP TABLE IF EXISTS technician_t;

--Creates table Customer
CREATE TABLE customer_t(
	customerid					numeric		NOT NULL,
	customername					varchar,
	customerphonenumber				BIGINT,
	customeraddress					varchar,
CONSTRAINT customer_PK PRIMARY KEY (customerid));

-- creates table automobile
CREATE TABLE automobile_t(
	automobilevin					varchar		NOT NULL,
	automobileyear					int,
	automobilemake					varchar,
	automobilemodel					varchar,
	customerid					numeric,
CONSTRAINT automobile_PK PRIMARY KEY (automobilevin),
CONSTRAINT automobile_FK FOREIGN KEY (customerid) REFERENCES customer_t(customerid));

--creates table employee super type
CREATE TABLE employee_t(
	employeeid					numeric		NOT NULL,
	employeename					varchar,
	employeephonenumber				BIGINT,
	employeedateofhire				date,
	employeetype					varchar,
CONSTRAINT employee_PK PRIMARY KEY (employeeid));


--create manager table subtype
CREATE TABLE manager_t(
	memployeeid					numeric		NOT NULL,
	repairid					numeric		NOT NULL,
CONSTRAINT manager_pk PRIMARY KEY (memployeeid, repairid));

-- create repair estimate table
CREATE TABLE repairestimate_t(
	repairestimateid				numeric		NOT NULL,
	repairestimatedescription			varchar,
	repairestimateamount				numeric,
	repairestimatecompletiondate			date,
	employeeid					numeric,
	customerid					numeric,
	automobilevin					varchar,
CONSTRAINT repairestimate_PK PRIMARY KEY (repairestimateid),
CONSTRAINT repairestimate_FK1 FOREIGN KEY (employeeid) REFERENCES employee_T(employeeid),
CONSTRAINT repairestimate_FK2 FOREIGN KEY (customerid) REFERENCES customer_t(customerid),
CONSTRAINT repairestimate_FK3 FOREIGN KEY (automobilevin) REFERENCES automobile_t(automobilevin));


--CREATE REPAIR TABLE
CREATE TABLE repair_t(
	repairid					numeric		NOT NULL,
	repairdescription				varchar,
	repairinitiationdate				date,
	repairdepositamount				numeric,
	repaircompletiondate				date,
	repairtotalamount				INT,
	automobilevin					varchar,
	repairestimateid				numeric,
	customerid					numeric,
CONSTRAINT repair_PK PRIMARY KEY (repairid),
CONSTRAINT repair_FK1 FOREIGN KEY (automobilevin) REFERENCES automobile_t(automobilevin),
CONSTRAINT repair_FK2 FOREIGN KEY (repairestimateid) REFERENCES repairestimate_t(repairestimateid),
CONSTRAINT repair_FK3 FOREIGN KEY (customerid) REFERENCES customer_t(customerid));

--create parts table
CREATE TABLE part_t(
	partid						numeric		NOT NULL,
	partdescription					VARCHAR,
	partunitcost					numeric,
	partquantityonhand				INTEGER,
CONSTRAINT part_PK PRIMARY KEY (partid));

-- creats parts utilized third relation table when there's a many to many relationshp
CREATE TABLE partutilized_t(
	repairid					numeric		NOT NULL,
	partid						numeric		NOT NULL,
	partconsumptiondate				date,
	partquantityconsumer				varchar,
CONSTRAINT partutilized_PK PRIMARY KEY (repairid, partid));

-- creats parts ESTIMATE third relation table when there's a many to many relationshp
CREATE TABLE partsestimate_t(
	repairestimateid				numeric		NOT NULL,
	partid						numeric		NOT NULL,
	partquantityrequired			integer,
CONSTRAINT partsestimate_PK PRIMARY KEY (repairestimateid, partid));

-- create equipment id
CREATE TABLE equipment_t(
	equipmentid					numeric		not null,
	equipmentdescription				varchar,
	equipmentmanufacturer				varchar,
	equipmentmodel					varchar,
CONSTRAINT equipment_PK PRIMARY KEY (equipmentid));

CREATE TABLE equipmentestimate_t(
	repairestimateid				numeric		NOT NULL,
	equipmentid					numeric		not null,
	equipmenthoursrequired				integer,
CONSTRAINT equipmentestimate_PK PRIMARY KEY (repairestimateid, equipmentid));

-- creates skill ESTIMATE third relation table when there's a many to many relationshp
CREATE TABLE skillestimate_t(
	repairestimateid				numeric		NOT NULL,
	skillid						numeric		NOT NULL,
	skillhoursrequired				integer,
CONSTRAINT skillestimate_PK PRIMARY KEY (repairestimateid, skillid));

CREATE TABLE technician_t(
	repairid					numeric		 UNIQUE NOT NULL,
	temployeeid					numeric		not null,
	technicianstartdateandtime			date,
	technicianenddateandtime			date,
CONSTRAINT technician_PK PRIMARY KEY (temployeeid));


CREATE TABLE skill_t(
	skillid						numeric		NOT NULL,
	skillname					varchar,
	skilldescription				varchar,
	temployeeid					numeric,
CONSTRAINT skill_PK PRIMARY KEY (skillid),
CONSTRAINT skill_FK FOREIGN KEY (temployeeid) REFERENCES technician_t(temployeeid));

CREATE TABLE equipmentutilized_t(
	equipmentid					numeric		not null,
	repairid					numeric		NOT NULL,
	equipmentcheckindateandtime			date,
	equipmentcheckoutdateandtime			date,
	temployeeid					numeric,
CONSTRAINT equipmentutilized_PK PRIMARY KEY (equipmentid, repairid),
CONSTRAINT equipmentutilized_FK FOREIGN KEY (temployeeid) REFERENCES technician_t(temployeeid));


--insert into customer table
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('01', 'Bruce Wayne', 8082738593,'20406 Shadow Oak Ct');
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('02', 'Thomas Jefferson', 8088569022,'118 Arrow Dr');
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('03', 'Frank Robinson', 8084859222,'619 N College St');
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('04', 'Jackie Robinson', 8083867900,'107 Harvard Dr');
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('05', 'Pete Alonso', 8081849276,'1043 Buckner St');
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('06', 'Nolan Arenado', 8087456284,'124 Cascade Dr');
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('07', 'Lars Nootbar', 8082853900,'22215 138th Avenue Ct E');
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('08', 'Paul Goldschmidt', 8081845723,'459 Gerard St');
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('09', 'Adam Wainwright', 8088458394,'576 Snowden Rd');
INSERT INTO customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
VALUES('10', 'Albert Pujols', 8084756921,'153 Main St');
--insert into customer_t("customerid", "customername", "customerphonenumber", "customeraddress")
--values();
-- we insert the values as outlined above

--insert into automobile table
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('Y9I2SGWCFA743AREX', 2008, 'Honda', 'Civic', '01');
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('T3KI65J2N2ZUSA93L', 2015, 'Ford', 'Mustang', '02');
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('PTX91NE08EOC4RBND', 2019, 'Chevrolet', 'Suburban', '03');
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('NX6T21G6TYQH4EIIV', 1996, 'Toyota', 'Camry', '04');
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('GO1CHCRV6QCK3H4YU', 2012, 'Audi', 'Q5', '05');
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('NK432GF036T9L0WL0', 2003, 'Mercedes-Benz', 'SLK230', '06');
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('K9H9580J4VC150RUG', 2010, 'Jeep', 'Grand Cherokee', '07');
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('BYL5I0SFRYKUWAJHX', 2000, 'Subaru', 'Forester', '08');
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('ZUY1VRJHQG6NAU9JY', 2018, 'Hyundai', 'Sonata', '09');
INSERT INTO automobile_t("automobilevin", "automobileyear", "automobilemake","automobilemodel","customerid")
VALUES('XENVYG1MWFAEOOBS5', 2014, 'Toyota', 'Prius', '10');

--insert into employee table
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0001', 'Paul Dejong', 6558840019, '2010-10-19', 'technician');
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0002', 'Harrison Bader', 7114326460, '2011-04-01', 'technician');
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0003', 'Dylan Carlson', 8034691801, '2013-01-04', 'manager');
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0004', 'Mike Trout', 4664291281, '2013-06-19', 'manager');
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0005', 'Nolan Gorman', 8419535911, '2014-08-08', 'technician');
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0006', 'Ichiro Suzuki', 8643401994, '2017-12-20', 'technician');
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0007', 'Robinson Cano', 7225143431, '2015-04-17', 'technician');
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0008', 'Edgar Martinez', 3883055328, '2015-12-31', 'manager');
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0009', 'Max Scherzer', 8083745666, '2018-05-08', 'manager');
INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
VALUES ('0010', 'Aaron Judge', 8089365412, '2021-06-17', 'manager');
--INSERT INTO employee_t("employeeid", "employeename", "employeephonenumber", "employeedateofhire", "employeetype")
--values();
-- we insert the values as outlined above

--insert into technician table
INSERT INTO technician_t("repairid", "temployeeid", "technicianstartdateandtime", "technicianenddateandtime")
VALUES (0001,0001,'2020-12-31', '2021-01-31');
INSERT INTO technician_t("repairid", "temployeeid", "technicianstartdateandtime", "technicianenddateandtime")
VALUES (0002,0002, '2021-03-31', '2021-04-02');
INSERT INTO technician_t("repairid", "temployeeid", "technicianstartdateandtime", "technicianenddateandtime")
VALUES (0003,0005, '2020-05-13', '2020-05-14');
INSERT INTO technician_t("repairid", "temployeeid", "technicianstartdateandtime", "technicianenddateandtime")
VALUES (0004,0003, '2021-12-20', '2022-02-22');
INSERT INTO technician_t("repairid", "temployeeid", "technicianstartdateandtime", "technicianenddateandtime")
VALUES (0005,0004, '2022-08-21', '2022-09-04');


--insert into manager table
INSERT INTO manager_t("memployeeid", "repairid")
VALUES ('0001', 0003);
INSERT INTO manager_t("memployeeid", "repairid")
VALUES ('0002', 0004);
INSERT INTO manager_t("memployeeid", "repairid")
VALUES ('0003', 0002);
INSERT INTO manager_t("memployeeid", "repairid")
VALUES ('0004', 0001);
INSERT INTO manager_t("memployeeid", "repairid")
VALUES ('0005', 0004);


--insert into repair estimate table
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
VALUES('0001','change tires', 500.3, '2022-05-17', '0005', '01','Y9I2SGWCFA743AREX');
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
values('0002', 'refill oil', 50, '2018-03-24', '0001','02','T3KI65J2N2ZUSA93L');
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
values('0003', 'replace engine', 3000.43, '2015-10-20', '0002', '03','PTX91NE08EOC4RBND');
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
values('0004', 'replace car door', 600, '2017-08-01', '0002', '04','NX6T21G6TYQH4EIIV');
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
values('0005', 'tint windows', 400.57, '2017-10-02', '0003', '05','GO1CHCRV6QCK3H4YU');
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
values('0006', 'replace stereo', 100, '2015-11-10', '0003', '06','NK432GF036T9L0WL0');
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
values('0007', 'change tires', 750, '2022-05-19', '0004', '07','K9H9580J4VC150RUG');
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
values('0008', 'rotate tires', 60.23, '2019-01-08', '0005','08','BYL5I0SFRYKUWAJHX');
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
values('0009', 'change oil', 40, '2016-01-15', '0005', '09','ZUY1VRJHQG6NAU9JY' );
INSERT INTO repairestimate_t("repairestimateid", "repairestimatedescription", "repairestimateamount", "repairestimatecompletiondate", "employeeid", "customerid", "automobilevin")
values('00010', 'replace transmission', 1000, '2020-10-30', '0005', '10','XENVYG1MWFAEOOBS5');
-- we insert the values as outlined above


--insert into repair table
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0001, 'change tires', '2015-10-28', 500, '2015-11-02', 850.25, 'ZUY1VRJHQG6NAU9JY', '0003', '06');
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0002, 'refill oil', '2015-11-12', 500, '2015-11-19', 795, 'GO1CHCRV6QCK3H4YU', '0006', '05');
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0003, 'replace engine', '2016-01-26', 150, '2016-01-29', 300, 'PTX91NE08EOC4RBND', '0009', '04');
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0004, 'replace car door', '2018-03-27', 375, '2018-03-29', 485, 'NK432GF036T9L0WL0', '0002', '09');
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0005, 'tint windows', '2016-01-26', 550, '2016-01-31', 900.63, 'NX6T21G6TYQH4EIIV', '0005', '08');
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0006, 'replace stereo', '2019-01-11', 100, '2019-01-15', 225, 'K9H9580J4VC150RUG', '0008', '07');
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0007, 'change tires', '2019-02-13', 185, '2022-05-27', 350.47, 'Y9I2SGWCFA743AREX', '0001', '10');
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0008, 'rotate tires', '2017-08-05', 220, '2017-08-20', 250, 'XENVYG1MWFAEOOBS5', '0004', '01');
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0009, 'change oil', '2020-05-20', 330, '2020-05-21', 500, 'XENVYG1MWFAEOOBS5', '0007', '02');
INSERT INTO repair_t("repairid", "repairdescription", "repairinitiationdate", "repairdepositamount", "repaircompletiondate", "repairtotalamount", "automobilevin", "repairestimateid", "customerid")
VALUES (0010, 'replace transmission', '2020-11-05', 600, '2020-11-14', 1150.55, 'T3KI65J2N2ZUSA93L', '0003', '03');


--insert into parts
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values ('0001', 'tire', 100.14, 3);
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values('0002', 'oil', 40, 10);
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values('0003','stereo',200,2);
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values('0004', 'transmission fluid', 50, 4);
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values('0005','car door', 100.33, 5);
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values('0006', 'lights', 20, 10);
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values('0007','axis rotation', 500, 2);
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values('0008', 'license plates', 25.77, 30);
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values('0009', 'bass booster', 98, 20);
INSERT INTO part_t("partid", "partdescription", "partunitcost", "partquantityonhand")
values('00010', 'tinted windows', 120, 4);
-- we insert the values as outlined above

--insert into parts utilized
INSERT INTO partutilized_t("repairid", "partid","partconsumptiondate","partquantityconsumer")
VALUES(0001,'0004','2022-03-22', 'Marc');
INSERT INTO partutilized_t("repairid", "partid","partconsumptiondate","partquantityconsumer")
VALUES(0003,'0002', '2022-04-21', 'Jack');
INSERT INTO partutilized_t("repairid", "partid","partconsumptiondate","partquantityconsumer")
VALUES(0004,'0001', '2022-02-22', 'Nick');
INSERT INTO partutilized_t("repairid", "partid","partconsumptiondate","partquantityconsumer")
VALUES(0004,'0005', '2021-04-21', 'Alexa');
INSERT INTO partutilized_t("repairid", "partid","partconsumptiondate","partquantityconsumer")
VALUES(0002,'0008', '2020-04-21', 'Valerie');
-- we insert the values as outlined above

--insert into parts estimate
INSERT INTO partsestimate_t("repairestimateid", "partid", "partquantityrequired")
values('001', '0001', 1);
INSERT INTO partsestimate_t("repairestimateid", "partid", "partquantityrequired")
values('005', '0004', 2);
INSERT INTO partsestimate_t("repairestimateid", "partid", "partquantityrequired")
values('007', '003', 8);
INSERT INTO partsestimate_t("repairestimateid", "partid", "partquantityrequired")
values('0010', '0009', 4);
INSERT INTO partsestimate_t("repairestimateid", "partid", "partquantityrequired")
values('002', '0006', 11);


--INSERT INTO skill estimate
INSERT INTO skillestimate_t("repairestimateid", "skillid", "skillhoursrequired")
VALUES('0001', '0001', 4);
INSERT INTO skillestimate_t("repairestimateid", "skillid", "skillhoursrequired")
VALUES('0003', '0002', 13);
INSERT INTO skillestimate_t("repairestimateid", "skillid", "skillhoursrequired")
VALUES('0009', '0008', 12);
INSERT INTO skillestimate_t("repairestimateid", "skillid", "skillhoursrequired")
VALUES('0007', '0004',24);
INSERT INTO skillestimate_t("repairestimateid", "skillid", "skillhoursrequired")
VALUES('0002', '0005',5);

--insert into equipment
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('001', 'wrench', 'yamaha', 'h2-451');
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('002', 'car lifter','lear', 'a12');
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('003', 'tire axis', 'tenneco', 'a42-124-a4');
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('004', 'car bolts', 'BorgWarner', 'a54-14a4');
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('005', 'automated machines', 'visteon', 'd124');
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('006', 'safety gear', 'Standard Motor Products', 's1351');
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('007', 'Electricity conductor', 'tesla', 'b2351');
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('008','Oil Filter', 'cooper tire & rubber company', 'c25fw4');
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('009','Air Convector', 'Goodyear tire and rubber company', 'ewtt4');
INSERT INTO equipment_t("equipmentid","equipmentdescription","equipmentmanufacturer","equipmentmodel")
values('0010', 'Electricity Circuit board', 'Ford', 'piwt93');

--insert into equipment estimate
INSERT INTO equipmentestimate_t("repairestimateid", "equipmentid", "equipmenthoursrequired")
VALUES('0007', '001', 9);
INSERT INTO equipmentestimate_t("repairestimateid", "equipmentid", "equipmenthoursrequired")
VALUES('0002', '004', 14);
INSERT INTO equipmentestimate_t("repairestimateid", "equipmentid", "equipmenthoursrequired")
VALUES('0004', '007', 23);
INSERT INTO equipmentestimate_t("repairestimateid", "equipmentid", "equipmenthoursrequired")
VALUES('0009', '003', 3); 
INSERT INTO equipmentestimate_t("repairestimateid", "equipmentid", "equipmenthoursrequired")
VALUES('00010', '002', 34);


--insert into skills
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('0001','strength', 'can lift over 200 pounds', 0003);
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('0002', 'hardware understanding', 'can work on mechanical issues', 0002);
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('0003','social', 'can interact with customers', 0003);
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('0004','leader', 'can lead teams', 0001);
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('0005','programmer', 'can write code for digital aspects of business', 0004);
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('0006','Marketing', 'can increase brand awareness', 0001);
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('0007','finance', 'can handle firms finances', 0005);
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('0008','accountant', 'can record inventory for', 0005);
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('0009','shopper', 'can purchase needed parts for firm', 0001);
INSERT INTO skill_t("skillid", "skillname", "skilldescription", "temployeeid")
values ('00010','social media','outreach', 0003);

INSERT INTO equipmentutilized_t("equipmentid", "repairid", "equipmentcheckindateandtime", "equipmentcheckoutdateandtime", "temployeeid")
VALUES('006', '0001', '2015-10-29', '2015-10-28', '0004');
INSERT INTO equipmentutilized_t("equipmentid", "repairid", "equipmentcheckindateandtime", "equipmentcheckoutdateandtime", "temployeeid")
VALUES('009', '0003', '2016-01-28', '2016-01-26', '0001');
INSERT INTO equipmentutilized_t("equipmentid", "repairid", "equipmentcheckindateandtime", "equipmentcheckoutdateandtime", "temployeeid")
VALUES('003', '0005', '2016-01-29', '2016-01-26', '0001');
INSERT INTO equipmentutilized_t("equipmentid", "repairid", "equipmentcheckindateandtime", "equipmentcheckoutdateandtime", "temployeeid")
VALUES('004', '0007', '2022-05-23', '2022-05-21', '0002');
INSERT INTO equipmentutilized_t("equipmentid", "repairid", "equipmentcheckindateandtime", "equipmentcheckoutdateandtime", "temployeeid")
VALUES('001', '0009', '2020-05-20', '2020-05-20', '0005');