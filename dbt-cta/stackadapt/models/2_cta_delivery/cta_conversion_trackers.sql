{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
select * from {{ source('cta','conversion_trackers_base') }}
