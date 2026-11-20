USE ComplianceAuditDB;

-- Prevention controls from ROOT_CAUSE_ANALYSIS.md
-- Creates cases_controlled, a copy of the cases table with entry rules added.
-- The original cases table stays nullable so the audit queries still have errors to catch.
-- CHECK constraints are enforced in MySQL 8.0.16 and later. Tested on MariaDB 10.11.

DROP TABLE IF EXISTS cases_controlled;

CREATE TABLE cases_controlled (
    Case_ID INT PRIMARY KEY,
    Client_Name VARCHAR(100) NOT NULL,                     -- RC-01: required at entry
    Program VARCHAR(50) NOT NULL,                          -- RC-01: required at entry
    Status VARCHAR(20) NOT NULL,                           -- RC-01: required at entry
    Review_Date DATE,
    Audit_Flag BOOLEAN NOT NULL DEFAULT FALSE,

    -- RC-02: blank or spaces-only names rejected
    CONSTRAINT chk_name_not_blank CHECK (TRIM(Client_Name) <> ''),

    -- RC-03: only allowed values, exact capitalization
    CONSTRAINT chk_program CHECK (CAST(Program AS BINARY) IN ('SNAP', 'TANF', 'Medicaid')),
    CONSTRAINT chk_status CHECK (CAST(Status AS BINARY) IN ('Approved', 'Pending', 'Denied')),

    -- RC-04: approved cases need a review date
    CONSTRAINT chk_approved_review CHECK (Status <> 'Approved' OR Review_Date IS NOT NULL)
);

-- RC-05: no future review dates. CHECK constraints do not allow CURDATE(), so triggers handle this rule.
DROP TRIGGER IF EXISTS trg_no_future_review_insert;
DROP TRIGGER IF EXISTS trg_no_future_review_update;

DELIMITER //

CREATE TRIGGER trg_no_future_review_insert
BEFORE INSERT ON cases_controlled
FOR EACH ROW
BEGIN
    IF NEW.Review_Date > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Review_Date cannot be in the future';
    END IF;
END//

CREATE TRIGGER trg_no_future_review_update
BEFORE UPDATE ON cases_controlled
FOR EACH ROW
BEGIN
    IF NEW.Review_Date > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Review_Date cannot be in the future';
    END IF;
END//

DELIMITER ;

-- Test: copy each sample record from cases one at a time.
-- Clean records 1001 to 1005 are accepted. Records 1006 to 1012 are rejected.
-- INSERT INTO cases_controlled SELECT * FROM cases WHERE Case_ID = 1006;
