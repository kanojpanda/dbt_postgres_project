
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
        first_name,
        last_name,
        email,
        created_at,
        updated_at
FROM {{ source('raw_data', 'customers') }}
)

SELECT
    id,
    first_name,
    last_name,
    email,
    created_at,
    updated_at
FROM customers_cte


/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
