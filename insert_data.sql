-- Insert sample data
INSERT INTO cases (Case_ID, Client_Name, Program, Status, Review_Date, Audit_Flag)
VALUES
    (1001, 'Alice Johnson', 'SNAP', 'Approved', '2025-04-10', FALSE),
    (1002, 'Bob Smith', 'TANF', 'Pending', '2025-04-12', FALSE),
    (1003, 'Charlie Brown', 'SNAP', 'Denied', '2025-04-13', TRUE),
    (1004, 'Dana Lee', 'Medicaid', 'Approved', '2025-04-15', TRUE);