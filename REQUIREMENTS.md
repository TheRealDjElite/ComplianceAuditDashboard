# 📋 Requirements and User Stories

Business requirements for the Compliance Audit Dashboard, written as user stories with acceptance criteria. Each story maps to a query in `queries.sql` and to test records in `insert_data.sql`, so every requirement has a case proving the rule works.

These stories were written after the first build to document the business rule behind each audit query.

## 🎯 Business Problem

Case records with missing or invalid data slip into reviews and audits. Errors found late lead to rework, delayed decisions, and audit findings. Reviewers need a repeatable check to catch bad records before a case moves forward.

## 👥 Users

- **QA Reviewer:** checks case records for accuracy before audit
- **Compliance Auditor:** confirms records meet program rules and are review-ready
- **Program Supervisor:** tracks case volume and outcomes by program

## 📏 Data Rules

| Field | Rule |
|---|---|
| Case_ID | Required and unique |
| Client_Name | Required. Blank or spaces-only values fail |
| Program | Required. Valid values: SNAP, TANF, Medicaid |
| Status | Required. Valid values: Approved, Pending, Denied |
| Review_Date | Required for Approved cases. Optional for Pending cases. Never a future date |
| Audit_Flag | TRUE marks a case for audit review |

## 📝 User Stories

### US-01: Cases flagged for audit
**As a** compliance auditor, **I want** a list of every case flagged for audit **so** I review the right records first.

Acceptance criteria:
- Returns every case where Audit_Flag is TRUE
- Returns no unflagged cases
- Test: returns cases 1003 and 1004

### US-02: Missing required fields
**As a** QA reviewer, **I want** records missing a client name, program, or status flagged **so** incomplete cases get corrected before review.

Acceptance criteria:
- Flags a NULL client name
- Flags a blank or spaces-only client name
- Flags a NULL program or a NULL status
- Test: flags cases 1006, 1007, and 1008

### US-03: Invalid status values
**As a** QA reviewer, **I want** status values outside the approved list flagged **so** typos don't distort counts or reports.

Acceptance criteria:
- Flags any status other than Approved, Pending, or Denied
- NULL status is covered by US-02
- Test: flags case 1009 ("Aproved")

### US-04: Invalid program values
**As a** QA reviewer, **I want** program values outside the approved list flagged **so** every case is counted under the correct program.

Acceptance criteria:
- Flags any program other than SNAP, TANF, or Medicaid
- NULL program is covered by US-02
- Test: flags case 1010 ("SNAPP")

### US-05: Approved cases with no review date
**As a** compliance auditor, **I want** approved cases with no review date flagged **so** no approval goes through without a documented review.

Acceptance criteria:
- Flags cases where Status is Approved and Review_Date is NULL
- Does not flag Pending cases with no review date
- Test: flags case 1011 and leaves case 1005 unflagged

### US-06: Future review dates
**As a** QA reviewer, **I want** review dates set in the future flagged **so** date entry errors get caught early.

Acceptance criteria:
- Flags any Review_Date later than the current date
- Test: flags case 1012 (2030-06-01)

### US-07: Case counts by program and status
**As a** program supervisor, **I want** case counts by program and status plus a total of approved cases **so** I track workload and outcomes.

Acceptance criteria:
- Groups case counts by Program and Status, sorted by both
- Returns the total number of Approved cases
- Records with an invalid status are excluded from the Approved total
- Test: Approved total is 3 (cases 1001, 1004, 1011). Case 1009 ("Aproved") is not counted

## 🔗 Traceability Matrix

| Story | Query in `queries.sql` | Test Cases | Expected Result |
|---|---|---|---|
| US-01 | 1. Cases flagged for audit | 1003, 1004 | 2 rows |
| US-02 | 2. Missing required fields | 1006, 1007, 1008 | 3 rows |
| US-03 | 3. Invalid status values | 1009 | 1 row |
| US-04 | 4. Invalid program values | 1010 | 1 row |
| US-05 | 5. Approved cases with no review date | 1011 (1005 not flagged) | 1 row |
| US-06 | 6. Review dates in the future | 1012 | 1 row |
| US-07 | 7. Case count by program and status, 8. Count of approved cases | All 12 records | Approved total of 3 |

## 🗂️ Known Limits and Backlog

- **Denied cases with no review date are not checked.** The business rule for Denied cases needs confirmation before a query is added.
- **Status and program checks are case-insensitive.** MySQL's default collation treats "approved" and "Approved" as the same value, so lowercase entries pass as valid.
- **Audit_Flag values come from the source data.** No rule in this project decides which cases get flagged for audit.
- **US-06 depends on the current date.** Test case 1012 stops failing after June 1, 2030, and needs a later date at that point.
- **No visual dashboard yet.** Results are query output. A Power BI view of audit flags and case counts by program is planned.