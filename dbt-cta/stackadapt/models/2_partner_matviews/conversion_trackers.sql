{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
SELECT * FROM {{ source('cta','conversion_trackers_base') }}