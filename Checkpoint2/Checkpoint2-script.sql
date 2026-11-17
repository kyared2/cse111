-- ============================================================================
-- CSE 111 Fall 2026: Project Checkpoint 2 Script
-- Project Title: AutoLedger: In-depth Rental Vehicle Management System
-- Team Members: Kidus Yared, Alvin Liu
-- File: Checkpoint2-script.sql
-- ============================================================================

-- ============================================================================
-- SCHEMA MODIFICATIONS SINCE CHECKPOINT 1
-- ============================================================================
-- No changes were made to the 10 base tables or their constraints from
-- Checkpoint 1. This script creates one view (AvailableFleet) and two
-- triggers (trg_maintenance_open and trg_maintenance_close) during the
-- complex section; these add database objects without altering base tables.
-- ============================================================================

-- ============================================================================
-- MEMBER CONTRIBUTIONS SUMMARY (GROUPED AT THE TOP)
-- ============================================================================
-- SECTION 1: SIMPLE STATEMENTS
-- Statement 01: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 02: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 03: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 04: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 05: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 06: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 07: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 08: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 09: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 10: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 11: Alvin Liu: 65%, Kidus Yared: 35%
--
-- SECTION 2: INTERMEDIATE STATEMENTS
-- Statement 12: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 13: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 14: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 15: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 16: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 17: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 18: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 19: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 20: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 21: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 22: Alvin Liu: 65%, Kidus Yared: 35%
--
-- SECTION 3: COMPLEX STATEMENTS
-- Statement 23: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 24: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 25: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 26: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 27: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 28: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 29: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 30: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 31: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 32: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 33: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 34: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 35: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 36: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 37: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 38: Alvin Liu: 65%, Kidus Yared: 35%
-- Statement 39: Alvin Liu: 65%, Kidus Yared: 35%
-- ============================================================================

PRAGMA foreign_keys = ON;
.headers on
.mode column


-- ============================================================================
-- SECTION 1: SIMPLE STATEMENTS (Statements 01 to 11)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 01: Branch Locations by City
-- Explanation: List every branch location with its city and phone number,
--              sorted alphabetically by city.
-- ----------------------------------------------------------------------------
SELECT LocationID, LocationName, LocationCity, LocationPhone
FROM Location
ORDER BY LocationCity;

-- ----------------------------------------------------------------------------
-- Statement 02: Ready-to-Rent Vehicles by Price
-- Explanation: Show all vehicles currently marked READY, ordered from the
--              highest daily rate to the lowest.
-- ----------------------------------------------------------------------------
SELECT VehicleID, VehicleMake, VehicleModel, VehicleCategory, DailyRate
FROM Vehicle
WHERE VehicleStatus = 'READY'
ORDER BY DailyRate DESC;

-- ----------------------------------------------------------------------------
-- Statement 03: Customer Last Name Search
-- Explanation: Find customers whose last name starts with the letter M using
--              pattern matching.
-- ----------------------------------------------------------------------------
SELECT CustomerID, CustomerFName, CustomerLName, CustomerEmail
FROM Customer
WHERE CustomerLName LIKE 'M%';

-- ----------------------------------------------------------------------------
-- Statement 04: Car Daily Rate Summary
-- Explanation: Count the cars in the fleet and compute their lowest, highest
--              and average daily rate.
-- ----------------------------------------------------------------------------
SELECT COUNT(*) AS NumCars,
       MIN(DailyRate) AS MinRate,
       MAX(DailyRate) AS MaxRate,
       ROUND(AVG(DailyRate), 2) AS AvgRate
FROM Vehicle
WHERE VehicleCategory = 'CAR';

-- ----------------------------------------------------------------------------
-- Statement 05: Vehicle Categories and Meter Units
-- Explanation: List each distinct vehicle category along with whether it is
--              tracked in miles or engine hours.
-- ----------------------------------------------------------------------------
SELECT DISTINCT VehicleCategory, MeterUnit
FROM Vehicle
ORDER BY VehicleCategory;

-- ----------------------------------------------------------------------------
-- Statement 06: Licenses Expiring Before 2027
-- Explanation: Find customer licenses that expire before January 1, 2027 so
--              staff can follow up before the next booking.
-- ----------------------------------------------------------------------------
SELECT LicenseID, CustomerID, IssuingAuthority, LicenseExpireDate, LicenseStatus
FROM CustomerLicense
WHERE LicenseExpireDate < '2027-01-01'
ORDER BY LicenseExpireDate;

-- ----------------------------------------------------------------------------
-- Statement 07: Insurance Expiring This Year
-- Explanation: Find vehicles whose insurance expires between today
--              (2026-11-16) and the end of 2026.
-- ----------------------------------------------------------------------------
SELECT VehicleID, VehicleMake, VehicleModel, VehicleInsuranceExp
FROM Vehicle
WHERE VehicleInsuranceExp BETWEEN '2026-11-16' AND '2026-12-31';

-- ----------------------------------------------------------------------------
-- Statement 08: Total Maintenance Spending
-- Explanation: Compute the total amount spent on maintenance across the
--              entire fleet.
-- ----------------------------------------------------------------------------
SELECT ROUND(SUM(ServiceCost), 2) AS TotalMaintenanceCost
FROM MaintenanceRecord;

-- ----------------------------------------------------------------------------
-- Statement 09: Register New Customer
-- Explanation: Insert a new walk-in customer; the CustomerID is assigned
--              automatically.
-- ----------------------------------------------------------------------------
INSERT INTO Customer (CustomerFName, CustomerLName, CustomerDoB, CustomerEmail, CustomerPhone)
VALUES ('Jordan', 'Reyes', '1998-04-09', 'jordan.reyes@example.com', '(209) 555-1016');

-- ----------------------------------------------------------------------------
-- Statement 10: Record a Vehicle Return
-- Explanation: Check in a returned vehicle by recording its ending meter
--              reading and passing return inspection on its RentalVehicle row.
-- ----------------------------------------------------------------------------
UPDATE RentalVehicle
SET MeterIn = 41530,
    RentalAfterCheck = 'PASS',
    RentalAfterComments = 'Returned with full charge'
WHERE RentalID = 12 AND VehicleID = 3;

-- ----------------------------------------------------------------------------
-- Statement 11: Remove Incorrect Rating Requirement
-- Explanation: Delete the Class B requirement that was entered by mistake for
--              the Ford F-150, which only needs a Class C license.
-- ----------------------------------------------------------------------------
DELETE FROM VehicleRequiredRating
WHERE VehicleID = 6 AND RatingID = 2;


-- ============================================================================
-- SECTION 2: INTERMEDIATE STATEMENTS (Statements 12 to 22)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 12: Active and Upcoming Rentals (Multi-Table Join)
-- Explanation: List active and confirmed rentals with the customer's name and
--              both pickup and return branches, joining Location twice.
-- ----------------------------------------------------------------------------
SELECT r.RentalID,
       c.CustomerFName || ' ' || c.CustomerLName AS Customer,
       pl.LocationName AS PickupBranch,
       rl.LocationName AS ReturnBranch,
       r.RentalStart, r.RentalEnd, r.RentalStatus
FROM Rental r
JOIN Customer c ON c.CustomerID = r.CustomerID
JOIN Location pl ON pl.LocationID = r.RentalPickupLocationID
JOIN Location rl ON rl.LocationID = r.RentalReturnLocationID
WHERE r.RentalStatus IN ('ACTIVE', 'CONFIRMED')
ORDER BY r.RentalStart;

-- ----------------------------------------------------------------------------
-- Statement 13: Aircraft by Home Branch (Inner Join)
-- Explanation: Show every aircraft's tail number, status and the branch where
--              it is based.
-- ----------------------------------------------------------------------------
SELECT v.VehicleIdentifier AS TailNumber, v.VehicleMake, v.VehicleModel,
       v.VehicleStatus, l.LocationName
FROM Vehicle v
JOIN Location l ON l.LocationID = v.VehicleLocationID
WHERE v.VehicleCategory = 'AIRCRAFT'
ORDER BY l.LocationName;

-- ----------------------------------------------------------------------------
-- Statement 14: Maintenance History per Vehicle (LEFT OUTER JOIN)
-- Explanation: Count service visits and total service cost for each vehicle,
--              including vehicles that have never been serviced.
-- ----------------------------------------------------------------------------
SELECT v.VehicleID, v.VehicleMake, v.VehicleModel,
       COUNT(m.MaintenanceID) AS ServiceVisits,
       ROUND(COALESCE(SUM(m.ServiceCost), 0), 2) AS TotalServiceCost
FROM Vehicle v
LEFT JOIN MaintenanceRecord m ON m.VehicleID = v.VehicleID
GROUP BY v.VehicleID
ORDER BY TotalServiceCost DESC;

-- ----------------------------------------------------------------------------
-- Statement 15: Fleet Size per Branch (GROUP BY & HAVING)
-- Explanation: Find branches that currently hold more than 3 vehicles to help
--              with fleet distribution decisions.
-- ----------------------------------------------------------------------------
SELECT l.LocationName, COUNT(*) AS FleetSize
FROM Vehicle v
JOIN Location l ON l.LocationID = v.VehicleLocationID
GROUP BY l.LocationID
HAVING COUNT(*) > 3
ORDER BY FleetSize DESC;

-- ----------------------------------------------------------------------------
-- Statement 16: High-Value Customers (GROUP BY & HAVING)
-- Explanation: Find customers whose quoted rentals total more than $500, not
--              counting cancelled rentals.
-- ----------------------------------------------------------------------------
SELECT c.CustomerID, c.CustomerFName, c.CustomerLName,
       SUM(rv.QuotedDailyRate * rv.QuotedDays) AS TotalQuoted
FROM Customer c
JOIN Rental r ON r.CustomerID = c.CustomerID
JOIN RentalVehicle rv ON rv.RentalID = r.RentalID
WHERE r.RentalStatus <> 'CANCELLED'
GROUP BY c.CustomerID
HAVING SUM(rv.QuotedDailyRate * rv.QuotedDays) > 500
ORDER BY TotalQuoted DESC;

-- ----------------------------------------------------------------------------
-- Statement 17: Vehicles Above Average Rate (Scalar Subquery)
-- Explanation: List vehicles whose daily rate is higher than the average daily
--              rate of the whole fleet.
-- ----------------------------------------------------------------------------
SELECT VehicleID, VehicleMake, VehicleModel, DailyRate
FROM Vehicle
WHERE DailyRate > (SELECT AVG(DailyRate) FROM Vehicle)
ORDER BY DailyRate DESC;

-- ----------------------------------------------------------------------------
-- Statement 18: Customer License Ratings (Four-Table Join)
-- Explanation: Show every rating each customer holds on a VALID license, along
--              with the issuing authority and rating expiration date.
-- ----------------------------------------------------------------------------
SELECT c.CustomerFName || ' ' || c.CustomerLName AS Customer,
       cl.IssuingAuthority, lr.RatingCode, lq.QualificationExpireDate
FROM Customer c
JOIN CustomerLicense cl ON cl.CustomerID = c.CustomerID
JOIN LicenseQualification lq ON lq.LicenseID = cl.LicenseID
JOIN LicenseRating lr ON lr.RatingID = lq.RatingID
WHERE cl.LicenseStatus = 'VALID'
ORDER BY c.CustomerLName, lr.RatingCode;

-- ----------------------------------------------------------------------------
-- Statement 19: Customers With No Rentals (LEFT OUTER JOIN)
-- Explanation: Find registered customers who have never made a rental by
--              left joining Rental and filtering for NULLs.
-- ----------------------------------------------------------------------------
SELECT c.CustomerID, c.CustomerFName, c.CustomerLName
FROM Customer c
LEFT JOIN Rental r ON r.CustomerID = c.CustomerID
WHERE r.RentalID IS NULL;

-- ----------------------------------------------------------------------------
-- Statement 20: Pull Overdue Vehicles From Service (Conditional Update)
-- Explanation: Set READY vehicles whose next service date has already passed
--              to MAINTENANCE and record the reason.
-- ----------------------------------------------------------------------------
UPDATE Vehicle
SET VehicleStatus = 'MAINTENANCE',
    VehicleIssues = 'Scheduled service overdue'
WHERE VehicleStatus = 'READY'
  AND VehicleNextServiceDate < '2026-11-16';

-- ----------------------------------------------------------------------------
-- Statement 21: Raise Below-Average Rates (Subquery Update)
-- Explanation: Increase the daily rate by 10% for every non-retired vehicle
--              priced below the average rate of its own category.
-- ----------------------------------------------------------------------------
UPDATE Vehicle
SET DailyRate = ROUND(DailyRate * 1.10, 2)
WHERE VehicleStatus <> 'RETIRED'
  AND DailyRate < (
      SELECT AVG(v2.DailyRate)
      FROM Vehicle v2
      WHERE v2.VehicleCategory = Vehicle.VehicleCategory
  );

-- ----------------------------------------------------------------------------
-- Statement 22: Revenue by Pickup Branch
-- Explanation: Total the quoted revenue and number of rentals for each pickup
--              branch, excluding cancelled rentals.
-- ----------------------------------------------------------------------------
SELECT l.LocationName,
       COUNT(DISTINCT r.RentalID) AS Rentals,
       SUM(rv.QuotedDailyRate * rv.QuotedDays) AS QuotedRevenue
FROM Rental r
JOIN RentalVehicle rv ON rv.RentalID = r.RentalID
JOIN Location l ON l.LocationID = r.RentalPickupLocationID
WHERE r.RentalStatus <> 'CANCELLED'
GROUP BY l.LocationID
ORDER BY QuotedRevenue DESC;


-- ============================================================================
-- SECTION 3: COMPLEX STATEMENTS (Statements 23 to 39)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 23: License Eligibility Check (Correlated NOT EXISTS)
-- Explanation: For confirmed bookings, list each vehicle rating the renter does
--              not hold on a valid license that lasts through the rental.
-- ----------------------------------------------------------------------------
SELECT r.RentalID,
       c.CustomerFName || ' ' || c.CustomerLName AS Customer,
       v.VehicleMake || ' ' || v.VehicleModel AS Vehicle,
       lr.RatingCode AS MissingRating
FROM Rental r
JOIN Customer c ON c.CustomerID = r.CustomerID
JOIN RentalVehicle rv ON rv.RentalID = r.RentalID
JOIN Vehicle v ON v.VehicleID = rv.VehicleID
JOIN VehicleRequiredRating q ON q.VehicleID = v.VehicleID
JOIN LicenseRating lr ON lr.RatingID = q.RatingID
WHERE r.RentalStatus = 'CONFIRMED'
  AND NOT EXISTS (
      SELECT 1
      FROM CustomerLicense cl
      JOIN LicenseQualification lq ON lq.LicenseID = cl.LicenseID
      WHERE cl.CustomerID = r.CustomerID
        AND lq.RatingID = q.RatingID
        AND cl.LicenseStatus = 'VALID'
        AND cl.LicenseExpireDate >= date(r.RentalEnd)
        AND lq.QualificationExpireDate >= date(r.RentalEnd)
  );

-- ----------------------------------------------------------------------------
-- Statement 24: Aircraft Renters (Correlated EXISTS)
-- Explanation: Find customers who have rented at least one aircraft.
-- ----------------------------------------------------------------------------
SELECT c.CustomerID, c.CustomerFName, c.CustomerLName
FROM Customer c
WHERE EXISTS (
    SELECT 1
    FROM Rental r
    JOIN RentalVehicle rv ON rv.RentalID = r.RentalID
    JOIN Vehicle v ON v.VehicleID = rv.VehicleID
    WHERE r.CustomerID = c.CustomerID
      AND v.VehicleCategory = 'AIRCRAFT'
);

-- ----------------------------------------------------------------------------
-- Statement 25: Qualified Pilots for the Baron (Double NOT EXISTS)
-- Explanation: Find customers who hold every rating required to fly the
--              twin-engine Beechcraft Baron (N58BE) on a valid license.
-- ----------------------------------------------------------------------------
SELECT c.CustomerID, c.CustomerFName, c.CustomerLName
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM VehicleRequiredRating q
    JOIN Vehicle v ON v.VehicleID = q.VehicleID
    WHERE v.VehicleIdentifier = 'N58BE'
      AND NOT EXISTS (
          SELECT 1
          FROM CustomerLicense cl
          JOIN LicenseQualification lq ON lq.LicenseID = cl.LicenseID
          WHERE cl.CustomerID = c.CustomerID
            AND lq.RatingID = q.RatingID
            AND cl.LicenseStatus = 'VALID'
      )
);

-- ----------------------------------------------------------------------------
-- Statement 26: Vehicles Needing Attention (UNION)
-- Explanation: Combine vehicles whose insurance expires this year with vehicles
--              whose service is overdue into one list, tagged with the reason.
-- ----------------------------------------------------------------------------
SELECT VehicleID, VehicleMake, VehicleModel, 'Insurance expires ' || VehicleInsuranceExp AS Reason
FROM Vehicle
WHERE VehicleStatus <> 'RETIRED' AND VehicleInsuranceExp <= '2026-12-31'
UNION
SELECT VehicleID, VehicleMake, VehicleModel, 'Service was due ' || VehicleNextServiceDate
FROM Vehicle
WHERE VehicleStatus <> 'RETIRED' AND VehicleNextServiceDate < '2026-11-16'
ORDER BY VehicleID;

-- ----------------------------------------------------------------------------
-- Statement 27: Car and Motorcycle Renters (INTERSECT)
-- Explanation: Find customers who have rented both a car and a motorcycle.
-- ----------------------------------------------------------------------------
SELECT r.CustomerID
FROM Rental r
JOIN RentalVehicle rv ON rv.RentalID = r.RentalID
JOIN Vehicle v ON v.VehicleID = rv.VehicleID
WHERE v.VehicleCategory = 'CAR'
INTERSECT
SELECT r.CustomerID
FROM Rental r
JOIN RentalVehicle rv ON rv.RentalID = r.RentalID
JOIN Vehicle v ON v.VehicleID = rv.VehicleID
WHERE v.VehicleCategory = 'MOTORCYCLE';

-- ----------------------------------------------------------------------------
-- Statement 28: Never-Booked Vehicles (EXCEPT)
-- Explanation: Find vehicles still in the active fleet that have never appeared
--              on any rental.
-- ----------------------------------------------------------------------------
SELECT VehicleID FROM Vehicle WHERE VehicleStatus <> 'RETIRED'
EXCEPT
SELECT VehicleID FROM RentalVehicle;

-- ----------------------------------------------------------------------------
-- Statement 29: Vehicle Utilization Ranking (CTE & DENSE_RANK)
-- Explanation: Use a CTE to total miles/hours used and revenue per vehicle on
--              completed rentals, then rank vehicles by revenue within category.
-- ----------------------------------------------------------------------------
WITH CompletedUse AS (
    SELECT rv.VehicleID,
           SUM(rv.MeterIn - rv.MeterOut) AS UsageAmount,
           SUM(rv.QuotedDailyRate * rv.QuotedDays) AS Revenue
    FROM RentalVehicle rv
    JOIN Rental r ON r.RentalID = rv.RentalID
    WHERE r.RentalStatus = 'COMPLETED'
    GROUP BY rv.VehicleID
)
SELECT v.VehicleCategory, v.VehicleMake, v.VehicleModel,
       ROUND(cu.UsageAmount, 1) AS UsageAmount, v.MeterUnit, cu.Revenue,
       DENSE_RANK() OVER (PARTITION BY v.VehicleCategory ORDER BY cu.Revenue DESC) AS RevenueRank
FROM CompletedUse cu
JOIN Vehicle v ON v.VehicleID = cu.VehicleID
ORDER BY v.VehicleCategory, RevenueRank;

-- ----------------------------------------------------------------------------
-- Statement 30: Latest Service Visit per Vehicle (ROW_NUMBER)
-- Explanation: Use ROW_NUMBER to keep only each vehicle's most recent
--              maintenance visit and show whether it is still in progress.
-- ----------------------------------------------------------------------------
WITH Ranked AS (
    SELECT m.*,
           ROW_NUMBER() OVER (PARTITION BY m.VehicleID ORDER BY m.ServiceStart DESC) AS rn
    FROM MaintenanceRecord m
)
SELECT VehicleID, ServiceStart, ServiceDescription, ServiceCost,
       CASE WHEN ServiceEnd IS NULL THEN 'IN PROGRESS' ELSE 'DONE' END AS State
FROM Ranked
WHERE rn = 1
ORDER BY VehicleID;

-- ----------------------------------------------------------------------------
-- Statement 31: Rental Length and Value Classes (CASE Expressions)
-- Explanation: Label each rental as a short, multi-day or weekly trip and as
--              economy, standard or high value based on its quoted total.
-- ----------------------------------------------------------------------------
SELECT r.RentalID, r.RentalStatus,
       MAX(rv.QuotedDays) AS Days,
       SUM(rv.QuotedDailyRate * rv.QuotedDays) AS QuotedTotal,
       CASE
           WHEN MAX(rv.QuotedDays) <= 2 THEN 'Short trip'
           WHEN MAX(rv.QuotedDays) <= 5 THEN 'Multi-day'
           ELSE 'Weekly'
       END AS LengthClass,
       CASE
           WHEN SUM(rv.QuotedDailyRate * rv.QuotedDays) >= 1000 THEN 'High value'
           WHEN SUM(rv.QuotedDailyRate * rv.QuotedDays) >= 300 THEN 'Standard'
           ELSE 'Economy'
       END AS ValueClass
FROM Rental r
JOIN RentalVehicle rv ON rv.RentalID = r.RentalID
GROUP BY r.RentalID
ORDER BY r.RentalID;

-- ----------------------------------------------------------------------------
-- Statement 32: Bookable Fleet View (CREATE VIEW)
-- Explanation: Create a view of vehicles that can be booked right now: READY,
--              insured, and not past their service date, with the branch name.
-- ----------------------------------------------------------------------------
DROP VIEW IF EXISTS AvailableFleet;

CREATE VIEW AvailableFleet AS
SELECT v.VehicleID, v.VehicleCategory, v.VehicleMake, v.VehicleModel,
       v.DailyRate, l.LocationName, v.VehicleInsuranceExp, v.VehicleNextServiceDate
FROM Vehicle v
JOIN Location l ON l.LocationID = v.VehicleLocationID
WHERE v.VehicleStatus = 'READY'
  AND v.VehicleInsuranceExp >= '2026-11-16'
  AND v.VehicleNextServiceDate >= '2026-11-16';

-- ----------------------------------------------------------------------------
-- Statement 33: Cheapest Bookable Vehicle per Category (Query on View)
-- Explanation: Query the AvailableFleet view to find the lowest-priced bookable
--              vehicle in each category using a correlated subquery.
-- ----------------------------------------------------------------------------
SELECT a.VehicleCategory, a.VehicleMake, a.VehicleModel, a.DailyRate, a.LocationName
FROM AvailableFleet a
WHERE a.DailyRate = (
    SELECT MIN(b.DailyRate)
    FROM AvailableFleet b
    WHERE b.VehicleCategory = a.VehicleCategory
)
ORDER BY a.VehicleCategory;

-- ----------------------------------------------------------------------------
-- Statement 34: Open Maintenance Trigger (Multi-Action Trigger)
-- Explanation: When a maintenance visit is opened, mark the vehicle as in
--              maintenance and raise its meter to the reading taken at the shop.
-- ----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_maintenance_open;

CREATE TRIGGER trg_maintenance_open
AFTER INSERT ON MaintenanceRecord
FOR EACH ROW
WHEN NEW.ServiceEnd IS NULL
BEGIN
    UPDATE Vehicle
    SET VehicleStatus = 'MAINTENANCE'
    WHERE VehicleID = NEW.VehicleID AND VehicleStatus <> 'RETIRED';

    UPDATE Vehicle
    SET VehicleMeter = NEW.MeterAtService
    WHERE VehicleID = NEW.VehicleID AND VehicleMeter < NEW.MeterAtService;
END;

-- ----------------------------------------------------------------------------
-- Statement 35: Close Maintenance Trigger (Multi-Action Trigger)
-- Explanation: When a maintenance visit is closed, return the vehicle to
--              service, clear its issue notes and schedule service 90 days out.
-- ----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_maintenance_close;

CREATE TRIGGER trg_maintenance_close
AFTER UPDATE OF ServiceEnd ON MaintenanceRecord
FOR EACH ROW
WHEN OLD.ServiceEnd IS NULL AND NEW.ServiceEnd IS NOT NULL
BEGIN
    UPDATE Vehicle
    SET VehicleStatus = 'READY',
        VehicleIssues = NULL,
        VehicleFlags = NULL,
        VehicleNextServiceDate = date(NEW.ServiceEnd, '+90 days')
    WHERE VehicleID = NEW.VehicleID AND VehicleStatus = 'MAINTENANCE';
END;

-- ----------------------------------------------------------------------------
-- Statement 36: Open Service Visit (Fires trg_maintenance_open)
-- Explanation: Insert a maintenance visit for the overdue Chevrolet Malibu,
--              which fires the open-maintenance trigger.
-- ----------------------------------------------------------------------------
INSERT INTO MaintenanceRecord (VehicleID, ServiceStart, ServiceEnd, ServiceDescription, ServiceCost, MeterAtService)
VALUES (5, '2026-11-16 08:00', NULL, 'Overdue oil change and inspection', 129.95, 67105);

-- ----------------------------------------------------------------------------
-- Statement 37: Close Service Visit (Fires trg_maintenance_close)
-- Explanation: Record the end time of the Ford Explorer's brake job, which
--              fires the close-maintenance trigger.
-- ----------------------------------------------------------------------------
UPDATE MaintenanceRecord
SET ServiceEnd = '2026-11-16 15:30'
WHERE MaintenanceID = 3;

-- ----------------------------------------------------------------------------
-- Statement 38: Verify Trigger Results
-- Explanation: Show the Malibu and Explorer after the two service changes to
--              confirm both triggers updated their status, meter and dates.
-- ----------------------------------------------------------------------------
SELECT VehicleID, VehicleMake, VehicleModel, VehicleMeter, VehicleStatus,
       VehicleNextServiceDate, VehicleIssues
FROM Vehicle
WHERE VehicleID IN (4, 5);

-- ----------------------------------------------------------------------------
-- Statement 39: Bookable Cars After Service Updates (Query on View)
-- Explanation: Query the AvailableFleet view for cars; the Explorer now appears
--              because its brake job was closed.
-- ----------------------------------------------------------------------------
SELECT VehicleID, VehicleMake, VehicleModel, LocationName
FROM AvailableFleet
WHERE VehicleCategory = 'CAR'
ORDER BY VehicleID;
