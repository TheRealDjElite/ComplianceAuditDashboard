USE ComplianceAuditDB;

-- 1. Cases flagged for audit
SELECT * FROM cases
WHERE Audit_Flag = TRUE;

-- 2. Missing required fields (client name, program, or status)
SELECT Case_ID, Client_Name, Program, Status
FROM cases
WHERE Client_Name IS NULL
   OR TRIM(Client_Name) = ''
   OR Program IS NULL
   OR Status IS NULL;

-- 3. Invalid status values (anything other than Approved, Pending, or Denied)
SELECT Case_ID, Status
FROM cases
WHERE Status NOT IN ('Approved', 'Pending', 'Denied');

-- 4. Invalid program values (anything other than SNAP, TANF, or Medicaid)
SELECT Case_ID, Program
FROM cases
WHERE Program NOT IN ('SNAP', 'TANF', 'Medicaid');

-- 5. Approved cases with no review date
SELECT Case_ID, Client_Name, Status, Review_Date
FROM cases
WHERE Status = 'Approved'
  AND Review_Date IS NULL;

-- 6. Review dates in the future
SELECT Case_ID, Client_Name, Review_Date
FROM cases
WHERE Review_Date > CURDATE();

-- 7. Case count by program and status
SELECT Program, Status, COUNT(*) AS Case_Count
FROM cases
GROUP BY Program, Status
ORDER BY Program, Status;

-- 8. Count of approved cases
SELECT COUNT(*) AS Approved_Cases
FROM cases
WHERE Status = 'Approved';
