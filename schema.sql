-- Create the database
CREATE DATABASE ComplianceAuditDB;

-- Use the database
USE ComplianceAuditDB;

-- Create the table for storing eligibility case data
CREATE TABLE cases (
    Case_ID INT PRIMARY KEY,
    Client_Name VARCHAR(100),
    Program VARCHAR(50),
    Status VARCHAR(20),
    Review_Date DATE,
    Audit_Flag BOOLEAN
);