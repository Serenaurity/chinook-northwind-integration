USE omni_int;

truncate table northwind_sales_lines;
insert into northwind_sales_lines (
    source_system, source_transaction_id,
    source_document_id, source_customer_id,
    source_product_id, transaction_date,
    quantity, unit_price, discount, net_sales
)

select 	'northwind',
		od.id, od.order_id,
        o.customer_id, od.product_id,
        o.order_date,
        cast(coalesce(od.quantity, 0) as decimal(18,4)),
        cast(coalesce(od.unit_price, 0) as decimal(19,4)),
        cast(coalesce(od.discount, 0) as decimal(10,4)),        
        cast(coalesce(od.quantity, 0) 
			* coalesce(od.unit_price, 0)
            * (1 - coalesce(od.discount, 0))as decimal(19,4))
from northwind.order_details as od
left join northwind.orders as o on o.id = od.order_id;

select count(*) as source_rows
from northwind.order_details;

select count(*) as staging_rows
from omni_int.northwind_sales_lines;

select	count(*) as total_rows,
		sum(transaction_date is null) as missing_dates,
		sum(quantity <= 0) as invalid_quantity,
		sum(unit_price < 0) as invalid_unit_price,
		sum(discount < 0 or discount > 1) as invalid_discount,
		sum(net_sales < 0) as negative_sales
from omni_int.northwind_sales_lines;

select 	source_transaction_id,
		count(*) as duplicate_count
from omni_int.northwind_sales_lines
group by source_transaction_id
having count(*) > 1;