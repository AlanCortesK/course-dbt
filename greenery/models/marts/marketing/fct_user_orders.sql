{{
    config(
        materialized = 'table'
    )
}}

SELECT
    user_id,
    first_name,
    last_name,
    state,
    country,
    COUNT(DISTINCT(order_id)) as n_orders,
    min(created_at) as first_order_at,
    max(created_at) as last_order_at,
    sum(n_order_items) as n_items_purchased,
    sum(total_price) as products_total_price

FROM {{ref('int_user_orders')}}
GROUP BY user_id, first_name, last_name, state, country