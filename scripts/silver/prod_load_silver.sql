-- Cleaned silver.crm_cust_info table
INSERT INTO silver.crm_cust_info (
  cst_id,
  cst_key,
  cst_firstname,
  cst_lastname,
  cst_marital_status,
  cst_gndr,
  cst_create_date
)
SELECT 
  cst_id,
  cst_key,
  TRIM(cst_firstname) AS cst_firstname,     -- remove unwanted spaces
  TRIM(cst_lastname) AS cst_lastname,       -- remove unwanted spaces
  CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
      WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
      ELSE 'n/a'
  END cst_marital_status,     -- normalize marital status to readable format
  CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
      WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
      ELSE 'n/a'
  END cst_gndr,     -- normalize gender values to readable format
  cst_create_date
FROM (
  SELECT 
    *,
  ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
  FROM bronze.crm_cust_info
  WHERE cst_id IS NOT NULL
)t WHERE flag_last = 1      -- select the most recent record per customer (remove duplicates)

-- Cleaned silver.crm_prd_info table
INSERT INTO silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_')AS cat_id, -- extract category id (Derived Column)
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key, -- extract product key (Derived Column)
prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,  -- handling missing values
CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
      WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
      WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
      WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
      ELSE 'n/a'
END AS prd_line,  -- map product lines codes to descriotive values
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt -- calculate end date as one day before the next start date
FROM bronze.crm_prd_info

-- Cleaned silver.crm_sales_details table