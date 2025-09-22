# Data Warehouse with ETL Pipelines (Bronze → Silver → Gold)

## Project Overview  
This project focuses on **designing and implementing a layered data warehouse** in SQL Server using the **Bronze–Silver–Gold architecture**.  
The goal was to build an **ETL pipeline** that can take raw ERP/CRM data, clean and transform it, and make it business-ready for reporting and analytics.  

---

## Architecture  
- **Bronze Layer** → Stores raw ingested data (CSV imports).  
- **Silver Layer** → Cleans, transforms, deduplicates, and applies business rules.  
- **Gold Layer** → Curated fact & dimension tables structured in a **star schema** for analytics.  

---

## Features  
- **Automated ETL Pipelines** → Stored procedures to load, clean, and transform **50K+ records**.  
- **Data Quality Handling** → Managed nulls, standardized data types, removed duplicates.  
- **Business Rules Applied** → Mapped codes to descriptive labels for readability.  
- **Star Schema Design** → Sales Fact + Product & Customer Dimensions, giving **30% faster queries**.  
- **End-to-End Testing** → Verified transformations with reporting queries.  

---

## Tech Stack  
- **SQL Server**  
- **ETL (Extract, Transform, Load) using Stored Procedures**  
- **Star Schema Modeling**  

---

## File Structure  
- `init_database.sql` → Creates the database and initial setup.  
- `ddl_bronze.sql` → DDL for raw (Bronze) tables.  
- `ddl_silver.sql` → DDL for cleaned/transformed (Silver) tables.  
- `ddl_gold.sql` → DDL for curated fact/dimension (Gold) tables.  
- `prod_load_bronze.sql` → ETL procedure to load raw data into Bronze.  
- `prod_load_silver.sql` → ETL procedure to transform Bronze → Silver.  
- `run_script.sql` → Master script to execute the full ETL pipeline.  

---

## Results  
- Processed **50K+ sales, customer, and product records** end-to-end.  
- Achieved **~30% faster query performance** using star schema design.  
- Delivered a reliable data pipeline from raw ingestion to business-ready insights.  

---

## How to Run  
1. Clone the repository.  
2. Open SQL Server Management Studio (SSMS).  
3. Run `init_database.sql` to set up the database.  
4. Execute `ddl_bronze.sql`, `ddl_silver.sql`, and `ddl_gold.sql` to create schema layers.  
5. Load data by running `prod_load_bronze.sql` and then `prod_load_silver.sql`.  
6. Run `run_script.sql` to execute the entire ETL pipeline.  
7. Validate outputs by querying the **Gold layer** (fact & dimension tables).  

---

**Author**: Jayvardhan Sakwar  
M.Tech – Data Science, IIT Guwahati  

