{{
    config(
        materialized = 'table'
    )
}}

SELECT
SUM(funnel_level_1) as funnel_level_1,
SUM(funnel_level_2) as funnel_level_2,
SUM(funnel_level_3) as funnel_level_3,
(SUM(funnel_level_1) - SUM(funnel_level_2)) * 100.0 / SUM(funnel_level_1) AS fall_level_1_2,
(SUM(funnel_level_2) - SUM(funnel_level_3)) * 100.0 / SUM(funnel_level_2) AS fall_level_2_3
FROM {{ ref('int_funnel')}}
