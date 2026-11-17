PRAGMA foreign_keys = ON;

CREATE TABLE Customer (
  CustomerID INTEGER PRIMARY KEY,
  CustomerFName VARCHAR(60) NOT NULL,
  CustomerLName VARCHAR(60) NOT NULL,
  CustomerDoB DATE NOT NULL,
  CustomerEmail VARCHAR(254) NOT NULL,
  CustomerPhone VARCHAR(30) NOT NULL
);

CREATE TABLE Location (
  LocationID INTEGER PRIMARY KEY,
  LocationName VARCHAR(100) NOT NULL UNIQUE,
  LocationAddress VARCHAR(200) NOT NULL,
  LocationCity VARCHAR(80) NOT NULL,
  LocationState VARCHAR(50) NOT NULL,
  LocationPhone VARCHAR(30) NOT NULL
);

CREATE TABLE LicenseRating (
  RatingID INTEGER PRIMARY KEY,
  RatingCode VARCHAR(50) NOT NULL UNIQUE,
  RatingDescription VARCHAR(200) NOT NULL
);

CREATE TABLE CustomerLicense (
  LicenseID INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL REFERENCES Customer(CustomerID)
    ON DELETE RESTRICT,
  LicenseNumber VARCHAR(60) NOT NULL,
  IssuingAuthority VARCHAR(100) NOT NULL,
  LicenseIssueDate DATE NOT NULL,
  LicenseExpireDate DATE NOT NULL,
  LicenseStatus VARCHAR(15) NOT NULL
    CHECK (LicenseStatus IN ('VALID','SUSPENDED','REVOKED')),
  UNIQUE (IssuingAuthority, LicenseNumber),
  CHECK (LicenseExpireDate >= LicenseIssueDate)
);

CREATE TABLE Vehicle (
  VehicleID INTEGER PRIMARY KEY,
  VehicleMake VARCHAR(60) NOT NULL,
  VehicleModel VARCHAR(80) NOT NULL,
  VehicleCategory VARCHAR(15) NOT NULL
    CHECK (VehicleCategory IN ('CAR','TRUCK','MOTORCYCLE','AIRCRAFT')),
  VehicleIdentifier VARCHAR(60) NOT NULL UNIQUE,
  IdentifierType VARCHAR(20) NOT NULL
    CHECK (IdentifierType IN ('VIN','REGISTRATION')),
  MeterUnit VARCHAR(15) NOT NULL
    CHECK (MeterUnit IN ('MILES','HOURS')),
  VehicleMeter DECIMAL(12,2) NOT NULL CHECK (VehicleMeter >= 0),
  VehicleStatus VARCHAR(15) NOT NULL
    CHECK (VehicleStatus IN ('READY','MAINTENANCE','RETIRED')),
  VehicleNextServiceDate DATE NOT NULL,
  VehicleInsuranceExp DATE NOT NULL,
  DailyRate DECIMAL(10,2) NOT NULL CHECK (DailyRate >= 0),
  VehicleLocationID INTEGER NOT NULL REFERENCES Location(LocationID)
    ON DELETE RESTRICT,
  VehicleFlags TEXT,
  VehicleComments TEXT,
  VehicleIssues TEXT
);

CREATE TABLE Rental (
  RentalID INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL REFERENCES Customer(CustomerID)
    ON DELETE RESTRICT,
  RentalPickupLocationID INTEGER NOT NULL REFERENCES Location(LocationID)
    ON DELETE RESTRICT,
  RentalReturnLocationID INTEGER NOT NULL REFERENCES Location(LocationID)
    ON DELETE RESTRICT,
  RentalStart DATETIME NOT NULL,
  RentalEnd DATETIME NOT NULL,
  RentalStatus VARCHAR(15) NOT NULL
    CHECK (RentalStatus IN ('CONFIRMED','ACTIVE','COMPLETED','CANCELLED')),
  CHECK (RentalEnd > RentalStart)
);

CREATE TABLE MaintenanceRecord (
  MaintenanceID INTEGER PRIMARY KEY,
  VehicleID INTEGER NOT NULL REFERENCES Vehicle(VehicleID)
    ON DELETE RESTRICT,
  ServiceStart DATETIME NOT NULL,
  ServiceEnd DATETIME,
  ServiceDescription TEXT NOT NULL,
  ServiceCost DECIMAL(10,2) NOT NULL CHECK (ServiceCost >= 0),
  MeterAtService DECIMAL(12,2) NOT NULL CHECK (MeterAtService >= 0),
  CHECK (ServiceEnd IS NULL OR ServiceEnd >= ServiceStart)
);

CREATE TABLE LicenseQualification (
  LicenseID INTEGER NOT NULL REFERENCES CustomerLicense(LicenseID)
    ON DELETE RESTRICT,
  RatingID INTEGER NOT NULL REFERENCES LicenseRating(RatingID)
    ON DELETE RESTRICT,
  QualificationIssueDate DATE NOT NULL,
  QualificationExpireDate DATE NOT NULL,
  PRIMARY KEY (LicenseID, RatingID),
  CHECK (QualificationExpireDate >= QualificationIssueDate)
);

CREATE TABLE VehicleRequiredRating (
  VehicleID INTEGER NOT NULL REFERENCES Vehicle(VehicleID)
    ON DELETE RESTRICT,
  RatingID INTEGER NOT NULL REFERENCES LicenseRating(RatingID)
    ON DELETE RESTRICT,
  PRIMARY KEY (VehicleID, RatingID)
);

CREATE TABLE RentalVehicle (
  RentalID INTEGER NOT NULL REFERENCES Rental(RentalID)
    ON DELETE RESTRICT,
  VehicleID INTEGER NOT NULL REFERENCES Vehicle(VehicleID)
    ON DELETE RESTRICT,
  QuotedDailyRate DECIMAL(10,2) NOT NULL CHECK (QuotedDailyRate >= 0),
  QuotedDays INTEGER NOT NULL CHECK (QuotedDays > 0),
  MeterOut DECIMAL(12,2) CHECK (MeterOut >= 0),
  MeterIn DECIMAL(12,2),
  RentalAfterCheck VARCHAR(10)
    CHECK (RentalAfterCheck IN ('PASS','FAIL')),
  RentalAfterComments TEXT,
  RentalAfterFlags TEXT,
  PRIMARY KEY (RentalID, VehicleID),
  CHECK (MeterIn IS NULL OR
    (MeterOut IS NOT NULL AND MeterIn >= MeterOut))
);
