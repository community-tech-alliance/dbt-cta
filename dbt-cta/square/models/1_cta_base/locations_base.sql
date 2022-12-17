{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('locations_ab3') }}
select
    id,
    mcc,
    name,
    type,
    status,
    address,
    country,
    currency,
    timezone,
    created_at,
    description,
    merchant_id,
    website_url,
    capabilities,
    facebook_url,
    phone_number,
    business_name,
    language_code,
    business_email,
    business_hours,
    twitter_username,
    instagram_username,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_locations_hashid
from {{ ref('locations_ab3') }}
-- locations from {{ source('cta', '_airbyte_raw_locations') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

