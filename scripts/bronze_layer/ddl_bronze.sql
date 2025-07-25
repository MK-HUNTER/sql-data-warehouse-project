/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/


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
    cst_id              INTEGER,
    cst_key             VARCHAR(50),
    cst_firstname       VARCHAR(50),
    cst_lastname        VARCHAR(50),
    cst_marital_status  VARCHAR(50),
    cst_gndr            VARCHAR(50),
    cst_create_date     DATE
);

-- Product information table
-- Contains master product data from CRM system
CREATE TABLE bronze.crm_prd_info(
    prd_id          INTEGER,
    prd_key         VARCHAR(50),
    prd_nm          VARCHAR(50),
    prd_cost        INTEGER,
    prd_line        VARCHAR(50),
    prd_start_dt    DATE,
    prd_end_dt      DATE
);

-- Sales details table with foreign key relationships
-- Contains transactional sales data from CRM system
CREATE TABLE bronze.crm_sales_details(
    sls_ord_num     VARCHAR(50),
    sls_prd_key     VARCHAR(50),  -- References crm_prd_info.prd_key
    sls_cust_id     INTEGER,      -- References crm_cust_info.cst_id
    sls_order_dt    INTEGER,
    sls_ship_dt     INTEGER,
    sls_due_dt      INTEGER,
    sls_sales       INTEGER,
    sls_quantity    INTEGER,
    sls_price       INTEGER
);

-- =============================================================================
-- ERP SYSTEM TABLES
-- =============================================================================

-- Drop the table if it exists
DROP TABLE IF EXISTS bronze.erp_cust_az12;

-- ERP Customer table for AZ12 region
-- Contains customer demographic data from ERP system
CREATE TABLE bronze.erp_cust_az12(
    c_id    VARCHAR(50),
    b_date  DATE,
    gender  VARCHAR(50)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS bronze.erp_loc_a101;

-- ERP Location table for A101 region
-- Contains customer location data from ERP system
CREATE TABLE bronze.erp_loc_a101(
    c_id    VARCHAR(50),
    country VARCHAR(50)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;

-- ERP Product Category table (G1V2 version)
-- Contains product categorization data from ERP system
CREATE TABLE bronze.erp_px_cat_g1v2(
    id          VARCHAR(50),
    cat         VARCHAR(50),
    subcat      VARCHAR(50),
    maintenance VARCHAR(50)
);

