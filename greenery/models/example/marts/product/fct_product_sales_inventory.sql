{{
    config(
        materialized = 'table'
    )
}}

WITH product_sales_running_avg as (

    SELECT
        product_id,
        avg(n_products_sold) as n_products_sold_avg

    FROM {{ref('fct_product_sales_agg')}}
    WHERE order_date > current_date - interval '7' day
    GROUP BY product_id
)

SELECT

product_id,
n_products_sold_avg,
inventory

FROM product_sales_running_avg
LEFT JOIN {{ref('dim_products')}} using(product_id)
