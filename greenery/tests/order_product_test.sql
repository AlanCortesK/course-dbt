SELECT
    *
FROM {{ref('fct_order_product')}}
WHERE n_order_items <= 0