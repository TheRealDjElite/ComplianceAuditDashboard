# 📊 Compliance Audit Dashboard

SQL-based audit tracking for structured case records, designed to support QA and compliance-style review.

Uses a relational schema to store case records with an audit flag, then runs queries to surface flagged cases and summarize case status.

## 🔍 What It Does

- Stores case records (ID, client, program, status, review date, audit flag) in a relational SQL schema
- Lists all cases flagged for audit
- Counts approved cases for status reporting
- Provides a base structure that can be extended with additional audit queries

## 🧰 Tools Used

- SQL (MySQL, AI-assisted development)
- Database schema design
- Query-based audit reporting

## 📁 File Overview

- `schema.sql` - Creates the database and the case records table
- `insert_data.sql` - Loads a sample dataset into the table
- `queries.sql` - Audit and reporting queries

## ▶ How to Use It

1. Run `schema.sql` in MySQL to create the database and table
2. Run `insert_data.sql` to load sample data
3. Run `queries.sql` to generate audit results

## 📌 Purpose

Built for structured environments that need SQL-based audit tracking and reporting. Focuses on making flagged records easy to find and supporting consistent review of case data.
