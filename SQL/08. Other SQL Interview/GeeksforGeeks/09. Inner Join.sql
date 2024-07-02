-- Inner Join
 -- Example:
 -- Display transactions, products and types for produce and dairy items
 
 SELECT 
 transaction_id
, product_name
, product_type
FROM tutorial.excel_sql_transaction_data
INNER JOIN tutorial.excel_sql_inventory_data
ON excel_sql_transaction_data.product_id = excel_sql_inventory_data.product_id
WHERE product_type IN ('produce', 'dairy')

-- Display count of product type at the transaction level:
 SELECT 
 transaction_id
, product_type
, COUNT(*) AS count_product_types
FROM tutorial.excel_sql_transaction_data
INNER JOIN tutorial.excel_sql_inventory_data
ON excel_sql_transaction_data.product_id = excel_sql_inventory_data.product_id
WHERE product_type IN ('produce', 'dairy')
GROUP BY 1, 2
ORDER BY 1


 SELECT 
product_name
, COUNT(*) AS count_product_types
FROM tutorial.excel_sql_transaction_data
INNER JOIN tutorial.excel_sql_inventory_data
ON excel_sql_transaction_data.product_id = excel_sql_inventory_data.product_id
WHERE product_type IN ('produce', 'dairy')
GROUP BY  product_name
ORDER BY count_product_types desc 


-- Additional notes on inner join:
-- Right and Left tables are joined on records where there is a match on both sides
-- Non-matching records on either side are not returned