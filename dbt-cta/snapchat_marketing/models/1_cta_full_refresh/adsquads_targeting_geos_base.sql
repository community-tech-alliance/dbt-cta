{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}
{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_geos_hashid'
) }}

-- depends_on: {{ ref('adsquads_targeting_geos_ab3') }}
select
    _airbyte_geos_hashid,
    ad_squad_id,
    country_code,
    operation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    case
        when region_id is not null then 'region'
        when metro is not null then 'metro'
        when postal_code is not null then 'postal_code'
    end as geo_level,
    coalesce(region_id, metro, postal_code) as geo_value,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_targeting_geos_ab3') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
