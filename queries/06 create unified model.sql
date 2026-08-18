create database if not exists analytics
character set utf8mb4
collate utf8mb4_unicode_ci;

create table if not exists analytics.fact_sales (
    sale_line_id bigint unsigned not null auto_increment, primary key (sale_line_id),
    source_system varchar(20) not null,
    source_transaction_id bigint not null, 
    unique key uq_source_transaction (source_system, source_transaction_id),
    source_document_id bigint null,
    source_customer_id bigint null,
    source_product_id bigint null,
    transaction_date datetime null,
    quantity decimal(18,4) not null,
    unit_price decimal(19,4) not null,
    discount_rate decimal(10,4) not null default 0,
    gross_sales decimal(19,4) not null,
    net_sales decimal(19,4) not null,
    is_valid tinyint(1) not null default 1,
    quality_issue varchar(255) null,
    loaded_at timestamp not null default current_timestamp
);