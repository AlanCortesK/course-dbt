{{
    config(
        materialized = 'table'
    )
}}

SELECT
    session_id,
    order_id,
    event_type,
    COALESCE(e.product_id, op.product_id) as product_id,
    p.product_name

FROM {{ref('stg_events')}} e
LEFT JOIN {{ref('int_order_product')}} op using(order_id)
LEFT JOIN {{ref('dim_products')}} p on COALESCE(e.product_id, op.product_id) = p.product_id