select table_schema, table_name, table_type

from information_schema.tables
where table_schema in ('chinook', 'northwind')
order by table_schema, table_name;

select	table_schema, table_name,
		ordinal_position, column_name,
		data_type, is_nullable
from information_schema.columns
where table_schema in ('chinook', 'northwind')
order by table_schema, table_name, ordinal_position;