# Aswers to week2 questions

## Models

**What is our user repeat rate?**

79.83 %

code:
```` sql
select
COUNT(DISTINCT(CASE WHEN n_orders >= 2 then user_id end)) * 100.0 /
COUNT(DISTINCT(user_id)) as repeat_rate

from dbt_alan_c.fct_user_orders
````

**What are good indicators of a user who will likely purchase again?**

- Users to whom their products were delivered in the expected time
- Users that already recurred in the past
- Users ordering products in large quantities and recurrently

**What about indicators of users who are likely NOT to purchase again?**

- Users to whom their products were delivered late
- Users with refunded orders

**If you had more data, what features would you want to look into to answer this question?**

- Information on refunded orders or cancellations
- Customer experience surveys


**Explain the marts models you added. Why did you organize the models in the way you did?**

- core: dims and facts based on staging models. Only few changes like column names.
    - dim_products
    - dim_users
    - fct_order_items
    - fct_orders
    - fct promos
- marketing: Facts to analize order behaviour at user and promo level. (With their respective intermidate models for joining the data)
    - int_promo_orders: join of promos and orders, so we can know wich orders included wich promo.
    - fct_promo_orders: grouped information at the promo level from the intemerdiate model.
    - int_user_orders: join of order, users and order_product, so we can have information about who submitted each order and what products were purchased.
    - fct_user_orders: grouped information at the user level, number of orders and number of products purchased until now.
- product: Facts that can give us important information the selling behaviour of our products.
    - int_order_product: join between orders, order_items and products.
    - fct_order_product: for each order number of items purchased and the name of the products.
    - fct_product_sales_agg: how many units of each product were sold each day.
    - fct_product_sales_inventory: the average of the units sold per product in the last 7 days, and the inventory of that product, in order to test for the availability of the product in contrast with its demand.

## Tests

**Generic tests**

- Unique, not null, and positive value tests for models in staging and some in marts.

**Singular tests**

- order_product_test: Each order must include at least 1 product.
- product_sales_inventory_test: the average of units sold for each product in the last 7 days is greater that the inventory. This is not a data quality test, but a business rule that can help to manage the availabity of our products.

**Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?**

I didn't find "bad" data


**Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.**

If the test failed, a slack alert is sent to the analytics engineer responsible for the model.