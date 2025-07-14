-- ============================================================
-- Data Warehouse Setup Script - PostgreSQL
-- ============================================================
-- Creates a data warehouse database with bronze, silver, gold schemas
-- 
-- Schema Architecture:
--   - bronze: Raw data ingestion layer (landing zone)
--   - silver: Cleaned and validated data layer  
--   - gold: Business-ready aggregated data layer
-- 
-- Author: Madhan Kumar
-- Created: 2025-07-11
-- Database: PostgreSQL
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

-- Create schemas for data lakehouse layers
CREATE SCHEMA IF NOT EXISTS bronze;  -- Raw data
CREATE SCHEMA IF NOT EXISTS silver;  -- Cleaned data  
CREATE SCHEMA IF NOT EXISTS gold;    -- Business data

