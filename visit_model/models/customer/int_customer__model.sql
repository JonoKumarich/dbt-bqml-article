{{ config(
    materialized="model",
    ml_config={
        "model_type": "logistic_reg",
        "input_label_cols": ["has_customer_shopped"]
    }
) }}

with

training as (
    select
        weeks_since_last_shopped,
        last_shop_spend_total,
        has_customer_shopped,
    from {{ ref('int_customer__training') }}
)

select * from training