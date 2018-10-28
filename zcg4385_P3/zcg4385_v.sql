-- Class: CSE 3330
-- Semester: Fall 2018
-- Student Name: Gentry, Zachery, zcg4385
-- Student ID: 1001144385
-- Assignment: project #3

-- Flights with no assigned pilots
-- View which selects all Flights which don't have a pilot assigned to them
CREATE VIEW UnassignedPilotFlights AS 
SELECT FLNO, Seq, FDate
FROM FlightLegInstance, Pilot
WHERE FlightLegInstance.Pilot = NULL;


-- Planes due for maintenance
-- View which selects all planes which were last maintained over 60 days ago
CREATE VIEW DueForMaintenancePlanes AS
SELECT ID, Maker, Model, LastMaint
FROM Plane
WHERE datediff(CURDATE(), LastMaint) > 60;


-- Pilot Flying Assignments
-- View which selects all of the pilots and their planned flight assigments ordered by the Pilots' IDs
CREATE VIEW PilotFlyAssignments AS
SELECT distinct ID, Name, FL.FLNO, From_City.City AS F, To_City.City AS T, FLI.FDate
FROM Airport To_City
JOIN Airport From_City
JOIN FlightLeg AS FL
    ON FL.ToA = To_City.Code AND FL.FromA = From_City.Code
JOIN FlightLegInstance AS FLI
    ON (FLI.FLNO, FLI.Seq) = (FL.FLNO, FL.Seq)
JOIN Pilot
    ON FLI.Pilot = Pilot.ID
ORDER BY ID ASC;


-- Pilot flight legs count for month/year
-- The number of flight legs a pilot has done grouped by month and year
CREATE VIEW PilotFlightLegsCount AS
SELECT ID, Name, MONTH(FDate), YEAR(FDate), COUNT(FLI.Seq)
FROM FlightLegInstance AS FLI
JOIN Pilot
    ON Pilot.ID = FLI.Pilot
GROUP BY ID, MONTH(FDate), YEAR(FDate);