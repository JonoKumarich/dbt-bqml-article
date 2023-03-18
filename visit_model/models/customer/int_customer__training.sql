{{ config(materialized="incremental") }}

with

features as (
    select * from {{ ref('stg_customer__features') }}
),

labels as (
    select * from {{ ref('stg_customer__labels') }}
),

training as (
    select *
    from features
    inner join labels
        using (customer_id, week_start_date)
    {% if is_incremental() %}
    where week_start_date > (select max(week_start_date) from {{ this }})
    {% endif %}
)

select * from training