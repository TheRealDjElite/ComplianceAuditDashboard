# Compliance Audit Dashboard

A SQL-based tool to help audit eligibility cases for SNAP, TANF, and Medicaid programs, ensuring data accuracy and compliance.

## 🔍 What It Does
- Tracks eligibility case data across public programs
- Flags non-compliant cases for review using SQL queries
- Supports both MySQL and PostgreSQL databases
- Helps remote teams stay organized and audit-ready

## 🧰 Tools Used
- SQL (MySQL or PostgreSQL)
- Database Schema
- SQL Queries for Auditing and Reporting

## 📁 File Overview
- `schema.sql` — Defines the database and table structure for storing eligibility case data
- `insert_data.sql` — Inserts sample data into the `cases` table for testing and querying
- `queries.sql` — SQL queries to perform audits and generate reports (e.g., count approved cases, flag non-compliant cases)

## 🧪 How to Use It
1. Create a MySQL or PostgreSQL database.
2. Run **`schema.sql`** to create the `cases` table.
3. Run **`insert_data.sql`** to add sample data to the table.
4. Use **`queries.sql`** to query and audit case data for compliance.

## ✅ Use Case
Built for remote Medicaid/SNAP/TANF teams that need an accurate and auditable way to review eligibility cases and ensure compliance with program guidelines.

---

Made with 💡 by #EliteTheOctoDog 🐙🐶  
[LinkedIn →](https://linkedin.com/in/JoeNetherland)
