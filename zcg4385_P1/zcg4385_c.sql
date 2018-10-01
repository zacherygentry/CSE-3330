-- Class: CSE 3330
-- Semester: Fall
-- Student Name: Gentry, Zachery, zcg4385
-- Student ID: 1001144385
-- Assignment: Project #1


DROP TABLE IF EXISTS Plane;
CREATE TABLE Plane (
ID int NOT NULL DEFAULT 1,
Maker varchar(15) DEFAULT NULL,
Model varchar(15) DEFAULT NULL,
LastMaint DATE,
LastMaintA varchar(15),
PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS PlaneType;
CREATE TABLE PlaneType (
Maker varchar(15) DEFAULT '',
Model varchar(15) DEFAULT '',
FlyingSpeed DECIMAL(10, 2),
GroundSpeed DECIMAL(10, 2),
PRIMARY KEY (Maker, Model)
);

DROP TABLE IF EXISTS FlightLeg;
CREATE TABLE FlightLeg (
FLNO int,
Seq varchar(15),
FromA varchar(15),
ToA varchar(15),
DeptTime time,
ArrTime time,
Plane int,
PRIMARY KEY (FLNO, Seq)
);

DROP TABLE IF EXISTS PlaneSeats;
CREATE TABLE PlaneSeats (
Maker varchar(15),
Model varchar(15),
SeatType varchar(15),
NoOfSeats int,
PRIMARY KEY (Maker, Model, SeatType)
);

DROP TABLE IF EXISTS Airport;
CREATE TABLE Airport (
Code char(3),
City varchar(15),
State char(2),
PRIMARY KEY (Code)
);

DROP TABLE IF EXISTS FlightLegInstance;
CREATE TABLE FlightLegInstance (
Seq varchar(15),
FLNO int,
FDate DATE,
ActDept varchar(15),
ActArr varchar(15),
Pilot int,
PRIMARY KEY (Seq, FLNO, FDate)
);

DROP TABLE IF EXISTS Flight;
CREATE TABLE Flight (
FLNO int,
Meal varchar(15),
Smoking char(1),
PRIMARY KEY (FLNO)
);

DROP TABLE IF EXISTS Pilot;
CREATE TABLE Pilot (
ID int,
Name varchar(15),
DateHired DATE,
PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS FlightInstance;
CREATE TABLE FlightInstance (
FLNO int,
FDate DATE,
PRIMARY KEY (FLNO)
);

DROP TABLE IF EXISTS Reservation;
CREATE TABLE Reservation (
PassID int,
FLNO int,
FDate DATE,
FromA varchar(15),
ToA varchar(15),
SeatClass varchar(15),
DateBooked DATE,
DateCancelled DATE,
PRIMARY KEY (PassID, FLNO, FDate)
);

DROP TABLE IF EXISTS Passenger;
CREATE TABLE Passenger (
ID int,
Name varchar(15),
Phone varchar(15),
PRIMARY KEY (ID)
);