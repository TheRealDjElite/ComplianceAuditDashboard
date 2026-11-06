-- Create the database
CREATE DATABASE IF NOT EXISTS ComplianceAuditDB;

-- Use the database
USE ComplianceAuditDB;

-- Start fresh so the script can be re-run
DROP TABLE IF EXISTS cases;

-- Create the table for storing eligibility case data
-- Fields are left nullable on purpose so the audit queries can catch missing data
CREATE TABLE cases (
    Case_ID INT PRIMARY KEY,
    Client_Name VARCHAR(100),
    Program VARCHAR(50),
    Status VARCHAR(20),
    Review_Date DATE,
    Audit_Flag BOOLEAN
);
