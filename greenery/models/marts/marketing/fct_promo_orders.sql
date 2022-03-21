{{
    config(
        materialized = 'table'
    )
}}

SELECT
    promo_id,
    date(created_at) as applied_at,
    count(distinct(order_id)) as n_orders

FROM {{ref('int_promo_orders')}}

GROUP BY promo_id, date(created_at)