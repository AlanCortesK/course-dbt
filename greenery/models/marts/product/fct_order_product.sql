{{
    config(
        materialized = 'table'
    )
}}

SELECT
    order_id,
    user_id,
    max(ordered_at) as ordered_at,
    sum(price) as total_price,
    array_agg(distinct(product_name)) as product_names,
    sum(quantity) as n_order_items

FROM {{ref('int_order_product')}}

GROUP BY order_id, user_id