-- Class: CSE 3330
-- Semester: Fall 2018
-- Student Name: Gentry, Zachery, zcg4385
-- Student ID: 1001144385
-- Assignment: Project #2


-- Get ID, Model, Last Maintenance from all planes manufactures by Boeing
SELECT ID, Model, LastMaint
FROM Plane
WHERE Maker = 'BOEING';

-- Get all names of passengers whose flight had a 'Meal' as an option.
SELECT Name FROM Passenger, Reservation AS R, Flight AS F WHERE ID=PassID AND R.FLNO=F.FLNO AND F.Meal=1;

-- Get names of Pilots who flew from TX
SELECT Name 
FROM Pilot, FlightLegInstance as FLI, FlightLeg as FL, Airport 
WHERE ID=Pilot AND (FLI.FLNO,FLI.Seq)=(FL.FLNO,FL.Seq) AND FL.FromA=Airport.Code AND State='TX';

-- Get total number of takeoffs for pilot 'Jones'
SELECT COUNT(FLI.Pilot)
FROM FlightLegInstance AS FLI, Pilot AS P 
WHERE P.ID=FLI.Pilot AND P.Name='Jones';

-- Get Maker, Model, and Number of seats of planes with more than 300 seats
SELECT * FROM 
    (SELECT Maker, Model, SUM(NoOfSeats) as count 
    FROM PlaneSeats 
    GROUP BY Maker, Model) p
WHERE p.count > 300;

-- Get maker and the total number of planes by this maker who make planes with more than 350 total seats
SELECT Maker, COUNT(*)
FROM Plane
WHERE Maker IN 
    (SELECT p.Maker FROM      (SELECT Maker, Model, SUM(NoOfSeats) as count FROM PlaneSeats GROUP BY Maker, Model) p 
WHERE p.count > 350);