# Source Mapping

## Sales Grain

| Source | Sales Line Table | Grain |
|---|---|---|
| Chinook | InvoiceLine | One row per invoice line |
| Northwind | order_details | One row per order line |

## Canonical Fields

| Canonical Field | Chinook | Northwind |
|---|---|---|
| source_system | `'chinook'` | `'northwind'` |
| source_transaction_id | InvoiceLineId | order_details.id |
| source_document_id | InvoiceId | order_id |
| source_customer_id | Invoice.CustomerId | orders.customer_id |
| source_product_id | TrackId | product_id |
| transaction_date | Invoice.InvoiceDate | orders.order_date |
| quantity | InvoiceLine.Quantity | order_details.quantity |
| unit_price | InvoiceLine.UnitPrice | order_details.unit_price |
| discount | 0 | order_details.discount |
| net_sales | Quantity × UnitPrice | Quantity × UnitPrice × (1 - Discount) |

## Important Notes

- IDs from Chinook and Northwind are source-specific.
- Customer IDs and product IDs must not be merged directly.
- Each record must retain its `source_system`.
- Revenue values should not be compared directly without checking currency and business context.