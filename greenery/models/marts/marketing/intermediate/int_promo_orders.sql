{{
    config(
        materialized = 'table'
    )
}}

SELECT
    promo_id,
    order_id,
    user_id,
    created_at,
    discount,
    order_cost,
    shipping_cost,
    order_total

FROM {{ref('fct_promos')}}
LEFT JOIN {{ref('fct_orders')}} USING(promo_id)
