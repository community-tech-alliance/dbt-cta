{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
select * from {{ source('cta','native_ads_input_data_base') }}
