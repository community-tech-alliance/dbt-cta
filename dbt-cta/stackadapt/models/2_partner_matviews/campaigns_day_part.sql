{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
SELECT * FROM source('cta','campaigns_day_part_base')