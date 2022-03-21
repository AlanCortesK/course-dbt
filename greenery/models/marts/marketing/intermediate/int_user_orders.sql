{{
    config(
        materialized = 'table'
    )
}}

SELECT
    user_id,
    order_id,
    orders.created_at,
    users.first_name,
    users.last_name,
    users.state,
    users.country,
    orders.order_total,
    order_product.n_order_items,
    order_product.total_price
    
FROM {{ref('fct_orders')}} orders
LEFT JOIN {{ref('dim_users')}} users USING(user_id)
LEFT JOIN {{ref('fct_order_product')}} order_product USING(order_id, user_id)