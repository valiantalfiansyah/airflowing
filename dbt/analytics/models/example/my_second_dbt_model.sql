-- Use the `ref` function to select from other models
-- Comment out the lines below to select from your first model
SELECT id
FROM {{ ref('my_first_dbt_model') }}
WHERE id = 1
