truncate table analytics.fact_sales;

insert into analytics.fact_sales (
    source_system, source_transaction_id,
    source_document_id, source_customer_id,
    source_product_id, transaction_date,
    quantity, unit_price, discount_rate,
    gross_sales, net_sales,
    is_valid, quality_issue
)

select	s.source_system, s.source_transaction_id,
		s.source_document_id, s.source_customer_id,
		s.source_product_id, s.transaction_date,
		s.quantity, s.unit_price, s.discount_rate, 
        s.gross_sales, s.net_sales,

	case
        when 	s.transaction_date is null
		or 		s.quantity <= 0
		or 		s.unit_price < 0
		or		s.discount_rate < 0
		or 		s.discount_rate > 1
		or 		s.net_sales < 0
        then 0 else 1
    end as is_valid,

    nullif(concat_ws('; ',
			if(s.transaction_date is null, 'missing_date', null),
			if(s.quantity <= 0, 'invalid_quantity', null),
            if(s.unit_price < 0, 'invalid_unit_price', null),
            if(s.discount_rate < 0 or s.discount_rate > 1, 'invalid_discount', null),
            if(s.net_sales < 0, 'negative_sales', null)), '') as quality_issue

from (
	select	
		source_system, source_transaction_id,
        source_document_id, source_customer_id,
        source_product_id, transaction_date,
        quantity, unit_price, discount_rate,
		gross_sales, net_sales
	from omni_int.vw_chinook_sales_standardized

    union all

    select	source_system, source_transaction_id,
			source_document_id, source_customer_id,
			source_product_id, transaction_date,
			quantity, unit_price, discount_rate,
			gross_sales, net_sales
    from omni_int.vw_northwind_sales_standardized
	) as s;
    
select	source_system,
		count(*) as total_rows,
		sum(is_valid = 1) as valid_rows,
		sum(is_valid = 0) as invalid_rows,
		sum(net_sales) as total_net_sales
from analytics.fact_sales
group by source_system;