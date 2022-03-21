SELECT
    product_id
FROM {{ref('fct_product_sales_inventory')}}
WHERE n_products_sold_avg > inventory