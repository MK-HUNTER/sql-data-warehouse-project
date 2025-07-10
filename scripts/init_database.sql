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

-- Drop the database if it exists (disconnect users first)
DO
$$
BEGIN
   IF EXISTS (SELECT FROM pg_database WHERE datname = 'datawarehouse') THEN
      -- Terminate all connections to the database
      PERFORM pg_terminate_backend(pid)
      FROM pg_stat_activity
      WHERE datname = 'datawarehouse'
        AND pid <> pg_backend_pid();
      -- Drop the database
      EXECUTE 'DROP DATABASE datawarehouse';
   END IF;
END
$$;

-- Create the DataWarehouse database
CREATE DATABASE DataWarehouse;

-- Note: Connect to the DataWarehouse database before running the schema commands below

-- Create schemas for data lakehouse layers
CREATE SCHEMA bronze;  -- Raw data
CREATE SCHEMA silver;  -- Cleaned data  
CREATE SCHEMA gold;    -- Business data

# Test push
