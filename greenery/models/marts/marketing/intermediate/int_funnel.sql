{{
    config(
        materialized = 'table'
    )
}}

WITH t1 as (
SELECT 
created_at,
COUNT(DISTINCT(CASE WHEN has_page_view or has_add_to_cart or has_page_view THEN session_id END)) AS funnel_level_1,
COUNT(DISTINCT(CASE WHEN has_add_to_cart or has_checkout THEN session_id END)) AS funnel_level_2,
COUNT(DISTINCT(CASE WHEN has_checkout THEN session_id END)) AS funnel_level_3,

(COUNT(DISTINCT(CASE WHEN has_page_view or has_add_to_cart or has_page_view THEN session_id END)) -
COUNT(DISTINCT(CASE WHEN has_add_to_cart or has_checkout THEN session_id END))) * 100.0 / 
COUNT(DISTINCT(CASE WHEN has_page_view or has_add_to_cart or has_page_view THEN session_id END)) AS fall_level_1_2,


(COUNT(DISTINCT(CASE WHEN has_add_to_cart or has_checkout THEN session_id END))-
COUNT(DISTINCT(CASE WHEN has_checkout THEN session_id END))) * 100.0 /
COUNT(DISTINCT(CASE WHEN has_add_to_cart or has_checkout THEN session_id END)) AS fall_level_2_3


FROM dbt_alan_c.fct_events_agg
GROUP BY created_at
)

SELECT
*
FROM t1