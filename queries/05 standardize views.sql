create or replace view omni_int.vw_chinook_sales_standardized as

select	source_system , 
		cast(source_transaction_id as unsigned) as source_transaction_id,
		cast(source_document_id as unsigned) as source_document_id,
		cast(source_customer_id as unsigned) as source_customer_id,
		cast(source_product_id as unsigned) as source_product_id,
        transaction_date,
        cast(quantity as decimal(18,4)) as quantity,
        cast(unit_price as decimal(19,4)) as unit_price,
        cast(discount as decimal(10,4)) as discount_rate,
        cast(quantity * unit_price as decimal(19,4)) as gross_sales,
        cast(net_sales as decimal(19,4)) as net_sales
from omni_int.chinook_sales_lines;


create or replace view omni_int.vw_northwind_sales_standardized as

select	source_system , 
		cast(source_transaction_id as unsigned) as source_transaction_id,
		cast(source_document_id as unsigned) as source_document_id,
		cast(source_customer_id as unsigned) as source_customer_id,
		cast(source_product_id as unsigned) as source_product_id,
        transaction_date,
        cast(quantity as decimal(18,4)) as quantity,
        cast(unit_price as decimal(19,4)) as unit_price,
        cast(discount as decimal(10,4)) as discount_rate,
        cast(quantity * unit_price as decimal(19,4)) as gross_sales,
        cast(net_sales as decimal(19,4)) as net_sales
from omni_int.northwind_sales_lines;   


select * from omni_int.vw_chinook_sales_standardized
limit 5;  

select * from omni_int.vw_northwind_sales_standardized
limit 5;  