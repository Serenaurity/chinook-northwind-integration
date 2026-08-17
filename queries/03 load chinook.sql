USE omni_int;

truncate table chinook_sales_lines;
insert into chinook_sales_lines (
    source_system, source_transaction_id,
    source_document_id, source_customer_id,
    source_product_id, transaction_date,
    quantity, unit_price, discount, net_sales
)

select 	'chinook',
		il.InvoiceLineId,
        il.InvoiceId,
        i.CustomerId,
        il.TrackId,
        i.InvoiceDate,
        cast(coalesce(il.Quantity, 0) as decimal(18,4)),
        cast(coalesce(il.UnitPrice, 0) as decimal(18,4)), 0.0000,
        cast(coalesce(il.Quantity, 0) * coalesce(il.UnitPrice, 0) as decimal(19,4))
from chinook.InvoiceLine as il
join chinook.Invoice as i on i.InvoiceId = il.InvoiceId;

select count(*) as source_rows
from chinook.InvoiceLine;

select count(*) as staging_rows
from omni_int.chinook_sales_lines;

select count(*) as invalid_rows
from omni_int.chinook_sales_lines 	where transaction_date is null
									or quantity <= 0
                                    or unit_price < 0
                                    or net_sales < 0;

select 	source_transaction_id,
		count(*) as duplicate_count
from omni_int.chinook_sales_lines
group by source_transaction_id
having count(*) > 1;