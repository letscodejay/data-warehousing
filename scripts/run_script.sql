USE DataWarehouse;
EXEC bronze.load_bronze;
EXEC silver.load_silver;
SELECT * FROM gold.dim_customers;
SELECT * FROM gold.dim_products;
SELECT * FROM gold.fact_sales;

