-- Query to find all cases that are flagged for audit
SELECT * FROM cases
WHERE Audit_Flag = TRUE;

-- Query to count the number of approved cases
SELECT COUNT(*) AS Approved_Cases FROM cases
WHERE Status = 'Approved';