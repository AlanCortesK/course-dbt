# Aswers to week4 questions

## Part 1. dbt Snapshots

Were you able to add snapshots against the orders data? Did you see any data change?

Yes, the status changed for some order_ids


code:
```` sql
{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='check',
      check_cols=['status'],
    )
  }}

  SELECT * FROM {{ source('greenery','orders') }}

{% endsnapshot %}

````

## Part 2. Modeling challenge

How are our users moving through the product funnel?
- The global product funnel looks like this:

| funnel_level_1 | funnel_level_2 | funnel_level_2 | fall_level_1_2      | fall_level_2_3      |
|----------------|----------------|----------------|---------------------|---------------------|
| 578            | 467            | 361            | 19.2041522491349481 | 22.6980728051391863 |

Which steps in the funnel have largest drop off points?
- From funnel step 2 to funnel step 3

To anwer these questions 2 new models were created:
- int_funnel
- fct_funnel_agg

int_funnel is also aggregated by day, so we can check if this numbers change over time

## Part 3. Reflection questions -- please answer 3A or 3B, or both!

### 3A. dbt next steps for you 
**Reflecting on your learning in this class...**

**if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?**
- Explaning that dbt automates a lot of the work we are currently doing but in a more robust and efficient way


**if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?**
- using git for colaborating, and dbt in order to improve the governance of the models