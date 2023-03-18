{{ config(
    materialized='table'
) }}

with 

prediction_inputs as (
    select * from {{ ref('stg_customer__features') }}
),

predictions as (
    select *
    from {{ dbt_ml.predict(ref('int_customer__model'), 'prediction_inputs') }}
    {% if is_incremental() %}
    where week_start_date > (select max(week_start_date) from {{ this }})
    {% endif %}
)

select * from predictions