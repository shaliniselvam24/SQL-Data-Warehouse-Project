/*
====================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
====================================================================================
Script Purpose:
     This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    -Truncates the bronze tables before loading data
    -Uses the 'BULK INSERT' command to load data from csv files to bronze tables.
Parameters:
   None.
Usage Example:
   EXEC bronze.load_bronze;
=====================================================================================
*/
create or alter procedure bronze.load_bronze as
begin 
    DECLARE @start_time datetime ,@end_time datetime
  begin try
     print '==================================='
     print 'Loading Bronze Layer'
     print '==================================='
     print '-----------------------------------'
     print 'Loading CRM table'
     print '-----------------------------------'

     set @start_time= GETDATE();
     print'>> Truncating Table:bronze.crm_cust_info'
     truncate table bronze.crm_cust_info

print'>>Inserting Data into : bronze.crm_cust_info'
bulk insert  bronze.crm_cust_info
from 'C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
    firstrow=2,
    fieldterminator=',',
    tablock
);
 set @end_time= GETDATE();
 print'>>Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'

 set @start_time= GETDATE();
 print'>> Truncating Table:bronze.crm_prd_info'
truncate table bronze.crm_prd_info;

print'>>Inserting Data into :  bronze.crm_prd_info'

bulk insert  bronze.crm_prd_info
from 'C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
    firstrow=2,
    fieldterminator=',',
    tablock
); set @end_time= GETDATE();
 print'>>Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'


set @start_time= GETDATE();
 print'>> Truncating Table:bronze.crm_sales_details'
truncate table bronze.crm_sales_details;

print'>>Inserting Data into :bronze.crm_sales_details'

bulk insert  bronze.crm_sales_details
from 'C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
    firstrow=2,
    fieldterminator=',',
    tablock
); set @end_time= GETDATE();
 print'>>Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'


       print '---------------------------------'
       print 'Loading ERP table'
       print '---------------------------------'

set @start_time= GETDATE();
        print'>> Truncating Table:bronze.erp_cust_az12'
truncate table bronze.erp_cust_az12;

print'>>Inserting Data into : bronze.erp_cust_az12'

bulk insert  bronze.erp_cust_az12
from 'C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with (
    firstrow=2,
    fieldterminator=',',
    tablock
); set @end_time= GETDATE();
 print'>>Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'


set @start_time= GETDATE();
 print'>> Truncating Table:bronze.erp_loc_a101'
truncate table bronze.erp_loc_a101;
print'>>Inserting Data into : bronze.erp_loc_a101'

bulk insert  bronze.erp_loc_a101
from 'C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with (
    firstrow=2,
    fieldterminator=',',
    tablock
); set @end_time= GETDATE();
 print'>>Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'

set @start_time= GETDATE();
 print'>> Truncating Table:bronze.erp_px_cat_g1v2'
truncate table bronze.erp_px_cat_g1v2;

print'>>Inserting Data into :bronze.erp_px_cat_g1v2'

bulk insert  bronze.erp_px_cat_g1v2
from 'C:\Users\user\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with (
    firstrow=2,
    fieldterminator=',',
    tablock
); set @end_time= GETDATE();
 print'>>Load Duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'

end try
begin catch
      print'========================='
      print'ERROR OCCURED DURING LOADING BRONZE LAYER'
      print'error message'+ ERROR_MESSAGE()
      print'error message'+ cast(ERROR_NUMBER() as nvarchar)
      print'========================='
end catch
end
