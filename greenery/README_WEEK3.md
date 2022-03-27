# Aswers to week3 questions

## PART 1: Create new models to answer the first two questions 

My new models are:

- fct_events_agg: Waterfall information for each session
- int_events_orders_product: Events with added product information for event_type = 'checkout'


**What is our overall conversion rate??**
0.62456747404844290657

code:
```` sql
select
sum(checked_out::int) * 1.0 / count(distinct(session_id)) as conversion_rate
from dbt_alan_c.fct_events_agg;

````

**What is our conversion rate by product?**

| Product Name        | Conversion Rate        |
|---------------------|------------------------|
| Alocasia Polly      | 0.41176470588235294118 |
| Aloe Vera           | 0.49230769230769230769 |
| Angel Wings Begonia | 0.39344262295081967213 |
| Arrow Head          | 0.55555555555555555556 |
| Bamboo              | 0.53731343283582089552 |
| Bird of Paradise    | 0.45000000000000000000 |
| Birds Nest Fern     | 0.42307692307692307692 |
| Boston Fern         | 0.41269841269841269841 |
| Cactus              | 0.54545454545454545455 |
| Calathea Makoyana   | 0.50943396226415094340 |
| Devil's Ivy         | 0.48888888888888888889 |
| Dragon Tree         | 0.46774193548387096774 |
| Ficus               | 0.42647058823529411765 |
| Fiddle Leaf Fig     | 0.50000000000000000000 |
| Jade Plant          | 0.47826086956521739130 |
| Majesty Palm        | 0.49253731343283582090 |
| Money Tree          | 0.46428571428571428571 |
| Monstera            | 0.51020408163265306122 |
| Orchid              | 0.45333333333333333333 |
| Peace Lily          | 0.40909090909090909091 |
| Philodendron        | 0.48387096774193548387 |
| Pilea Peperomioides | 0.47457627118644067797 |
| Pink Anthurium      | 0.41891891891891891892 |
| Ponytail Palm       | 0.40000000000000000000 |
| Pothos              | 0.34426229508196721311 |
| Rubber Plant        | 0.51851851851851851852 |
| Snake Plant         | 0.39726027397260273973 |
| Spider Plant        | 0.47457627118644067797 |
| String of pearls    | 0.60937500000000000000 |
| ZZ Plant            | 0.53968253968253968254 |

code:
```` sql
select
product_name,
COUNT(DISTINCT(CASE WHEN event_type = 'checkout' THEN session_id END)) * 1.0 /
COUNT(DISTINCT(session_id)) as conversion_rate_product
from dbt_alan_c.int_events_orders_product
group by product_name;
````

## PART 2: Create a macro

A macro called get_distinct_values was created.

The macro was implemented in model "marts/marketing/fct_events_agg.sql"


Macro code:

```` sql

{% macro get_distinct_values(model, column_name) %}

{% set distinct_query %}
select distinct
{{column_name}}
from {{model}}
order by 1
{% endset %}

{% set results = run_query(distinct_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}

````

## PART 3: Add a post hook to your project to apply grants to the role “reporting”.

**Done**

## PART 4: Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

star from dbt-utils was implemented in model "marts/core/dim_users.sql" to simplify the code

code:

```` sql

SELECT 
    {{ dbt_utils.star(from=ref('stg_users'), except=["created_at", "updated_at", "address_id"]) }},
    created_at as registered_at,
    {{ dbt_utils.star(from=ref('stg_addresses'), except=["address_id"]) }}
FROM {{ref('stg_users')}}
LEFT JOIN {{ref('stg_addresses')}} USING(address_id)

````
