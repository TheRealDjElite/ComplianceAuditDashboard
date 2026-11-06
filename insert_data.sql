USE ComplianceAuditDB;

-- Insert sample data
-- Includes clean records and records with intentional errors for the audit queries to catch
INSERT INTO cases (Case_ID, Client_Name, Program, Status, Review_Date, Audit_Flag)
VALUES
    -- Clean records
    (1001, 'Alice Johnson', 'SNAP', 'Approved', '2025-04-10', FALSE),
    (1002, 'Bob Smith', 'TANF', 'Pending', '2025-04-12', FALSE),
    (1003, 'Charlie Brown', 'SNAP', 'Denied', '2025-04-13', TRUE),
    (1004, 'Dana Lee', 'Medicaid', 'Approved', '2025-04-15', TRUE),
    (1005, 'Iris Lum', 'TANF', 'Pending', NULL, FALSE),          -- Pending with no review yet (allowed)

    -- Records with intentional errors
    (1006, NULL, 'SNAP', 'Pending', '2025-04-16', FALSE),         -- Missing client name
    (1007, '', 'Medicaid', 'Denied', '2025-04-17', FALSE),        -- Blank client name
    (1008, 'Evan Ito', NULL, 'Pending', '2025-04-18', FALSE),     -- Missing program
    (1009, 'Faith Kim', 'Medicaid', 'Aproved', '2025-04-19', FALSE), -- Misspelled status
    (1010, 'Gina Park', 'SNAPP', 'Denied', '2025-04-20', FALSE),  -- Invalid program
    (1011, 'Henry Cho', 'TANF', 'Approved', NULL, FALSE),         -- Approved with no review date
    (1012, 'Jon Akana', 'SNAP', 'Pending', '2030-06-01', FALSE);  -- Review date in the future
