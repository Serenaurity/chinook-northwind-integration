create database if not exists omni_int
character set utf8mb4
collate utf8mb4_unicode_ci;

USE omni_int;

create table if not exists chinook_sales_lines (
	staging_id bigint unsigned not null auto_increment, primary key (staging_id),
    source_system varchar(20) not null default 'chinook',
    source_transaction_id bigint not null, unique key uq_chinook_transaction (source_transaction_id),
    source_document_id bigint not null,
    source_customer_id int null,
    source_product_id int null,
    transaction_date datetime null,
    quantity decimal(18,4) not null,
    unit_price decimal(19,4) not null,
    discount decimal(10,4) not null default 0,
    net_sales decimal(19,4) not null,
    loaded_at timestamp not null default current_timestamp
    );
    
create table if not exists northwind_sales_lines (
	staging_id bigint unsigned not null auto_increment, primary key (staging_id),
    source_system varchar(20) not null default 'northwind',
    source_transaction_id bigint not null, unique key uq_northwind_transaction (source_transaction_id),
    source_document_id bigint not null,
    source_customer_id int null,
    source_product_id int null,
    transaction_date datetime null,
    quantity decimal(18,4) not null,
    unit_price decimal(19,4) not null,
    discount decimal(10,4) not null default 0,
    net_sales decimal(19,4) not null,
    loaded_at timestamp not null default current_timestamp
    );
    
show tables from omni_int;

describe omni_int.chinook_sales_lines;
describe omni_int.northwind_sales_lines;
    