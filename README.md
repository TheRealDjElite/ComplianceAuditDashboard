# Compliance Audit Dashboard

⚠️ Applied learning prototype. Built with SQL and Excel as a learning project. Not for production use.

A SQL-based tool that demonstrates how to audit case data for compliance. Reads CSV/Excel inputs into a database, applies SQL queries to check data quality, and generates simple audit results.

## 🔍 What It Does
- Store and organize case data using a SQL schema
- Run audit queries to flag missing or invalid records
- Support MySQL or PostgreSQL for flexibility
- Provide simple reports that can help QA teams review compliance

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
Designed as a demo for auditing structured case data. Shows how SQL can be applied for quality checks and compliance reviews in a portable, audit-ready format.

---

Made with 💡 by **Joseph Netherland (TheRealDjElite)**  
[LinkedIn →](https://linkedin.com/in/JoeNetherland)

<details>
<summary>📘 Instructions for Non-Technical Users (Click to Expand)</summary>

### 💡 How to Use This Tool (No Tech Skills Needed)

This tool helps you audit eligibility case data for SNAP, TANF, or Medicaid by running pre-made SQL queries. You don't need to be technical to use it.

---

### ✅ What You’ll Need:
1. A MySQL or PostgreSQL database installed on your computer (download at: https://www.mysql.com/downloads/ or https://www.postgresql.org/download/)
2. SQL software or client (e.g., MySQL Workbench or pgAdmin) to run the SQL queries
3. Your case data ready to be imported into the database

---

### 🧭 Step-by-Step Instructions

#### 1. Download the Tool
- Go to:  
  [https://github.com/TheRealDjElite/ComplianceAuditDashboard](https://github.com/TheRealDjElite/ComplianceAuditDashboard)
- Click the green **Code** button → **Download ZIP**
- Unzip the folder

#### 2. Set Up Your Database
- Open your SQL client (e.g., MySQL Workbench or pgAdmin)  
- Create a new database (e.g., `compliance_audit`)

#### 3. Import the Database Schema
- Run **`schema.sql`** to set up the tables needed for storing case data.
  - In your SQL client, open **`schema.sql`** and run it.

#### 4. Add Sample Data
- Run **`insert_data.sql`** to insert sample case data into the database.
  - In your SQL client, open **`insert_data.sql`** and run it.

#### 5. Run Queries for Auditing
- Use **`queries.sql`** to run audit queries.
  - Open **`queries.sql`** in your SQL client and run the queries to audit the case data.
  - Review the results to see flagged non-compliant cases.

---

### 👩‍💼 Example Use
You’re reviewing Medicaid cases for compliance. After setting up the database and importing your data, you run the audit queries to flag any cases with missing or invalid



