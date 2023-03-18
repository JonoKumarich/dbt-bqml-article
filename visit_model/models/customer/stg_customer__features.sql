{{ config(materialized="view") }}

with

source as (
    select * from {{ source('visit_model', 'customer_features') }}
),

renamed as (
    select
        customer_id,
        week_start_date,
        weeks_since_last_shopped,
        last_shop_spend_total,
    from source
)

select * from renamed