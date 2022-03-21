{{
  config(
    materialized = 'table'
  )
}}

SELECT 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at as registered_at,
    address,
    zipcode,
    state,
    country
FROM {{ref('stg_users')}}
LEFT JOIN {{ref('stg_addresses')}} USING(address_id)