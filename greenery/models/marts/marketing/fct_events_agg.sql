{{
    config(
        materialized = 'table'
    )
}}

{% set event_types = get_distinct_values(ref('stg_events'), 'event_type') %}

SELECT
    session_id
    , max(order_id) as order_id
    , count(distinct(order_id)) as n_order_ids
    , count(distinct(product_id)) as products_to_cart
    {% for event_type in event_types %}
    , BOOL_OR(CASE WHEN event_type = '{{event_type}}' THEN TRUE ELSE FALSE END) AS has_{{event_type}}
    {% endfor %}
FROM {{ref('stg_events')}}
GROUP BY session_id
