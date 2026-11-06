# 📊 Compliance Audit Dashboard

SQL-based audit tracking and data integrity checks for structured case records, designed to support QA and compliance-style review.

Uses a relational schema to store case records, then runs audit queries to surface flagged cases, catch missing or invalid data, and summarize case counts by program and status.

## 🔍 What It Does

- Stores case records (ID, client, program, status, review date, audit flag) in a relational SQL schema
- Lists all cases flagged for audit
- Flags records missing a client name, program, or status
- Flags invalid status values (anything other than Approved, Pending, or Denied)
- Flags invalid program values (anything other than SNAP, TANF, or Medicaid)
- Flags approved cases with no review date
- Flags review dates set in the future
- Summarizes case counts by program and status, plus a total count of approved cases

## 🧪 Sample Data

`insert_data.sql` loads 12 records: 5 clean records and 7 with intentional errors (missing or blank names, missing program, misspelled status, invalid program, approved with no review date, and a future review date). Each error is caught by one of the audit queries. A pending case with no review date is included as a valid record and is not flagged.

## 🧰 Tools Used

- SQL (MySQL, AI-assisted development)
- Database schema design
- Query-based audit and data integrity checks

## 📁 File Overview

- `schema.sql` - Creates the database and the case records table (safe to re-run)
- `insert_data.sql` - Loads a sample dataset with intentional errors
- `queries.sql` - Audit, data integrity, and reporting queries

## ▶ How to Use It

1. Run `schema.sql` in MySQL to create the database and table
2. Run `insert_data.sql` to load sample data
3. Run `queries.sql` to generate audit results

## 📌 Purpose

Built for structured environments that need SQL-based audit tracking and data integrity checks. Focuses on catching missing or invalid case data early, making flagged records easy to find, and supporting consistent review of case data.
