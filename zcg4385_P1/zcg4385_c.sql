-- Class: CSE 3330
-- Semester: Fall
-- Student Name: Gentry, Zachery, zcg4385
-- Student ID: 1001144385
-- Assignment: Project #1

CREATE TABLE Airport (
Code char(3),
City varchar(15),
State char(2),
PRIMARY KEY (Code)
);

CREATE TABLE Flight (
FLNO int,
Meal varchar(15),
Smoking char(1),
PRIMARY KEY (FLNO)
);

CREATE TABLE PlaneType (
Maker varchar(15) DEFAULT '',
Model varchar(15) DEFAULT '',
FlyingSpeed DECIMAL(10, 2),
GroundSpeed DECIMAL(10, 2),
PRIMARY KEY (Maker, Model)
);

CREATE TABLE Pilot (
ID int,
Name varchar(15),
DateHired varchar(15),
PRIMARY KEY (ID)
);

CREATE TABLE Passenger (
ID int,
Name varchar(15),
Phone varchar(15),
PRIMARY KEY (ID)
);

CREATE TABLE FlightInstance (
FLNO int,
FDate varchar(15),
PRIMARY KEY (FLNO, FDate),
FOREIGN KEY (FLNO) references Flight(FLNO)
);

CREATE TABLE PlaneSeats (
Maker varchar(15),
Model varchar(15),
SeatType varchar(15),
NoOfSeats int,
PRIMARY KEY (Maker, Model, SeatType),
FOREIGN KEY (Maker, Model) references PlaneType(Maker, Model)
);

CREATE TABLE Plane (
ID int NOT NULL DEFAULT 1,
Maker varchar(15) DEFAULT NULL,
Model varchar(15) DEFAULT NULL,
LastMaint varchar(15),
LastMaintA varchar(15),
PRIMARY KEY (ID),
FOREIGN KEY (Maker, Model) references PlaneType(Maker, Model),
FOREIGN KEY (LastMaintA) references Airport(Code)
);

CREATE TABLE FlightLeg (
FLNO int,
Seq varchar(15),
FromA varchar(15),
ToA varchar(15),
DeptTime varchar(15),
ArrTime varchar(15),
Plane varchar(15),
PRIMARY KEY (FLNO, Seq),
FOREIGN KEY (FLNO) references Flight(FLNO),
FOREIGN KEY (FromA) references Airport(Code),
FOREIGN KEY (ToA) references Airport(Code),
FOREIGN KEY (Plane) references Plane(ID)
);

CREATE TABLE FlightLegInstance (
Seq varchar(15),
FLNO int,
FDate varchar(15),
ActDept varchar(15),
ActArr varchar(15),
Pilot int,
PRIMARY KEY (Seq, FLNO, FDate),
FOREIGN KEY (Seq, FLNO) references FlightLeg(Seq, FLNO),
FOREIGN KEY (FLNO, FDate) references FlightInstance(FLNO, FDate)
);

CREATE TABLE Reservation (
PassID int,
FLNO int,
FDate varchar(15),
FromA varchar(15),
ToA varchar(15),
SeatClass varchar(15),
DateBooked varchar(15),
DateCancelled varchar(15),
PRIMARY KEY (PassID, FLNO, FDate),
FOREIGN KEY (FLNO, FDate) references FlightInstance(FLNO, FDate),
FOREIGN KEY (FromA) references Airport(Code),
FOREIGN KEY (ToA) references Airport(Code)
);