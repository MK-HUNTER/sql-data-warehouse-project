-- ============================================================
-- Data Warehouse Setup Script
-- ============================================================
-- Creates a data warehouse database with bronze, silver, gold schemas
-- 
-- Schema Architecture:
--   - bronze: Raw data ingestion layer (landing zone)
--   - silver: Cleaned and validated data layer  
--   - gold: Business-ready aggregated data layer
-- ============================================================

-- Terminate any existing connections
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'datawarehouse' 
  AND pid <> pg_backend_pid();

-- Drop and recreate the database
DROP DATABASE IF EXISTS datawarehouse;
CREATE DATABASE datawarehouse;

-- Note: Connect to the DataWarehouse database before running the schema commands below

-- DROP SCHEMA bronze CASCADE; -- DEVELOPMENT

-- Create schemas for data lakehouse layers
CREATE SCHEMA bronze;  -- Raw data
CREATE SCHEMA silver;  -- Cleaned data  
CREATE SCHEMA gold;    -- Business data

----Bronze layer

---Source CRM Table Creation

-- Customer information table
CREATE TABLE bronze.crm_cust_info(
   cst_id INTEGER PRIMARY KEY,
   cst_key VARCHAR(50),
   cst_firstname VARCHAR(50),
   cst_lastname VARCHAR(50),
   cst_marital_status VARCHAR(50),
   cst_gndr VARCHAR(50),
   cst_create_date DATE
);

-- Product information table
CREATE TABLE bronze.crm_prd_info(
   prd_id INTEGER,
   prd_key VARCHAR(50) PRIMARY KEY,
   prd_nm VARCHAR(50),
   prd_cost INTEGER,
   prd_line VARCHAR(50),
   prd_start_dt DATE,
   prd_end_dt DATE
);

-- Sales details table with corrected foreign keys
CREATE TABLE bronze.crm_sales_details(
   sls_ord_num VARCHAR(50),
   sls_prd_key VARCHAR(50),  -- Changed from INTEGER to VARCHAR(50) to match prd_key
   sls_cust_id INTEGER,
   sls_order_dt DATE,
   sls_ship_dt DATE,
   sls_due_dt DATE,
   sls_sales INTEGER,
   sls_quantity INTEGER,
   sls_price INTEGER,
   -- Foreign key references with schema qualification
   FOREIGN KEY(sls_cust_id) REFERENCES bronze.crm_cust_info(cst_id),
   FOREIGN KEY(sls_prd_key) REFERENCES bronze.crm_prd_info(prd_key)
);

CREATE TABLE bronze.erp_cust(
   c_id VARCHAR(50),
   b_date DATE, 
   gender  VARCHAR(50)
);

CREATE TABLE bronze.erp_loc(
   c_id VARCHAR(50) ,
   country VARCHAR(50)
);

CREATE TABLE bronze.erp_prd_maintenance(
   id VARCHAR(50),
   cat VARCHAR(50),
   subcat VARCHAR(50),
   maintenance VARCHAR(50)
);