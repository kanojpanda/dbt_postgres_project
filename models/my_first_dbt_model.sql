
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}


-- models/my_first_model.sql

WITH customers_cte AS (
    SELECT
        id,
        name,
        email,
        created_at 
    -- FROM customers
    FROM {{ source('raw_data', 'customers') }}
),

orders_cte AS (
    SELECT
        id,
        customer_id,
        order_date,
        status
	--FROM orders
    FROM {{ source('raw_data', 'orders') }}
),

payments_cte AS (
    SELECT
        id,
        order_id,
        amount,
        payment_date,
        method
	--FROM payments
    FROM {{ source('raw_data', 'payments') }}
)

SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    c.email,
    c.created_at AS customer_since,
    o.id AS order_id,
    o.order_date,
    o.status AS order_status,
    p.id AS payment_id,
    p.amount,
    p.payment_date,
    p.method AS payment_method
FROM customers_cte c
LEFT JOIN orders_cte o ON c.id = o.customer_id
LEFT JOIN payments_cte p ON o.id = p.order_id
ORDER BY c.id, o.id, p.id


/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
