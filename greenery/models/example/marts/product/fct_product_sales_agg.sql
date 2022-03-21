{{
    config(
        materialized = 'table'
    )
}}

SELECT
    product_id,
    date(ordered_at) as order_date,
    sum(quantity) as n_products_sold

FROM {{ref('int_order_product')}}

GROUP BY product_id, date(ordered_at)
