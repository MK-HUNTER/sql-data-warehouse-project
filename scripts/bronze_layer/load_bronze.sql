
/*
===============================================================================
 Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This script loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `COPY` command to load data from CSV files to bronze tables.

===============================================================================
*/


    TRUNCATE bronze.crm_cust_info;
    \copy bronze.crm_cust_info FROM 'cust_info.csv' CSV HEADER;

    TRUNCATE bronze.crm_prd_info;
    \copy bronze.crm_prd_info FROM 'prd_info.csv' CSV HEADER;

    TRUNCATE bronze.crm_sales_details;
    \copy bronze.crm_sales_details FROM 'sales_details.csv' CSV HEADER;

    TRUNCATE bronze.erp_cust_az12;
    \copy bronze.erp_cust_az12 FROM 'cust_az12.csv' CSV HEADER;

    TRUNCATE bronze.erp_loc_a101;
    \copy bronze.erp_loc_a101 FROM 'loc_a101.csv' CSV HEADER;

    TRUNCATE bronze.erp_px_cat_g1v2;
    \copy bronze.erp_px_cat_g1v2 FROM 'px_cat_g1v2.csv' CSV HEADER;
