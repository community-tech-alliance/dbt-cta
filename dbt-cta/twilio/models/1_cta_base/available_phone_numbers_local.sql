{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    partitions=partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('available_phone_numbers_local_ab3') }}
select
    beta,
    lata,
    region,
    latitude,
    locality,
    longitude,
    iso_country,
    postal_code,
    rate_center,
    {{ json_extract_scalar('capabilities', ['MMS'], ['MMS']) }} as capabilities_MMS,
    {{ json_extract_scalar('capabilities', ['SMS'], ['SMS']) }} as capabilities_SMS,
    {{ json_extract_scalar('capabilities', ['voice'], ['voice']) }} as capabilities_voice,
    phone_number,
    friendly_name,
    address_requirements,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_available_phone_numbers_local_hashid
from {{ ref('available_phone_numbers_local_ab3') }}
-- available_phone_numbers_local from {{ source('cta', '_airbyte_raw_available_phone_numbers_local') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

