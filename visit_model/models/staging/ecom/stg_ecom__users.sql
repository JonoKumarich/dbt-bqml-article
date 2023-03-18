WITH source AS (
    SELECT * FROM {{ source('thelook_ecommerce', 'users') }}
),

renamed AS (
    SELECT
        id AS user_id,
        CAST(created_at AS DATE) AS sign_up_date,
    FROM source
)

SELECT * FROM renamed