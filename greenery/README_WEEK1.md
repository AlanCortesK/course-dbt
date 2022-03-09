# Aswers to week1 questions

**How many users do we have?**

130

code:
```
{
    SELECT 
    COUNT(DISTINCT(user_id)) as n_users
    FROM dbt_alan_c.stg_users

```

**On average, how many orders do we receive per hour?**
7.5

code:
```
{
    WITH orders_per_hour as 
    (
    SELECT 
    date_trunc('hour', created_at) as created_at_hour,
    count(distinct(order_id)) as n_orders
    
    FROM dbt_alan_c.stg_orders
    GROUP BY created_at_hour
    )

    SELECT
    AVG(n_orders) as avg_oders_hour
    FROM orders_per_hour
}

```

Considering that may be hour in wich we have 0 orders, we can use this code instead:

code:
```
{
    WITH t1 as (

    SELECT 
    date_part('day',max(date_trunc('hour',created_at)) - min(date_trunc('hour',created_at))) * 24 +
    date_part('hour',max(date_trunc('hour',created_at)) - min(date_trunc('hour',created_at))) + 1 n_diff 
    FROM dbt_alan_c.stg_orders
    )

    SELECT
    COUNT(DISTINCT(order_id)) / n_diff
    FROM dbt_alan_c.stg_orders
    LEFT JOIN t1 on TRUE
    GROUP BY n_diff
}

```

**On average, how long does an order take from being placed to being delivered?**

3 days 21:24:11.803279

code:
```
{
    SELECT 
    AVG(delivered_at - created_at) as day_diff

    FROM dbt_alan_c.stg_orders
    WHERE status = 'delivered'
}

```

**How many users have only made one purchase? Two purchases? Three+ purchases?**

| Number of purchases | Number of Users |
|---------------------|-----------------|
| 1                   | 25              |
| 2                   | 28              |
| 3                   | 34              |
| 4                   | 20              |
| 5                   | 10              |
| 6                   | 2               |
| 7                   | 3               |
| 8                   | 1               |

code:
```
{
    WITH users_orders as (

    SELECT 
    user_id,
    count(distinct(order_id)) as n_orders
    FROM dbt_alan_c.stg_orders
    GROUP BY user_id
    )

    SELECT
    n_orders,
    count(distinct(user_id))
    FROM users_orders
    GROUP BY n_orders
}

```

**On average, how many unique sessions do we have per hour?**

16.3275862068965517

code:
```
{
    WITH sessions_per_hour as (

    SELECT 
    date_trunc('hour',created_at) as created_at_hour,
    count(distinct(session_id)) as n_sessions
    FROM dbt_alan_c.stg_events
    GROUP BY created_at_hour
    )

    SELECT
    AVG(n_sessions) as avg_sessions
    FROM sessions_per_hour
}

```