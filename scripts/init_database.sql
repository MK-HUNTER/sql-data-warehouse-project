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
CREATE SCHEMA IF NOT EXISTS bronze;  -- Raw data
CREATE SCHEMA IF NOT EXISTS silver;  -- Cleaned data  
CREATE SCHEMA IF NOT EXISTS gold;    -- Business data

-- =============================================================================
-- CRM SYSTEM TABLES
-- =============================================================================

-- Drop the table if it exists
DROP TABLE IF EXISTS bronze.crm_sales_details;
DROP TABLE IF EXISTS bronze.crm_prd_info;
DROP TABLE IF EXISTS bronze.crm_cust_info;

-- Customer information table
-- Contains master customer data from CRM system
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
-- Contains master product data from CRM system
CREATE TABLE bronze.crm_prd_info(
    prd_id INTEGER,
    prd_key VARCHAR(50) PRIMARY KEY,
    prd_nm VARCHAR(50),
    prd_cost INTEGER,
    prd_line VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);

-- Sales details table with foreign key relationships
-- Contains transactional sales data from CRM system
CREATE TABLE bronze.crm_sales_details(
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),  -- References crm_prd_info.prd_key
    sls_cust_id INTEGER,      -- References crm_cust_info.cst_id
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INTEGER,
    sls_quantity INTEGER,
    sls_price INTEGER,
    -- Foreign key constraints
    FOREIGN KEY(sls_cust_id) REFERENCES bronze.crm_cust_info(cst_id),
    FOREIGN KEY(sls_prd_key) REFERENCES bronze.crm_prd_info(prd_key)
);

-- =============================================================================
-- ERP SYSTEM TABLES
-- =============================================================================

-- Drop the table if it exists
DROP TABLE IF EXISTS bronze.erp_cust_az12;

-- ERP Customer table for AZ12 region
-- Contains customer demographic data from ERP system
CREATE TABLE bronze.erp_cust_az12(
    c_id VARCHAR(50),
    b_date DATE,
    gender VARCHAR(50)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS bronze.erp_loc_a101;

-- ERP Location table for A101 region
-- Contains customer location data from ERP system
CREATE TABLE bronze.erp_loc_a101(
    c_id VARCHAR(50),
    country VARCHAR(50)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;

-- ERP Product Category table (G1V2 version)
-- Contains product categorization data from ERP system
CREATE TABLE bronze.erp_px_cat_g1v2(
    id VARCHAR(50),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50)
);

