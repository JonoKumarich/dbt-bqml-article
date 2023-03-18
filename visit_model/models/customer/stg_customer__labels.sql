{{ config(materialized="view") }}

with

source as (
    select * from {{ source('visit_model', 'customer_features') }}
),

renamed as (
    select
        customer_id,
        date_sub(week_start_date, interval 1 week) as week_start_date,
        if(weeks_since_last_shopped = 1, true, false) as has_customer_shopped,
    from source
)

select * from renamed