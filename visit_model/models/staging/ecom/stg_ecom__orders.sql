WITH source AS (
    SELECT * FROM {{ source('thelook_ecommerce', 'orders') }}
),

renamed AS (
    SELECT
        user_id,
        DATE_TRUNC(created_at, WEEK(MONDAY)) AS week_start_date,
        num_of_item AS quantity,
    FROM source
)

SELECT * FROM renamed