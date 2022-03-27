{{
    config(
        materialized = 'table'
    )
}}

SELECT
    session_id,
    max(order_id) as order_id,
    count(distinct(order_id)) as n_order_ids,
    count(distinct(product_id)) as products_to_cart,
    BOOL_OR(CASE WHEN event_type = 'page_view' THEN TRUE ELSE FALSE END) AS page_viewed,
    BOOL_OR(CASE WHEN event_type = 'add_to_cart' THEN TRUE ELSE FALSE END) AS added_to_cart,
    BOOL_OR(CASE WHEN event_type = 'checkout' THEN TRUE ELSE FALSE END) AS checked_out,
    BOOL_OR(CASE WHEN event_type = 'package_shipped' THEN TRUE ELSE FALSE END) AS package_shipped
FROM {{ref('stg_events')}}
GROUP BY session_id
