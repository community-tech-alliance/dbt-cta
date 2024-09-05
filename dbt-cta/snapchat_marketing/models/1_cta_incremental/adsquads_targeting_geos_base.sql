{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_geos_hashid'
) }}

-- depends_on: {{ ref('adsquads_targeting_geos_ab4') }}
select
    _airbyte_geos_hashid,
    ad_squad_id,
    country_code,
    case
        when region_id is not null then 'region'
        when metro is not null then 'metro'
        when postal_code is not null then 'postal_code'
    else null end as geo_level,
    coalesce(region_id,metro,postal_code) as geo_value,
    operation,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_targeting_geos_ab4') }}
