CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
          SET @batch_start_time = GETDATE();
          PRINT 'Loading Bronze Layer.....'
          PRINT '=========================='

          PRINT 'Loading CRM Tables........'
          PRINT '=========================='

          SET @start_time = GETDATE();
          PRINT 'Truncating crm_cust_info Table....'
          TRUNCATE TABLE bronze.crm_cust_info;
          PRINT 'Inserting Data Into crm_cust_info Table....'
          BULK INSERT bronze.crm_cust_info
          FROM '/var/opt/mssql/data/cust_info.csv'
          WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
          );
          PRINT 'Inserted Data Into crm_cust_info Table....'
          SET @end_time = GETDATE();
          PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
          PRINT '------------------------------------------'


          SET @start_time = GETDATE();
          PRINT 'Truncating crm_prd_info Table....'
          TRUNCATE TABLE bronze.crm_prd_info;
          PRINT 'Inserting Data Into crm_prd_info Table....'
          BULK INSERT bronze.crm_prd_info
          FROM '/var/opt/mssql/data/prd_info.csv'
          WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
          );
          PRINT 'Inserted Data Into crm_prd_info Table....'
          SET @end_time = GETDATE();
          PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
          PRINT '------------------------------------------'

          SET @start_time = GETDATE();
          PRINT 'Truncating crm_sales_details Table....'
          TRUNCATE TABLE bronze.crm_sales_details;
          PRINT 'Inserting Data Into crm_sales_details Table....'
          BULK INSERT bronze.crm_sales_details
          FROM '/var/opt/mssql/data/sales_details.csv'
          WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
          );
          PRINT 'Inserted Data Into crm_sales_details Table....'
          SET @end_time = GETDATE();
          PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
          PRINT '------------------------------------------'

          PRINT 'Loading ERP Tables........'
          PRINT '=========================='

          SET @start_time = GETDATE();
          PRINT 'Truncating erp_cust_az12 Table....'
          TRUNCATE TABLE bronze.erp_cust_az12;
          PRINT 'Inserting Data Into erp_cust_az12 Table....'
          BULK INSERT bronze.erp_cust_az12
          FROM '/var/opt/mssql/data/CUST_AZ12.csv'
          WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
          );
          PRINT 'Inserted Data Into erp_cust_az12 Table....'
          PRINT 'Inserted Data Into crm_sales_details Table....'
          SET @end_time = GETDATE();
          PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
          PRINT '------------------------------------------'

          SET @start_time = GETDATE();
          PRINT 'Truncating erp_loc_a101 Table....'
          TRUNCATE TABLE bronze.erp_loc_a101;
          PRINT 'Inserting Data Into erp_loc_a101 Table....'
          BULK INSERT bronze.erp_loc_a101
          FROM '/var/opt/mssql/data/LOC_A101.csv'
          WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
          );
          PRINT 'Inserted Data Into erp_loc_a101 Table....'
          SET @end_time = GETDATE();
          PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
          PRINT '------------------------------------------'

          SET @start_time = GETDATE();
          PRINT 'Truncating erp_loc_a101 Table....'
          TRUNCATE TABLE bronze.erp_px_cat_g1v2;
          PRINT 'Inserting Data Into erp_px_cat_g1v2 Table....'
          BULK INSERT bronze.erp_px_cat_g1v2
          FROM '/var/opt/mssql/data/PX_CAT_G1V2.csv'
          WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
          );
          PRINT 'Inserted Data Into erp_px_cat_g1v2 Table....'
          SET @end_time = GETDATE();
          PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
          PRINT '------------------------------------------'
          SET @batch_end_time = GETDATE();
          PRINT 'BATCH LOAD DURATION: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
    END TRY
    BEGIN CATCH
          PRINT 'ERROR OCCURED IN LOADING BRONZE LAYER'
          PRINT 'Error Message' + ERROR_MESSAGE();
		      PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		      PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
    END CATCH
END;

-- Uncomment and select run below to execute the above procedure
-- EXEC bronze.load_bronze;
