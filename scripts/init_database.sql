/* ---------------------------------------------------------------------------------------------------------------
Purpose of the script:
This script creates a simple data warehouse setup in MySQL.
- Drops and recreates the 'DataWarehouse' database
- Creates three layers (as databases): bronze, silver, gold
		* bronze = raw data
		* silver = cleaned/transformed data
		* gold   = final curated data for reporting
        
Note : In MySQL, SCHEMA and DATABASE mean the same thing. So each layer(bronze, silve, gold) is also a Database.
------------------------------------------------------------------------------------------------------------------*/

-- Drop and recreate the DataWarehouse database
DROP DATABASE IF EXISTS DataWarehouse;
CREATE DATABASE DataWarehouse;

-- List databases to confirm
SHOW DATABASES;

-- Switch to DataWarehouse
USE DataWarehouse;

-- Create Bronze, Silver, and Gold schemas (as databases)
CREATE DATABASE IF NOT EXISTS bronze;
CREATE DATABASE IF NOT EXISTS silver;
CREATE DATABASE IF NOT EXISTS gold;

-- List databases to verify creation
SHOW DATABASES;
