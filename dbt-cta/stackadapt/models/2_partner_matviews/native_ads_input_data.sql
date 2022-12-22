{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
SELECT * FROM source('cta','native_ads_input_data_base')