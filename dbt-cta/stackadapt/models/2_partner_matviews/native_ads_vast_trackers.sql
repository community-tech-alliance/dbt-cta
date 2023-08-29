{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
select * from {{ source('cta','native_ads_vast_trackers_base') }}
