USE proejct;
-- Drop existing tables if they exist to avoid conflicts
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Lease;
DROP TABLE IF EXISTS Tenant;
DROP TABLE IF EXISTS Inspection;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS Buyer;
DROP TABLE IF EXISTS Listing;
DROP TABLE IF EXISTS Agent;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Owner;
DROP TABLE IF EXISTS Customer;

-- Create new tables with correct schema

CREATE TABLE Owner (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(150),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Location (
    LocationID INT AUTO_INCREMENT PRIMARY KEY,
    Address VARCHAR(150) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL
);

CREATE TABLE Property (
    PropertyID INT AUTO_INCREMENT PRIMARY KEY,
    Address VARCHAR(150) NOT NULL,
    Price DECIMAL(15, 2) NOT NULL,
    LocationID INT,
    OwnerID INT,
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID) ON DELETE CASCADE,
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID) ON DELETE CASCADE
);

CREATE TABLE Agent (
    AgentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(150),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Listing (
    ListingID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT,
    AgentID INT,
    ListingDate DATE,
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID) ON DELETE CASCADE,
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID) ON DELETE CASCADE
);

CREATE TABLE Buyer (
    BuyerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(150),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Transaction (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT,
    BuyerID INT,
    TransactionDate DATE,
    Amount DECIMAL(15, 2),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID) ON DELETE CASCADE,
    FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID) ON DELETE CASCADE
);

CREATE TABLE Inspection (
    InspectionID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT,
    InspectionDate DATE,
    Report VARCHAR(250),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID) ON DELETE CASCADE
);

CREATE TABLE Tenant (
    TenantID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(150),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Lease (
    LeaseID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT,
    TenantID INT,
    LeaseStartDate DATE,
    LeaseEndDate DATE,
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID) ON DELETE CASCADE,
    FOREIGN KEY (TenantID) REFERENCES Tenant(TenantID) ON DELETE CASCADE
);

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    LeaseID INT,
    Amount DECIMAL(15, 2),
    PaymentDate DATE,
    FOREIGN KEY (LeaseID) REFERENCES Lease(LeaseID) ON DELETE CASCADE
);

CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(150),
    Email VARCHAR(100) UNIQUE
);

-- Inserting sample data into Owner table
INSERT INTO Owner (Name, ContactInfo, Email) VALUES
('John Doe', '123-456-7890', 'john.doe@example.com'),
('Jane Smith', '234-567-8901', 'jane.smith@example.com'),
('Michael Johnson', '345-678-9012', 'michael.johnson@example.com'),
('Patricia Brown', '456-789-0123', 'patricia.brown@example.com'),
('Robert Davis', '567-890-1234', 'robert.davis@example.com'),
('Linda Martinez', '678-901-2345', 'linda.martinez@example.com'),
('William Garcia', '789-012-3456', 'william.garcia@example.com'),
('Elizabeth Wilson', '890-123-4567', 'elizabeth.wilson@example.com'),
('Charles Anderson', '901-234-5678', 'charles.anderson@example.com'),
('Barbara Taylor', '012-345-6789', 'barbara.taylor@example.com');

-- Inserting sample data into Location table
INSERT INTO Location (Address, City, State, ZipCode) VALUES
('123 Elm St', 'Springfield', 'IL', '62701'),
('456 Oak St', 'Chicago', 'IL', '60601'),
('789 Pine St', 'Los Angeles', 'CA', '90001'),
('101 Maple St', 'New York', 'NY', '10001'),
('202 Birch St', 'Houston', 'TX', '77001'),
('303 Cedar St', 'Phoenix', 'AZ', '85001'),
('404 Walnut St', 'Philadelphia', 'PA', '19019'),
('505 Ash St', 'San Antonio', 'TX', '78201'),
('606 Willow St', 'San Diego', 'CA', '92101'),
('707 Hickory St', 'Dallas', 'TX', '75201');

-- Inserting sample data into Property table
INSERT INTO Property (Address, Price, OwnerID, LocationID) VALUES
('123 Elm St', 250000.00, 1, 1),
('456 Oak St', 300000.00, 2, 2),
('789 Pine St', 150000.00, 3, 3),
('101 Maple St', 350000.00, 4, 4),
('202 Birch St', 275000.00, 5, 5),
('303 Cedar St', 325000.00, 6, 6),
('404 Walnut St', 200000.00, 7, 7),
('505 Ash St', 225000.00, 8, 8),
('606 Willow St', 180000.00, 9, 9),
('707 Hickory St', 400000.00, 10, 10);

-- Inserting sample data into Agent table
INSERT INTO Agent (Name, ContactInfo, Email) VALUES
('Alice Thompson', '111-222-3333', 'alice.thompson@example.com'),
('George White', '222-333-4444', 'george.white@example.com'),
('Sophia Harris', '333-444-5555', 'sophia.harris@example.com'),
('Henry Clark', '444-555-6666', 'henry.clark@example.com'),
('Isabella Lewis', '555-666-7777', 'isabella.lewis@example.com'),
('Lucas Young', '666-777-8888', 'lucas.young@example.com'),
('Mia Allen', '777-888-9999', 'mia.allen@example.com'),
('James Scott', '888-999-0000', 'james.scott@example.com'),
('Olivia King', '999-000-1111', 'olivia.king@example.com'),
('Benjamin Wright', '000-111-2222', 'benjamin.wright@example.com');

-- Inserting sample data into Listing table
INSERT INTO Listing (PropertyID, AgentID, ListingDate) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-01-02'),
(3, 3, '2023-01-03'),
(4, 4, '2023-01-04'),
(5, 5, '2023-01-05'),
(6, 6, '2023-01-06'),
(7, 7, '2023-01-07'),
(8, 8, '2023-01-08'),
(9, 9, '2023-01-09'),
(10, 10, '2023-01-10');

-- Inserting sample data into Buyer table
INSERT INTO Buyer (Name, ContactInfo, Email) VALUES
('Andrew Walker', '123-123-1234', 'andrew.walker@example.com'),
('Emily Hall', '234-234-2345', 'emily.hall@example.com'),
('Daniel Young', '345-345-3456', 'daniel.young@example.com'),
('Samantha Green', '456-456-4567', 'samantha.green@example.com'),
('David Allen', '567-567-5678', 'david.allen@example.com'),
('Sarah King', '678-678-6789', 'sarah.king@example.com'),
('James Harris', '789-789-7890', 'james.harris@example.com'),
('Laura Martin', '890-890-8901', 'laura.martin@example.com'),
('Mark Thompson', '901-901-9012', 'mark.thompson@example.com'),
('Emma Wright', '012-012-0123', 'emma.wright@example.com');

-- Inserting sample data into Transaction table
INSERT INTO Transaction (PropertyID, BuyerID, TransactionDate, Amount) VALUES
(1, 1, '2023-02-01', 250000.00),
(2, 2, '2023-02-02', 300000.00),
(3, 3, '2023-02-03', 150000.00),
(4, 4, '2023-02-04', 350000.00),
(5, 5, '2023-02-05', 275000.00),
(6, 6, '2023-02-06', 325000.00),
(7, 7, '2023-02-07', 200000.00),
(8, 8, '2023-02-08', 225000.00),
(9, 9, '2023-02-09', 180000.00),
(10, 10, '2023-02-10', 400000.00);

-- Inserting sample data into Inspection table
INSERT INTO Inspection (PropertyID, InspectionDate, Report) VALUES
(1, '2023-03-01', 'Inspection report for property 1'),
(2, '2023-03-02', 'Inspection report for property 2'),
(3, '2023-03-03', 'Inspection report for property 3'),
(4, '2023-03-04', 'Inspection report for property 4'),
(5, '2023-03-05', 'Inspection report for property 5'),
(6, '2023-03-06', 'Inspection report for property 6'),
(7, '2023-03-07', 'Inspection report for property 7'),
(8, '2023-03-08', 'Inspection report for property 8'),
(9, '2023-03-09', 'Inspection report for property 9'),
(10, '2023-03-10', 'Inspection report for property 10');

-- Inserting sample data into Tenant table
INSERT INTO Tenant (Name, ContactInfo, Email) VALUES
('Olivia Johnson', '123-111-1111', 'olivia.johnson@example.com'),
('Lucas White', '234-222-2222', 'lucas.white@example.com'),
('Sophia Harris', '345-333-3333', 'sophia.harris@example.com'),
('Henry Clark', '456-444-4444', 'henry.clark@example.com'),
('Isabella Lewis', '567-555-5555', 'isabella.lewis@example.com'),
('James Scott', '678-666-6666', 'james.scott@example.com'),
('Mia Allen', '789-777-7777', 'mia.allen@example.com'),
('George White', '890-888-8888', 'george.white@example.com'),
('Alice Thompson', '901-999-9999', 'alice.thompson@example.com'),
('Benjamin Wright', '012-000-0000', 'benjamin.wright@example.com');

-- Inserting sample data into Lease table
INSERT INTO Lease (PropertyID, TenantID, LeaseStartDate, LeaseEndDate) VALUES
(1, 1, '2023-04-01', '2024-03-31'),
(2, 2, '2023-04-02', '2024-04-01'),
(3, 3, '2023-04-03', '2024-04-02'),
(4, 4, '2023-04-04', '2024-04-03'),
(5, 5, '2023-04-05', '2024-04-04'),
(6, 6, '2023-04-06', '2024-04-05'),
(7, 7, '2023-04-07', '2024-04-06'),
(8, 8, '2023-04-08', '2024-04-07'),
(9, 9, '2023-04-09', '2024-04-08'),
(10, 10, '2023-04-10', '2024-04-09');

-- Inserting sample data into Payment table
INSERT INTO Payment (LeaseID, Amount, PaymentDate) VALUES
(1, 1000.00, '2023-05-01'),
(2, 1500.00, '2023-05-02'),
(3, 2000.00, '2023-05-03'),
(4, 2500.00, '2023-05-04'),
(5, 3000.00, '2023-05-05'),
(6, 3500.00, '2023-05-06'),
(7, 4000.00, '2023-05-07'),
(8, 4500.00, '2023-05-08'),
(9, 5000.00, '2023-05-09'),
(10, 5500.00, '2023-05-10');

-- Inserting sample data into Customer table
INSERT INTO Customer (Name, ContactInfo, Email) VALUES
('Ethan Brown', '123-444-4444', 'ethan.brown@example.com'),
('Ava Johnson', '234-555-5555', 'ava.johnson@example.com'),
('Mason Williams', '345-666-6666', 'mason.williams@example.com'),
('Charlotte Jones', '456-777-7777', 'charlotte.jones@example.com'),
('Logan Garcia', '567-888-8888', 'logan.garcia@example.com'),
('Abigail Wilson', '678-999-9999', 'abigail.wilson@example.com'),
('Lucas Miller', '789-000-0000', 'lucas.miller@example.com'),
('Sophie Anderson', '890-111-1111', 'sophie.anderson@example.com'),
('Liam Taylor', '901-222-2222', 'liam.taylor@example.com'),
('Amelia Martin', '012-333-3333', 'amelia.martin@example.com');

ALTER TABLE Transaction
CHANGE COLUMN BuyerID CustomerID INT;
INSERT INTO Property (Address, Price, OwnerID, LocationID) VALUES
('123 Elm St', 250000.00, 1, 1);

