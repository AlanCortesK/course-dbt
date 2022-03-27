{{
  config(
    materialized = 'table'
  )
}}

SELECT 
    {{ dbt_utils.star(from=ref('stg_users'), except=["created_at", "updated_at", "address_id"]) }},
    created_at as registered_at,
    {{ dbt_utils.star(from=ref('stg_addresses'), except=["address_id"]) }}
FROM {{ref('stg_users')}}
LEFT JOIN {{ref('stg_addresses')}} USING(address_id)