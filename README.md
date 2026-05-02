# 📊 Compliance Audit Dashboard

SQL-based data validation and audit framework for structured records, designed to support QA and compliance-style review across relational datasets.

Implements a schema-driven structure for loading records, running validation queries, and producing audit outputs focused on data quality and consistency checks.

## 🔍 What It Does

- Stores and organizes structured records using a relational SQL schema  
- Runs audit queries to identify missing, invalid, or inconsistent data  
- Supports MySQL and PostgreSQL environments  
- Produces query-based outputs for data quality and review workflows  

## 🧰 Tools Used

- SQL (MySQL / PostgreSQL)  
- Database schema design  
- Query-based validation and reporting logic  

## 📁 File Overview

- `schema.sql` - Defines relational structure for case records  
- `insert_data.sql` - Loads sample dataset into tables  
- `queries.sql` - Audit and validation queries for review outputs  

## ▶ How to Use It

1. Create a MySQL or PostgreSQL database  
2. Run `schema.sql` to create tables  
3. Run `insert_data.sql` to load sample data  
4. Execute `queries.sql` to generate audit results  

## 📌 Purpose

Built for structured environments requiring SQL-based validation and audit-style reporting. Focuses on identifying data integrity issues early and supporting consistent review of high-volume transactional records.