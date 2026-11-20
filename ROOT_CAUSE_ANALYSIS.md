# 🧩 Root Cause Analysis

Why each type of error in the sample data reached the `cases` table, and what stops each one at entry. The audit queries in `queries.sql` catch errors after the data is saved. This analysis traces each error back to the gap letting the record in, then tests a prevention control for each gap in [`prevention_controls.sql`](prevention_controls.sql).

The errors in `insert_data.sql` are planted test records. The root causes below describe gaps in the table design and entry process, the conditions under which the same errors would reach a live table.

## 🔍 Findings

| Case | Defect | Caught By | Root Cause | Prevention Control | Test Result |
|---|---|---|---|---|---|
| 1006 | Missing client name | Query 2 (US-02) | RC-01 | `NOT NULL` on Client_Name | Rejected: Client_Name cannot be null |
| 1007 | Blank client name | Query 2 (US-02) | RC-02 | `chk_name_not_blank` | Rejected |
| 1008 | Missing program | Query 2 (US-02) | RC-01 | `NOT NULL` on Program | Rejected: Program cannot be null |
| 1009 | Misspelled status "Aproved" | Query 3 (US-03) | RC-03 | `chk_status` | Rejected |
| 1010 | Invalid program "SNAPP" | Query 4 (US-04) | RC-03 | `chk_program` | Rejected |
| 1011 | Approved with no review date | Query 5 (US-05) | RC-04 | `chk_approved_review` | Rejected |
| 1012 | Review date in 2030 | Query 6 (US-06) | RC-05 | Insert and update triggers | Rejected: Review_Date cannot be in the future |

Clean records 1001 through 1005 pass every control, including case 1005 (Pending with no review date).

## 🧬 Root Causes

| ID | Root Cause | Cases | Share of Defects |
|---|---|---|---|
| RC-01 | Required fields accept NULL at entry | 1006, 1008 | 2 of 7 |
| RC-02 | Text fields accept blank or spaces-only values | 1007 | 1 of 7 |
| RC-03 | Program and status are free text with no allowed-value list at entry | 1009, 1010 | 2 of 7 |
| RC-04 | No rule ties status to review date at entry | 1011 | 1 of 7 |
| RC-05 | No date range check at entry | 1012 | 1 of 7 |

All five share one underlying cause: **the business rules live only in the audit queries, so they run after a record is saved instead of when the record is entered.** Every defect gets caught, but only at audit time, after the record has already moved forward.

## ❓ 5 Whys: Case 1011

| Why | Answer |
|---|---|
| Why did case 1011 get flagged? | The case is Approved with no review date. |
| Why was the record saved without a review date? | The table accepted an Approved status with a NULL review date. |
| Why did the table accept the record? | No rule connects the Status field to the Review_Date field at entry. |
| Why is there no rule at entry? | The rule exists only as audit query 5, which runs after the data is loaded. |
| Why does running the rule after entry cause a problem? | The error surfaces at audit, so the case needs rework after a decision was already recorded. |

**Root cause:** validation runs after entry instead of at entry.

## 🛡️ Prevention Controls

`prevention_controls.sql` creates `cases_controlled`, a copy of the `cases` table with entry rules added. The original `cases` table stays as is, so the audit queries keep working on the sample errors.

| Control | Type | Prevents |
|---|---|---|
| `NOT NULL` on Client_Name, Program, Status | Column rule | RC-01 |
| `chk_name_not_blank` | CHECK constraint | RC-02 |
| `chk_program`, `chk_status` | CHECK constraint, exact capitalization | RC-03 |
| `chk_approved_review` | CHECK constraint | RC-04 |
| `trg_no_future_review_insert`, `trg_no_future_review_update` | Triggers | RC-05 |

CHECK constraints do not allow `CURDATE()`, so the future date rule runs as triggers on insert and update.

### Test Results

Tested on MariaDB 10.11 by copying each sample record from `cases` into `cases_controlled` one at a time.

| Test | Result |
|---|---|
| Clean records 1001 to 1005 | 5 of 5 accepted |
| Error records 1006 to 1012 | 7 of 7 rejected, each by the control listed above |
| Update an accepted record to a 2030 review date | Rejected by the update trigger |
| Insert status "approved" (lowercase) | Rejected by `chk_status` |

The lowercase test closes a gap listed in [`REQUIREMENTS.md`](REQUIREMENTS.md): the audit queries treat "approved" and "Approved" as the same value under MySQL's default collation, so lowercase entries pass the audit. The `CAST(... AS BINARY)` check in `chk_status` and `chk_program` blocks them at entry.

## 📏 Detection and Prevention

| Layer | Tool | Runs | Role |
|---|---|---|---|
| Prevention | `prevention_controls.sql` | At entry | Stops new bad records |
| Detection | `queries.sql` | Before review or audit | Catches records loaded before the controls existed, or through a path the controls don't cover |

Both layers stay in place. Controls stop new errors. Audit queries catch older data and anything loaded another way.

## 🗂️ Limits

- **Denied cases with no review date are still not covered.** The business rule needs confirmation, same as the backlog item in `REQUIREMENTS.md`.
- **Audit_Flag is out of scope.** No rule decides which cases get flagged for audit.
- **Tested on MariaDB 10.11.** MySQL enforces CHECK constraints in version 8.0.16 and later. Earlier versions accept the syntax but skip the check.
